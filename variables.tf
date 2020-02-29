// --- scaleway variables -------------

variable "scaleway_accesstoken" {}

variable "scaleway_secrettoken" {}

variable "scaleway_org" {}

// --- cloudflare variables -----------

variable "cloudflare_token" {}

// --- kubernetes variables -----------

variable "k8s_cluster_name" {
    default = "ironpeakbe-main-cluster"
}

// --- github variables ---------------

variable "github_token" {}

variable "github_org" {}