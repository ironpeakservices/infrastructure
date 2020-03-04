# repo of the traefik helm charts
data "helm_repository" "traefik" {
  name = "traefik"
  url  = "https://containous.github.io/traefik-helm-chart"
}

# install traefik stack for ingress 
resource "helm_release" "traefik" {
  name        = "traefik"
  repository  = data.helm_repository.traefik.metadata[0].name
  chart       = "traefik/traefik"
  version     = var.traefik_version
  namespace   = var.traefik_namespace
  
  atomic          = true
  cleanup_on_fail = true
  recreate_pods   = true
  verify          = false
  
  set { # we want to keep our logging
    name  = "loki.persistence.enabled"
    value = "true"
  }
}