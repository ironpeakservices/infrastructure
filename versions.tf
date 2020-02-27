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
    # fixed to 1.10.0 because of https://github.com/terraform-providers/terraform-provider-kubernetes/issues/759
    version = "1.10.0"
    token = module.scaleway.token
}

provider "helm" {
    version = "~> v1.0"
    token = module.scaleway.token
}

provider "template" {
    version = "~> 2.1"
}
