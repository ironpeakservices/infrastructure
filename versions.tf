terraform {
    required_version = ">= v0.12.19"
}

provider "cloudflare" {
    version = "~> 2.3"
    api_token = var.cloudflare_token
}

provider "external" {
    version = "~> 1.2"
}

provider "local" {
    version = "~> 1.4"
}

provider "github" {
    version = "~> 2.2"
    token = var.github_token
    organization = var.github_org
}

provider "scaleway" {
    version = "~> 1.13"
}

provider "kubernetes" {
    version = "1.11.1"
    token = module.scaleway.token
}

provider "helm" {
    version = "~> 1.0"
    token = module.scaleway.token
    cloudflared_tunnel_token = var.cloudflared_tunnel_token
}

provider "template" {
    version = "~> 2.1"
}

// ISTIO_VERSION = 1.4.5
