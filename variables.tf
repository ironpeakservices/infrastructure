variable "scaleway_token" {}

variable "scaleway_org" {}

variable "ssh_root_private_key" {}

variable "ssh_root_public_key" {}

variable "ssh_tech_public_key" {}

// ---

variable swarm_master_count {
    type    = "number"
    default = 1
}

variable swarm_worker_count {
    type    = "number"
    default = 1
}

// ---

variable "cloudflare_email" {}

variable "cloudflare_token" {}

// ---

variable "github_token" {}

variable "github_org" {}
