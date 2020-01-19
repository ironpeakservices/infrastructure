module "kubernetes" {
    source                  = "./modules/kubernetes"
}

module "cloudflare" {
    source                  = "./modules/cloudflare"
    
    cloudflare_token        = "${var.cloudflare_token}"
}

module "github" {
    source                  = "./modules/github"

    github_token            = "${var.github_token}"
    github_organization     = "${var.github_org}"
}