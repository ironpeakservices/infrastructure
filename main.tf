module "scaleway" {
    source                  = "./modules/scaleway"

    scaleway_accesstoken    = var.scaleway_accesstoken
    scaleway_secrettoken    = var.scaleway_secrettoken
    scaleway_organization   = var.scaleway_org
}

module "cloudflare" {
    source                  = "./modules/cloudflare"
    
    cloudflare_token        = var.cloudflare_token
}

module "kubernetes" {
    source                  = "./modules/kubernetes"

    host                    = module.scaleway.kubeconfig[0].host
    token                   = module.scaleway.kubeconfig[0].token
    cluster_ca_certificate  = module.scaleway.kubeconfig[0].cluster_ca_certificate
}

module "kubernetes_istio" {
    source                  = "./modules/helm"
    
    host                    = module.kubernetes.host
    token                   = module.kubernetes.token
    cluster_ca_certificate  = module.kubernetes.cluster_ca_certificate
}

/*
module "github" {
    source                  = "./modules/github"

    github_token            = var.github_token
    github_organization     = var.github_org
}
*/
