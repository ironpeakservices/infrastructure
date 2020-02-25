data "helm_repository" "istio" {
  name = "istio.io"
  url  = "https://storage.googleapis.com/istio-release/releases/${var.istio_version}/charts/"
}

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
