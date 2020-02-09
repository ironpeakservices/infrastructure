module "scaleway" {
    source                  = "./modules/scaleway"

    scaleway_accesstoken    = var.scaleway_accesstoken
    scaleway_secrettoken    = var.scaleway_secrettoken
    scaleway_organization   = var.scaleway_org
}

module "kubernetes" {
    source                  = "./modules/kubernetes"

    host                    = module.scaleway.kubeconfig[1].host
    token                   = module.scaleway.kubeconfig[1].token
    cluster_ca_certificate  = module.scaleway.kubeconfig[1].cluster_ca_certificate
}

module "cloudflare" {
    source                  = "./modules/cloudflare"
    
    cloudflare_token        = var.cloudflare_token
}

/*
module "github" {
    source                  = "./modules/github"

    github_token            = var.github_token
    github_organization     = var.github_org
}
*/
