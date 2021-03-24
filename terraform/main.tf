# our dns, DoS scrubber and CDN
/*
module "cloudflare" {
    source                  = "./modules/cloudflare"
}
*/

# the basic infrastructure (managed kubernetes cluster)
module "gcloud" {
    source                  = "./modules/gcloud"

    k8s_version             = var.k8s_version == "" ? data.external.get_kubernetes_version.result.version : var.k8s_version
    cluster_name            = var.k8s_cluster_name
    region                  = var.gcloud_region
    client_config           = var.gcloud_client_config
    project_id              = var.gcloud_project_id
    gke_database_secret     = var.gcloud_gke_database_secret
}

modules "kubernetes" {
    source                  = "./modules/kubernetes"

    //TODO: use gcloud outputs
}

/*
# since we're GitOps, include GitHub aswel
module "github" {
    source                  = "./modules/github"

    github_token            = var.github_token
    github_organization     = var.github_org
}
*/
