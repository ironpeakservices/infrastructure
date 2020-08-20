terraform {    
    required_providers {
        github = {
            source  = "hashicorp/github"
            version = "~> 2.9"
        }
    }
}

provider "github" {
    token        = var.github_token
    organization = var.github_organization
    anonymous    = false
    individual   = false
}