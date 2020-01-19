module "kubernetes" {
    source                  = "./modules/kubernetes"

    scaleway_accesstoken    = var.scaleway_accesstoken
    scaleway_secrettoken    = var.scaleway_secrettoken
}

module "cloudflare" {
    source                  = "./modules/cloudflare"
    
    cloudflare_token        = var.cloudflare_token
}

module "github" {
    source                  = "./modules/github"

    github_token            = var.github_token
    github_organization     = var.github_org
}