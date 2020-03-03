# repo of the istio helm charts
data "helm_repository" "quay" {
    name = "quay"
    url  = "https://redhat-cop.github.io/quay-operator"
}

# install loki stack for prometheus 
resource "helm_release" "quay" {
    name        = "quay"
    repository  = data.helm_repository.quay.metadata[0].name
    chart       = "quay/quay-operator"
    version     = var.quay_version
    namespace   = var.quay_namespace

    atomic          = true
    cleanup_on_fail = true
    recreate_pods   = true
    verify          = false

    set {
        name    = "openshift"
        value   = "false"
    }
}