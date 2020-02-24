provider "kubernetes" {
    load_config_file        = false
    cluster_ca_certificate  = base64decode(var.cluster_ca_certificate)
    host    = var.host
    token   = var.token
}