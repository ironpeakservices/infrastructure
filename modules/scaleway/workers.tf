resource "scaleway_ip" "swarm_worker_ip" {
  count = "${var.worker_instance_count}"
}

resource "scaleway_server" "swarm_worker" {
  count          = "${var.worker_instance_count}"
  name           = "${terraform.workspace}-worker-${count.index + 1}"
  image          = "${data.scaleway_image.docker.id}"
  type           = "${var.worker_instance_type}"
  security_group = "${scaleway_security_group.swarm_workers.id}"
  public_ip      = "${element(scaleway_ip.swarm_worker_ip.*.ip, count.index)}"
  tags           = ["manager", "docker"]

  connection {
    type = "ssh"
    host = "${element(scaleway_ip.swarm_worker_ip.*.ip, count.index)}"
    user = "root"
    private_key = "${var.ssh_root_private_key}"
  }
  
  provisioner "remote-exec" {
    inline = [
      "mkdir /etc/docker/certs"
    ]
  }

  provisioner "local-exec" {
    command = "chmod +x ${path.module}/scripts/tlsgen-node.sh && ${path.module}/scripts/tlsgen-node.sh ${self.private_ip} ${self.public_ip}"
  }

  provisioner "file" {
    source = "./certs/ca.pem"
    destination = "/etc/docker/certs/ca.pem"
  }
  provisioner "file" {
    source = "./certs/${self.private_ip}/server-key.pem"
    destination = "/etc/docker/certs/swarm-priv-key.pem"
  }
  provisioner "file" {
    source = "./certs/${self.private_ip}/server-cert.pem"
    destination = "/etc/docker/certs/swarm-cert.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /etc/systemd/system/docker.service.d",
    ]
  }

  provisioner "file" {
    content     = "${data.template_file.docker_conf.rendered}"
    destination = "/etc/systemd/system/docker.service.d/docker.conf"
  }

  provisioner "file" {
    content     = "${data.template_file.docker_daemon_json.rendered}"
    destination = "/etc/docker/daemon.json"
  }

  provisioner "file" {
    content     = "${data.template_file.ssh_conf.rendered}"
    destination = "/etc/ssh/sshd_config"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /etc/docker/certs/*",

      "echo 'DOCKER_CONTENT_TRUST=1' | sudo tee -a /etc/environment",

      "passwd -l root",

      "useradd --groups docker --home-dir /home/tech --create-home --shell /bin/bash tech",
      "mkdir /home/tech/.ssh/",
      "echo '${var.ssh_tech_public_key}' > /home/tech/.ssh/authorized_keys",
      "chown tech:tech -R /home/tech",
      "passwd -l tech",
      
      "useradd --home-dir /home/container --user-group --create-home --shell /bin/true container",
      "chown container:container -R /home/container",
      "passwd -l container"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "systemctl daemon-reload",
      "systemctl restart docker",
      "systemctl restart ssh",
      "docker swarm join --token ${data.external.swarm_tokens.result.worker} ${scaleway_server.swarm_manager.0.private_ip}:2377",
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
  depends_on = ["scaleway_server.swarm_manager"]
}

data "external" "swarm_tokens" {
  program = ["${path.module}/scripts/fetch-tokens.sh"]

  query = {
    host = "${scaleway_ip.swarm_manager_ip.0.ip}"
    sshkeypath = "${var.ssh_root_private_key}"
  }

  depends_on = ["scaleway_server.swarm_manager"]
}
