
provider "cloudflare" {
    version = "~> 2.0"
  email   = "foo"//${var.cloudflare_email}"
  api_key = "bar"//"${var.cloudflare_token}"
}