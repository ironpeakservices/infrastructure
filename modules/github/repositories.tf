resource "github_repository" "docker-security" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Docker security best practices."
  etag               = "W/\"fc51c4794979f340ea9b04dba6f4de12\""
  full_name          = "ironPeakServices/docker-security"
  git_clone_url      = "git://github.com/ironPeakServices/docker-security.git"
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  html_url           = "https://github.com/ironPeakServices/docker-security"
  http_clone_url     = "https://github.com/ironPeakServices/docker-security.git"
  id                 = "docker-security"
  name               = "docker-security"
  private            = false
  ssh_clone_url      = "git@github.com:ironPeakServices/docker-security.git"
  svn_url            = "https://github.com/ironPeakServices/docker-security"
}

resource "github_repository" "hardened-alpine" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Hardened alpine linux baseimage for Docker."
  etag               = "W/\"914017379f36b9464cbabc2bd4d365f5\""
  full_name          = "ironPeakServices/hardened-alpine"
  git_clone_url      = "git://github.com/ironPeakServices/hardened-alpine.git"
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  homepage_url       = "https://hub.docker.com/r/ironpeakservices/hardened-alpine"
  html_url           = "https://github.com/ironPeakServices/hardened-alpine"
  http_clone_url     = "https://github.com/ironPeakServices/hardened-alpine.git"
  id                 = "hardened-alpine"
  name               = "hardened-alpine"
  private            = false
  ssh_clone_url      = "git@github.com:ironPeakServices/hardened-alpine.git"
  svn_url            = "https://github.com/ironPeakServices/hardened-alpine"
  topics             = ["alpine", "docker"]
}

resource "github_repository" "infrastructure" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "(WIP) Terraform configuration of the ironpeak infrastructure."
  etag               = "W/\"c77e25e2761e7e3cf538bf488b8e83c6\""
  full_name          = "ironPeakServices/infrastructure"
  git_clone_url      = "git://github.com/ironPeakServices/infrastructure.git"
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  html_url           = "https://github.com/ironPeakServices/infrastructure"
  http_clone_url     = "https://github.com/ironPeakServices/infrastructure.git"
  id                 = "infrastructure"
  name               = "infrastructure"
  private            = false
  ssh_clone_url      = "git@github.com:ironPeakServices/infrastructure.git"
  svn_url            = "https://github.com/ironPeakServices/infrastructure"
}

resource "github_repository" "iron-argo" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Secure base image for running cloudflared/argo."
  etag               = "W/\"398547ff409c760d87baf1723c7d122f\""
  full_name          = "ironPeakServices/iron-argo"
  git_clone_url      = "git://github.com/ironPeakServices/iron-argo.git"
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  html_url           = "https://github.com/ironPeakServices/iron-argo"
  http_clone_url     = "https://github.com/ironPeakServices/iron-argo.git"
  id                 = "iron-argo"
  name               = "iron-argo"
  private            = false
  ssh_clone_url      = "git@github.com:ironPeakServices/iron-argo.git"
  svn_url            = "https://github.com/ironPeakServices/iron-argo"
  topics             = ["cloudflare", "cloudflared", "argo", "docker"]
}

resource "github_repository" "iron-cockroachdb" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Secure base image for running cockroachdb. "
  etag               = "W/\"20586451484330f2f7b19bb3ffe85cc6\""
  full_name          = "ironPeakServices/iron-cockroachdb"
  git_clone_url      = "git://github.com/ironPeakServices/iron-cockroachdb.git"
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  html_url           = "https://github.com/ironPeakServices/iron-cockroachdb"
  http_clone_url     = "https://github.com/ironPeakServices/iron-cockroachdb.git"
  id                 = "iron-cockroachdb"
  name               = "iron-cockroachdb"
  private            = false
  ssh_clone_url      = "git@github.com:ironPeakServices/iron-cockroachdb.git"
  svn_url            = "https://github.com/ironPeakServices/iron-cockroachdb"
}

resource "github_repository" "iron-redis" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Secure base image for running Redis."
  etag               = "W/\"805aba22e10b8d399762b28c40ba0f5a\""
  full_name          = "ironPeakServices/iron-redis"
  git_clone_url      = "git://github.com/ironPeakServices/iron-redis.git"
  has_downloads      = true
  has_issues         = true
  has_projects       = false
  has_wiki           = true
  homepage_url       = "https://hub.docker.com/r/ironpeakservices/iron-redis"
  html_url           = "https://github.com/ironPeakServices/iron-redis"
  http_clone_url     = "https://github.com/ironPeakServices/iron-redis.git"
  id                 = "iron-redis"
  name               = "iron-redis"
  private            = false
  ssh_clone_url      = "git@github.com:ironPeakServices/iron-redis.git"
  svn_url            = "https://github.com/ironPeakServices/iron-redis"
  topics             = ["docker", "redis"]
}

resource "github_repository" "iron-static" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Secure base image for serving frontend code using Caddy."
  etag               = "W/\"1e6d4d924c344869767f6fda0943d6ed\""
  full_name          = "ironPeakServices/iron-static"
  git_clone_url      = "git://github.com/ironPeakServices/iron-static.git"
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  html_url           = "https://github.com/ironPeakServices/iron-static"
  http_clone_url     = "https://github.com/ironPeakServices/iron-static.git"
  id                 = "iron-static"
  name               = "iron-static"
  private            = false
  ssh_clone_url      = "git@github.com:ironPeakServices/iron-static.git"
  svn_url            = "https://github.com/ironPeakServices/iron-static"
}

resource "github_repository" "ironpeak--be" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Hugo repository for main ironpeak.be website."
  etag               = "W/\"6cecbbdf4534dee0cb4aad8388c1e82b\""
  full_name          = "ironPeakServices/ironpeak.be"
  git_clone_url      = "git://github.com/ironPeakServices/ironpeak.be.git"
  has_downloads      = true
  has_issues         = false
  has_projects       = false
  has_wiki           = false
  homepage_url       = "https://ironpeak.be/"
  html_url           = "https://github.com/ironPeakServices/ironpeak.be"
  http_clone_url     = "https://github.com/ironPeakServices/ironpeak.be.git"
  id                 = "ironpeak.be"
  name               = "ironpeak.be"
  private            = false
  ssh_clone_url      = "git@github.com:ironPeakServices/ironpeak.be.git"
  svn_url            = "https://github.com/ironPeakServices/ironpeak.be"
  topics             = ["hugo", "netlify"]
}

resource "github_repository" "scratch-go" {
  allow_merge_commit = true
  allow_rebase_merge = true
  allow_squash_merge = true
  archived           = false
  default_branch     = "master"
  description        = "Secure base image for running Go applications."
  etag               = "W/\"be6b84e0fde75b5e210730377869491e\""
  full_name          = "ironPeakServices/scratch-go"
  git_clone_url      = "git://github.com/ironPeakServices/scratch-go.git"
  has_downloads      = true
  has_issues         = true
  has_projects       = true
  has_wiki           = true
  homepage_url       = "https://hub.docker.com/r/ironpeakservices/go-scratch"
  html_url           = "https://github.com/ironPeakServices/scratch-go"
  http_clone_url     = "https://github.com/ironPeakServices/scratch-go.git"
  id                 = "scratch-go"
  name               = "scratch-go"
  private            = false
  ssh_clone_url      = "git@github.com:ironPeakServices/scratch-go.git"
  svn_url            = "https://github.com/ironPeakServices/scratch-go"
  topics             = ["docker", "go"]
}
