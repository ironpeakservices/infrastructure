module "docker" {
    source = "../docker"

    is_master   = false
    tags        = [ "docker", "docker_worker" ]

    ssh_root_private_key = "${var.ssh_root_private_key}"
    ssh_root_public_key  = "${var.ssh_root_public_key}"
}