#
# This module contains all code pertaining to Helm packages we want installed on kubernetes
# This will also typically impact all pods running on k8s, so that's why it's centrally managed.
#

provider "helm" {
  kubernetes {
    host                   = var.host
    token                  = var.token
    cluster_ca_certificate = var.cluster_ca_certificate
  }
}
