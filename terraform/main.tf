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
    }
}

# our dns, DoS scrubber and CDN
module "cloudflare" {
    source                  = "./modules/cloudflare"
}

# the basic infrastructure (managed kubernetes cluster)
module "scaleway" {
    source                  = "./modules/scaleway"

    cluster_name            = var.k8s_cluster_name
}

/*
# since we're GitOps, include GitHub aswel
module "github" {
    source                  = "./modules/github"

    github_token            = var.github_token
    github_organization     = var.github_org
}
*/
