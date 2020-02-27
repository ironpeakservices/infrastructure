# repo of the istio helm charts
data "helm_repository" "loki" {
  name = "loki"
  url  = "https://grafana.github.io/loki/charts"
}

# install prometheus, 
resource "helm_release" "loki_stack" {
  name        = "loki"
  repository  = data.helm_repository.loki.metadata[0].name
  chart       = "loki/loki-stack"
  version     = var.loki_version
  namespace   = var.loki_namespace
  
  #atomic          = true
  #cleanup_on_fail = true
  recreate_pods   = true
  verify          = false
}
