terraform {
    required_version = ">= v0.12.19"
}

provider "cloudflare" {
    version = "~> v2.3"
    api_token = var.cloudflare_token
}

provider "external" {
    version = "~> v1.2"
}

provider "local" {
    version = "~> v1.4"
}

provider "github" {
    version = "~> v2.2"
    token = var.github_token
    organization = var.github_org
}

provider "scaleway" {
    version = "~> v1.13"
}

provider "kubernetes" {
    # fixed to v1.10 because of https://github.com/terraform-providers/terraform-provider-kubernetes/issues/759
    version = "~> v1.10"
    token = module.scaleway.token
}

provider "helm" {
    version = "~> v1.0"
    token = module.scaleway.token
}

provider "template" {
    version = "~> v2.1"
}
