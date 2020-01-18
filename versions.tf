terraform {
    required_version = ">= v0.12.19"
}

provider "cloudflare" {
    version = "~> 2.3"
}

provider "external" {
    version = "~> 1.2"
}

provider "github" {
    version = "~> 2.2"
}

provider "scaleway" {
    version = "~> 1.13"
}

provider "template" {
    version = "~> 2.1"
}