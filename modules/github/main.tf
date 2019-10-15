provider "github" {
    secret_key      = "${var.github_token}"
    organization_id = "${var.github_organization}"
}