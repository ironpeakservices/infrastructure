terraform {
    required_version = ">= v0.12.19"
    
    backend "local" {
        path = "state/terraform.tfstate"    
    }
    
    required_providers {
        external = {
            version = "~> 1.2"
        }
        
        local = {
            version = "~> 1.4"
        }
        
        template = {
            version = "~> 2.1"
        }
        
        cloudflare = {
            source  = "cloudflare/cloudflare"
            version = "~> 2.9"

            api_token = var.cloudflare_token
        }
        
        github = {
            source  = "hashicorp/github"
            version = "~> 2.9"

            token = var.github_token
            organization = var.github_org    
        }
        
        scaleway = {
            source  = "scaleway/scaleway"
            version = "~> 1.16"

            access_key      = var.scaleway_accesstoken
            secret_key      = var.scaleway_secrettoken
            organization_id = var.scaleway_org
            zone            = var.scaleway_zone
            region          = var.scaleway_region
        }
    }
}
