module "docker" {
    source = "../docker"

    is_master   = true
    tags        = [ "docker", "docker_master" ]

    scaleway_organization = "${var.scaleway_organization}"
    scaleway_api_token    = "${var.scaleway_api_token}"
    
    ssh_root_private_key = "${var.ssh_root_private_key}"
    ssh_root_public_key  = "${var.ssh_root_public_key}"
    ssh_tech_public_key  = "${var.ssh_tech_public_key}"
}