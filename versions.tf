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
    version = "<= 1.9.0"
}

provider "helm" {
    version = "~> v1.0"
}

provider "template" {
    version = "~> 2.1"
}
