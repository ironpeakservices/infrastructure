# /etc/docker/daemon.json
data "template_file" "docker_conf" {
  template = "${file("${path.module}/conf/docker.tpl")}"
}

# systemd docker file
data "template_file" "docker_daemon_json" {
  template = "${file("${path.module}/conf/daemon.tpl")}"

  vars = {
    ip = "${var.docker_api_ip}"
  }
}

# to extract the swarm tokens
data "external" "swarm_tokens" {
    program = ["${path.module}/scripts/fetch-tokens.sh"]

    query = {
        host = "${scaleway_instance_ip.node_ip.0.ip}"
        sshkeypath = "${var.ssh_root_private_key}"
    }

    depends_on = ["scaleway_instance_server.instance"]
}

// ----

locals {
  instanceTcpPorts = ["${var.ssh_port}", 80, 433, 7946]
  instanceUdpPorts = [7946, 4789]
  instance_commands= ["docker swarm join --token ${data.external.swarm_tokens.result.worker} ${scaleway_instance_server.instance.0.private_ip}:2377",]

  managerTcpPorts  = ["${var.ssh_port}", 80, 433, 7946, 2377]
  managerUdpPorts  = [7946, 4789]
  manager_commands = ["docker swarm init --advertise-addr ${scaleway_instance_server.instance.0.public_ip}"]
}

module "node" {
    source = "../node"

    scaleway_organization   = "${var.scaleway_organization}"
    scaleway_api_token      = "${var.scaleway_api_token}"
    ssh_root_private_key    = "${var.ssh_root_private_key}"
    ssh_root_public_key     = "${var.ssh_root_public_key}"
    ssh_tech_public_key     = "${var.ssh_tech_public_key}"
    instance_count          = "${var.instance_count}"
    tags                    = var.tags
    ssh_port                = "${var.ssh_port}"
    commands                = var.is_master ? local.manager_commands : local.instance_commands
    open_tcp_ports          = var.is_master ? local.managerTcpPorts  : local.instanceTcpPorts
    open_udp_ports          = var.is_master ? local.managerUdpPorts  : local.instanceUdpPorts
}

resource "null_resource" "swarm_cluster" {
    # Changes to any instance of the cluster requires re-provisioning
    triggers = {
        server_ids = "${join(",", scaleway_instance_server.instance.*.id)}"
    }

    # Bootstrap script can run on any instance of the cluster
    # So we just choose the first in this case
    connection {
        host = "${element(scaleway_instance_server.instance.*.public_ip, 0)}"
        type = "ssh"
        user = "root"
        private_key = "${var.ssh_root_private_key}"
    }

    # create the directory to
    provisioner "remote-exec" {
        inline = [
            "mkdir /etc/docker/certs",
            "chmod 550 /etc/docker /etc/docker/certs",

            "chmod 400 /etc/docker/* /etc/docker/certs/*",

            "echo 'DOCKER_CONTENT_TRUST=1' | sudo tee -a /etc/environment",

            "useradd --home-dir /home/container --user-group --create-home --shell /bin/true container",
            "chown container:container -R /home/container",
            "passwd -l container"
        ]
    }

    # generate the required swarm certificate & key
    provisioner "local-exec" {
        command = "chmod +x ${path.module}/scripts/tlsgen-node.sh && ${path.module}/scripts/tlsgen-node.sh ${self.private_ip} ${self.public_ip}"
    }

    # install docker swarm ca cert
    provisioner "file" {
        source = "./certs/ca.pem"
        destination = "/etc/docker/certs/ca.pem"
    }

    # install docker swarm private key
    provisioner "file" {
        source = "./certs/${self.private_ip}/server-key.pem"
        destination = "/etc/docker/certs/swarm-priv-key.pem"
    }

    # install docker swarm cert
    provisioner "file" {
        source = "./certs/${self.private_ip}/server-cert.pem"
        destination = "/etc/docker/certs/swarm-cert.pem"
    }

    # create docker systemd directory
    provisioner "remote-exec" {
        inline = [
        "mkdir -p /etc/systemd/system/docker.service.d",
        ]
    }

    # install docker systemd
    provisioner "file" {
        content     = "${data.template_file.docker_conf.rendered}"
        destination = "/etc/systemd/system/docker.service.d/docker.conf"
    }

    # install docker daemon.json
    provisioner "file" {
        content     = "${data.template_file.docker_daemon_json.rendered}"
        destination = "/etc/docker/daemon.json"
    }

    # set more strict permissions on docker directory
    provisioner "remote-exec" {
        inline = [
            "chmod 400 /etc/docker/* /etc/docker/certs/*",
        ]
    }

    # apply auditd configuration for docker services & files
    provisioner "remote-exec" {
        inline = [
            # install auditd
            "apt-get install -y auditd",
            # 1.5  - Ensure auditing is configured for the Docker daemon
            "echo '-w /usr/bin/docker -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules'",
            # 1.6  - Ensure auditing is configured for Docker files and directories - /var/lib/docker
            "echo '-w /var/lib/docker -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
            # 1.7  - Ensure auditing is configured for Docker files and directories - /etc/docker"
            "echo 'echo '-w /etc/docker -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
            # 1.8  - Ensure auditing is configured for Docker files and directories - docker.service
            "echo 'echo '-w /lib/systemd/system/docker.service -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
            # 1.9  - Ensure auditing is configured for Docker files and directories - docker.socket
            "echo 'echo '-w /lib/systemd/system/docker.socket -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
            # 1.10 - Ensure auditing is configured for Docker files and directories - /etc/default/docker
            "echo 'echo '-w /etc/default/docker -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
            # 1.11 - Ensure auditing is configured for Docker files and directories - /etc/docker/daemon.json
            "echo 'echo '-w /etc/docker/daemon.json -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
            # 1.12 - Ensure auditing is configured for Docker files and directories - /usr/bin/docker-containerd
            "echo 'echo '-w /usr/bin/docker-containerd -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
            # 1.13 - Ensure auditing is configured for Docker files and directories - /usr/bin/docker-runc
            "echo 'echo '-w /usr/bin/docker-runc -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
            # now apply those changes
            "sudo service auditd restart",
        ]
    }

    # apply the docker systemd & daemon.json changes
    provisioner "remote-exec" {
        inline = [
            "systemctl daemon-reload",
            "systemctl restart docker",
        ]
    }

    # drain worker on destroy
    provisioner "remote-exec" {
        when = "destroy"

        inline = [
        "docker node update --availability drain ${self.name}",
        ]

        on_failure = "continue"

        connection {
        type = "ssh"
        user = "root"
        host = "${scaleway_ip.swarm_manager_ip.0.ip}"
        }
    }

    # leave swarm on destroy
    provisioner "remote-exec" {
        when = "destroy"

        inline = [
        "docker swarm leave",
        ]

        on_failure = "continue"
    }

    # remove node on destroy
    provisioner "remote-exec" {
        when = "destroy"

        inline = [
        "docker node rm --force ${self.name}",
        ]

        on_failure = "continue"

        connection {
        type = "ssh"
        user = "root"
        host = "${scaleway_ip.swarm_manager_ip.0.ip}"
        }
    }

}