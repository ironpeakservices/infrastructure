provider "cloudflare" {
    version = "~> 2.0"
      email   = "foo"//${var.cloudflare_email}"
  api_key = "bar"//"${var.cloudflare_token}"
  api_token = "meh"
}

provider "external" {
    version = "~> 1.2.0"
}

provider "github" {
    version = "~> 2.2.1"
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