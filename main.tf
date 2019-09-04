
module "scaleway" {
    source                  = "./modules/scaleway"

    organization                 = "${var.scaleway_org}"
    api_token                    = "${var.scaleway_token}"

    ssh_root_public_key_path     = "${var.ssh_public_key_path}"
    ssh_root_private_key_path    = "${var.ssh_private_key_path}"

    ssh_tech_public_key_path     = "${var.ssh_tech_public_key_path}"
}

/*
module "cloudflare" {
    source                  = "./modules/cloudflare"
    
    cloudflare_email        = "${var.cloudflare_email}"
    cloudflare_token        = "${var.cloudflare_token}"
}

module "github" {
    source                  = "./modules/github"

    github_token            = "${var.github_token}"
    github_organization     = "${var.github_organization}"
}
*/