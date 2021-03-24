// --- gcloud variables -------------

variable gcloud_project_id {}

variable gcloud_client_config {}

variable gcloud_gke_database_secret {}

variable k8s_cluster_name {}

variable k8s_version {
    default = ""
}

variable gcloud_region {
    default = "europe-west1-b"
}

// --- cloudflare variables -----------
/*
variable "cloudflare_token" {}

variable "cloudflared_tunnel_token" {}

// --- github variables ---------------

variable "github_token" {}

variable "github_org" {}
*/