terraform {    
    required_providers {
        cloudflare = {
            source  = "cloudflare/cloudflare"
            version = "~> 2.9"
        }
    }
}

provider "cloudflare" {
    api_token = var.secret_token
}