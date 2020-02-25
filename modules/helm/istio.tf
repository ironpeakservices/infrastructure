# repo of the istio helm charts
data "helm_repository" "istio" {
  name = "istio.io"
  url  = "https://storage.googleapis.com/istio-release/releases/${var.istio_version}/charts/"
}

# initialize our istio Custom Resource Defitinations
# these are needed for the real istio charts
resource "helm_release" "istio-init" {
  name        = "istio-init"
  repository  = data.helm_repository.istio.metadata[0].name
  chart       = "istio.io/istio-init"
  version     = var.istio_version
  namespace   = var.istio_namespace
  
  cleanup_on_fail = true
  recreate_pods   = true
  verify          = true
}

# istio chart for the real components
resource "helm_release" "istio" {
  name        = "istio"
  repository  = data.helm_repository.istio.metadata[0].name
  chart       = "istio.io/istio"
  version     = var.istio_version
  namespace   = var.istio_namespace
  
  cleanup_on_fail = true
  recreate_pods   = true
  verify          = true
}
