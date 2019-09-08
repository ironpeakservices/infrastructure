terraform {
  backend "s3" {}
}

data "terraform_remote_state" "state" {
  backend = "s3"
  config {
        skip_requesting_account_id  = true
        skip_credentials_validation = true
        skip_get_ec2_platforms      = true
        skip_metadata_api_check     = true
        access_key  = "${var.state_access_key}"
        secret_key  = "${var.state_secret_key}"
        endpoint    = "https://s3.wasabisys.com"
        bucket      = "ironpeak-tf-state"
        key         = "terraform.tfstate"
        region      = "eu-central-1"
    }
}

module "scaleway" {
    source                  = "./modules/scaleway"

    organization            = "${var.scaleway_org}"
    api_token               = "${var.scaleway_token}"

    ssh_root_public_key     = "${var.ssh_root_public_key}"
    ssh_root_private_key    = "${var.ssh_root_private_key}"

    ssh_tech_public_key     = "${var.ssh_tech_public_key}"
}

module "cloudflare" {
    source                  = "./modules/cloudflare"
    
    cloudflare_email        = "${var.cloudflare_email}"
    cloudflare_token        = "${var.cloudflare_token}"
}

module "github" {
    source                  = "./modules/github"

    github_token            = "${var.github_token}"
    github_organization     = "${var.github_org}"
}