# public ip address for scaleway instance
resource "scaleway_ip" "node_ip" {
  count = "${var.instance_count}"
}

# scaleway instance
resource "scaleway_server" "instance" {

  count          = "${var.instance_count}"
  name           = "${terraform.workspace}-manager-${count.index + 1}"
  image          = "${data.scaleway_image.docker.id}"
  type           = "${var.manager_instance_type}"
  security_group = "${scaleway_security_group.swarm_managers.id}"
  public_ip      = "${element(scaleway_ip.swarm_manager_ip.*.ip, count.index)}"
  tags           = var.tags

  # how to connect to scaleway instance
  connection {
    host = "${element(scaleway_ip.node_ip.*.ip, count.index)}"
    type = "ssh"
    user = "root"
    private_key = "${var.ssh_root_private_key}"
  }

  # replace the sshd config
  provisioner "file" {
    content     = "${data.template_file.ssh_conf.rendered}"
    destination = "/etc/ssh/sshd_config"
  }

  # secure root
  # add a tech user
  provisioner "remote-exec" {
    inline = [
      "passwd -l root",

      "useradd --groups docker --home-dir /home/tech --create-home --shell /bin/bash tech",
      "mkdir /home/tech/.ssh/",
      "echo '${var.ssh_tech_public_key}' > /home/tech/.ssh/authorized_keys",
      "chown tech:tech -R /home/tech",
      "passwd -l tech",

      "systemctl daemon-reload",
      "systemctl restart ssh",
    ]
  }

}
