# our dns, DoS scrubber and CDN
module "cloudflare" {
    source                  = "./modules/cloudflare"
    
    cloudflare_token        = var.cloudflare_token
}

# the basic infrastructure (managed kubernetes cluster)
module "scaleway" {
    source                  = "./modules/scaleway"

    scaleway_accesstoken    = var.scaleway_accesstoken
    scaleway_secrettoken    = var.scaleway_secrettoken
    scaleway_organization   = var.scaleway_org
    cluster_name            = var.k8s_cluster_name
}

# baseline kubernetes configuration
module "kubernetes" {
    source                  = "./modules/kubernetes"

    host                    = module.scaleway.host
    token                   = module.scaleway.token
    cluster_ca_certificate  = module.scaleway.cluster_ca_certificate
    cluster_name            = var.k8s_cluster_name
}

# all baseline kubernetes packages in helm charts
module "kubernetes_helm" {
    source                  = "./modules/helm"
    
    host                    = module.kubernetes.host
    token                   = module.kubernetes.token
    cluster_ca_certificate  = module.scaleway.cluster_ca_certificate
    cluster_name            = var.k8s_cluster_name
    github_token            = var.github_token
    cloudflared_tunnel_token= var.cloudflared_tunnel_token
}

/*
# since we're GitOps, include GitHub aswel
module "github" {
    source                  = "./modules/github"

    github_token            = var.github_token
    github_organization     = var.github_org
}
*/
