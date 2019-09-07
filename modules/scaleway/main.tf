provider "scaleway" {
  region        = "${var.region}"
  organization  = "${var.organization}"
  token         = "${var.api_token}"
}

resource "scaleway_ssh_key" "scaleway_ssh_public_key" {
    key = "${var.ssh_root_public_key}"
}

data "scaleway_image" "docker" {
  architecture = "x86_64"
  name         = "Docker"
}

data "template_file" "docker_conf" {
  template = "${file("${path.module}/conf/docker.tpl")}"
}

data "template_file" "docker_daemon_json" {
  template = "${file("${path.module}/conf/daemon.tpl")}"

  vars = {
    ip = "${var.docker_api_ip}"
  }
}

data "template_file" "ssh_conf" {
  template = "${file("${path.module}/conf/ssh.tpl")}"

  vars = {
    port = "${var.ssh_port}"
  }
}
