terraform {
    required_version = ">= v0.14"
    
    backend "local" {
        path = "state/terraform.tfstate"    
    }

    required_providers {
        external = {
            source  = "external"
            version = "~> 1.2"
        }

        local = {
            source  = "local"
            version = "~> 1.4"
        }

        template = {
            source  = "template"
            version = "~> 2.1"
        }

        cloudflare = {
            source  = "cloudflare/cloudflare"
            version = "~> 2.3"
        }

        github = {
            source  = "github"
            version = "~> 2.2"
        }

        google = {
            # necessary for now for networking_mode
            # TODO: remove google-beta from providers when networking_mode is out of beta
            source  = "google-beta"
            version = "~> 3.53.0"
        }
    }
}

provider "cloudflare" {
    api_token = var.cloudflare_token
}
provider "github" {
    token = var.github_token
    organization = var.github_org
}
provider "google" {
    project         = var.gcloud_project_id
    region          = var.gcloud_region
}
