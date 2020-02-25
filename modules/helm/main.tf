provider "helm" {
  kubernetes {
    host     = var.host
    token    = var.token
    cluster_ca_certificate = var.cluster_ca_certificate
  }
}
