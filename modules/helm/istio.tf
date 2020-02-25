data "helm_repository" "istio" {
  name = "istio.io"
  url  = "https://storage.googleapis.com/istio-release/releases/${var.istio_version}/charts/"
}

resource "helm_release" "istio" {
  name  = "istio"
  chart = "istio.io/istio"
}
