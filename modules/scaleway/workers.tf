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
    private_key = "${file("${var.ssh_root_private_key_path}")}"
  }
  
  provisioner "remote-exec" {
    inline = [
      "mkdir /certs"
    ]
  }

  provisioner "file" {
    source = "./certs/ca.pem"
    destination = "/certs/ca.pem"
  }
  provisioner "file" {
    source = "./certs/key.pem"
    destination = "/certs/swarm-priv-key.pem"
  }
  provisioner "file" {
    source = "./certs/cert.pem"
    destination = "/certs/swarm-cert.pem"
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
    content     = "${data.template_file.ssh_conf.rendered}"
    destination = "/etc/ssh/sshd_config"
  }

  provisioner "remote-exec" {
    inline = [
      "systemctl daemon-reload",
      "systemctl restart docker",
      "systemctl restart ssh",
      "docker swarm join --token ${data.external.swarm_tokens.result.worker} ${scaleway_server.swarm_manager.0.private_ip}:2377",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "useradd -G docker -d /home/tech -m -s /bin/bash tech",
      "cp -r /root/.ssh /home/tech",
      "echo '${file("${var.ssh_tech_public_key_path}")}' >> /home/tech/.ssh/authorized_keys",
      "chown tech:tech -R /home/tech",
      "passwd -l tech",
      "passwd -l root"
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
    sshkeypath = "${var.ssh_root_private_key_path}"
  }

  depends_on = ["scaleway_server.swarm_manager"]
}
