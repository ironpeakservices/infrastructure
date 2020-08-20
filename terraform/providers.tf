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
        }
        
        github = {
            source  = "hashicorp/github"
            version = "~> 2.9"
        }
        
        scaleway = {
            source  = "scaleway/scaleway"
            version = "~> 1.16"
        }
    }
}
