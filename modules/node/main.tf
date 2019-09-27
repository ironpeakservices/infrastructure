provider "scaleway" {
  region        = "${var.scaleway_region}"
  organization  = "${var.scaleway_organization}"
  token         = "${var.scaleway_api_token}"
}

resource "scaleway_ssh_key" "scaleway_ssh_public_key" {
    key = "${var.ssh_root_public_key}"
}

data "scaleway_image" "docker" {
  architecture = "${var.node_arch}"
  name         = "Docker"
}

data "template_file" "ssh_conf" {
  template = "${file("${path.module}/conf/ssh.tpl")}"

  vars = {
    port = "${var.ssh_port}"
  }
}