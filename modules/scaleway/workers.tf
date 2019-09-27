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

  depends_on = ["scaleway_server.swarm_manager"]

  provisioner "file" {
    content     = "${data.template_file.ssh_conf.rendered}"
    destination = "/etc/ssh/sshd_config"
  }

  provisioner "remote-exec" {
    inline = [
      "passwd -l root",

      "useradd --groups docker --home-dir /home/tech --create-home --shell /bin/bash tech",
      "mkdir /home/tech/.ssh/",
      "echo '${var.ssh_tech_public_key}' > /home/tech/.ssh/authorized_keys",
      "chown tech:tech -R /home/tech",
      "passwd -l tech",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "systemctl daemon-reload",
      "systemctl restart ssh",
    ]
  }

  module "docker" {
    source = "../modules/docker"
    
    is_master            = false
    ssh_root_private_key = "${var.ssh_root_private_key}"
    ssh_root_public_key  = "${var.ssh_root_public_key}"


    provisioner "remote-exec" {
      inline = [
          "docker swarm join --token ${data.external.swarm_tokens.result.worker} ${scaleway_server.swarm_manager.0.private_ip}:2377",
      ]
    }
  }

}