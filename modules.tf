# our dns, DoS scrubber and CDN
module "cloudflare" {
    source                  = "./modules/cloudflare"
}

# the basic infrastructure (managed kubernetes cluster)
module "scaleway" {
    source                  = "./modules/scaleway"

    cluster_name            = var.k8s_cluster_name
}

# baseline kubernetes configuration
module "kubernetes" {
    source                  = "./modules/kubernetes"

    cluster_name            = var.k8s_cluster_name
    foo                     = module.scaleway.id
}

# all baseline kubernetes packages in helm charts
module "kubernetes_helm" {
    source                  = "./modules/helm"
    
    cluster_name            = var.k8s_cluster_name
    github_token            = var.github_token
    cloudflared_tunnel_token= var.cloudflared_tunnel_token
    foo                     = module.kubernetes.foo
}

/*
# since we're GitOps, include GitHub aswel
module "github" {
    source                  = "./modules/github"

    github_token            = var.github_token
    github_organization     = var.github_org
}
*/
