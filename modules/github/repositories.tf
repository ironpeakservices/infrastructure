resource "github_repository" "docker-security" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Docker security best practices."
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  name               = "docker-security"
  private            = false
}

resource "github_repository" "hardened-alpine" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Hardened alpine linux baseimage for Docker."
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  homepage_url       = "https://hub.docker.com/r/ironpeakservices/hardened-alpine"
  name               = "hardened-alpine"
  private            = false
  topics             = ["alpine", "docker"]
}

resource "github_repository" "infrastructure" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "(WIP) Terraform configuration of the ironpeak infrastructure."
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  name               = "infrastructure"
  private            = false
}

resource "github_repository" "iron-argo" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Secure base image for running cloudflared/argo."
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  name               = "iron-argo"
  private            = false
  topics             = ["cloudflare", "cloudflared", "argo", "docker"]
}

resource "github_repository" "iron-cockroachdb" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Secure base image for running cockroachdb. "
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  name               = "iron-cockroachdb"
  private            = false
}

resource "github_repository" "iron-redis" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Secure base image for running Redis."
  has_downloads      = true
  has_issues         = true
  has_projects       = false
  has_wiki           = true
  homepage_url       = "https://hub.docker.com/r/ironpeakservices/iron-redis"
  name               = "iron-redis"
  private            = false
  topics             = ["docker", "redis"]
}

resource "github_repository" "iron-static" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Secure base image for serving frontend code using Caddy."
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  name               = "iron-static"
  private            = false
}

resource "github_repository" "ironpeak--be" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Hugo repository for main ironpeak.be website."
  has_downloads      = true
  has_issues         = false
  has_projects       = false
  has_wiki           = false
  homepage_url       = "https://ironpeak.be/"
  name               = "ironpeak.be"
  private            = false
  topics             = ["hugo", "netlify"]
}

resource "github_repository" "scratch-go" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Secure base image for running Go applications."
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  homepage_url       = "https://hub.docker.com/r/ironpeakservices/go-scratch"
  name               = "scratch-go"
  private            = false
  topics             = ["docker", "go"]
}
