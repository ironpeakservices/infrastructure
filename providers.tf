terraform {
    required_version = ">= v0.12.19"
}

provider "external" {
    version = "~> 1.2"
}

provider "local" {
    version = "~> 1.4"
}

provider "template" {
    version = "~> 2.1"
}

// ISTIO_VERSION = 1.5.0

provider "cloudflare" {
    version = "~> 2.3"

    api_token = var.cloudflare_token
}

provider "github" {
    version = "~> 2.2"

    token = var.github_token
    organization = var.github_org
}

provider "scaleway" {
    version = "~> 1.13"

    access_key      = var.scaleway_accesstoken
    secret_key      = var.scaleway_secrettoken
    organization_id = var.scaleway_org
    zone            = var.scaleway_zone
    region          = var.scaleway_region
}

provider "kubernetes" {
    version = "1.11.1"

    load_config_file        = false
    cluster_ca_certificate  = base64decode(module.scaleway.cluster_ca_certificate)
    host                    = module.scaleway.host
    token                   = module.scaleway.token
    config_context          = var.k8s_cluster_name
}

provider "helm" {
    version = "~> 1.0"
    kubernetes {
        load_config_file       = false
        host                   = module.scaleway.host
        token                  = module.scaleway.token
        cluster_ca_certificate = base64decode(module.scaleway.cluster_ca_certificate)
        config_context         = var.k8s_cluster_name
    }
}
