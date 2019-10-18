provider "cloudflare" {
    version = "~> 2.0"
    email   = "${var.cloudflare_email}"
    api_key = "${var.cloudflare_token}"
}

provider "external" {
    version = "~> 1.2.0"
}

provider "github" {
    version = "~> 2.2.1"
    token        = "${var.github_token}"
    organization = "${var.github_org}"
    individual = false
}

provider "scaleway" {
    version = "~> 1.11.0"
}

provider "template" {
    version = "~> 2.1.2"
}

provider "null" {
    version = "~> 2.1.2"
}