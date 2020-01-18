provider "scaleway" {
  region            = var.region
  zone              = var.zone
  organization_id   = var.organization
  access_key        = var.access_key
  secret_key        = var.secret_key
}

resource "scaleway_account_ssh_key" "scaleway_ssh_public_key" {
    public_key = var.ssh_root_public_key
}

data "scaleway_image" "docker" {
  architecture = var.node_arch
  name         = "Docker"
}

data "template_file" "docker_conf" {
  template = "${file("${path.module}/conf/docker.tpl")}"
}

data "template_file" "docker_daemon_json" {
  template = "${file("${path.module}/conf/daemon.tpl")}"

  vars = {
    ip = var.docker_api_ip
  }
}

data "template_file" "ssh_conf" {
  template = "${file("${path.module}/conf/ssh.tpl")}"

  vars = {
    port = var.ssh_port
  }
}