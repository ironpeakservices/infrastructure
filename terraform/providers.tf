terraform {
    required_version = ">= v0.12.19"
    
    backend "local" {
        path = "state/terrform.tfstate"    
    }
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
    version = "~> 1.14"

    access_key      = var.scaleway_accesstoken
    secret_key      = var.scaleway_secrettoken
    organization_id = var.scaleway_org
    zone            = var.scaleway_zone
    region          = var.scaleway_region
}
