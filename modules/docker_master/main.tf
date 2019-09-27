module "docker" {
    source = "../docker"

    is_master   = true
    tags        = [ "docker", "docker_master" ]

    ssh_root_private_key = "${var.ssh_root_private_key}"
    ssh_root_public_key  = "${var.ssh_root_public_key}"
}