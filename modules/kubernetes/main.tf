provider "kubernetes" {
    load_config_file        = true
    config_path             = "kubeconfig"
    config_context_cluster  = var.cluster_name
    #cluster_ca_certificate  = base64decode(var.cluster_ca_certificate)
    #host    = var.host
    #token   = var.token
}
