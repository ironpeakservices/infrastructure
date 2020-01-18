module "scaleway" {
    source                  = "./modules/scaleway"

    organization            = "${var.scaleway_org}"
    access_key              = "${var.scaleway_accesstoken}"
    secret_key              = "${var.scaleway_secrettoken}"

    ssh_root_public_key     = "${var.ssh_root_public_key}"
    ssh_root_private_key    = "${var.ssh_root_private_key}"

    ssh_tech_public_key     = "${var.ssh_tech_public_key}"
}

module "cloudflare" {
    source                  = "./modules/cloudflare"
    
    cloudflare_email        = "${var.cloudflare_email}"
    cloudflare_token        = "${var.cloudflare_token}"
}

module "github" {
    source                  = "./modules/github"

    github_token            = "${var.github_token}"
    github_organization     = "${var.github_org}"
}