
module "scaleway" {
    source                  = "./modules/scaleway"

    api_token               = "${var.api_token}"
    ssh_public_key_path     = "${var.ssh_public_key_path}"
    ssh_private_key_path    = "${var.ssh_private_key_path}"
}
