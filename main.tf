# our dns, DoS scrubber and CDN
module "cloudflare" {
    source                  = "./modules/cloudflare"
    
    cloudflare_token        = var.cloudflare_token
}

# the basic infrastructure (managed kubernetes cluster)
module "scaleway" {
    source                  = "./modules/scaleway"

    cluster_name            = var.k8s_cluster_name
    scaleway_accesstoken    = var.scaleway_accesstoken
    scaleway_secrettoken    = var.scaleway_secrettoken
    scaleway_organization   = var.scaleway_org
}

# baseline kubernetes configuration
module "kubernetes" {
    source                  = "./modules/kubernetes"

    cluster_name            = var.k8s_cluster_name
    host                    = module.scaleway.kubeconfig[0].host
    token                   = module.scaleway.kubeconfig[0].token
    cluster_ca_certificate  = module.scaleway.kubeconfig[0].cluster_ca_certificate
}

# all baseline kubernetes packages in helm charts
module "kubernetes_helm" {
    source                  = "./modules/helm"
    
    cluster_name            = var.k8s_cluster_name
    host                    = module.kubernetes.host
    token                   = module.kubernetes.token
    cluster_ca_certificate  = module.kubernetes.cluster_ca_certificate
}

/*
# since we're GitOps, include GitHub aswel
module "github" {
    source                  = "./modules/github"

    github_token            = var.github_token
    github_organization     = var.github_org
}
*/
