# repo of the istio helm charts
data "helm_repository" "loki" {
  name = "loki"
  url  = "https://grafana.github.io/loki/charts"
}

# install loki stack for prometheus 
resource "helm_release" "loki_stack" {
  name        = "loki"
  repository  = data.helm_repository.loki.metadata[0].name
  chart       = "loki/loki-stack"
  version     = var.loki_version
  namespace   = var.loki_namespace
  
  atomic          = true
  cleanup_on_fail = true
  recreate_pods   = true
  verify          = false
  
  set { # we want to keep our logging
    name  = "loki.persistence.enabled"
    value = "true"
  }
  set { # set a good sized amount to keep some
    name  = "loki.persistence.size"
    value = "100Gi"
  }
  set { # promtail is our main logging collector
    name  = "promtail.enabled"
    value = "true"
  }
  set { # we don't need fluent-bit
    name  = "fluent-bit.enabled"
    value = "false"
  }
  set { # no need for prometheus
    name  = "prometheus.enabled"
    value = "false"
  }
  set { # auto-delete logs after a while
    name  = "config.table_manager.retention_deletes_enabled"
    value = "true"
  }
  set { # keep logs for one month
    name  = "config.table_manager.retention_period"
    value = "720h"
  }
}

# stable helm v2 charts
data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

# now install grafana for the gui bits
resource "helm_release" "loki_grafana" {
  name        = "grafana"
  repository  = data.helm_repository.stable.metadata[0].name
  chart       = "stable/grafana"
  version     = var.grafana_version
  namespace   = var.loki_namespace
  
  #atomic          = true
  #cleanup_on_fail = true
  recreate_pods   = true
  verify          = false
  
  set { # grafana should store some cached data
    name  = "persistence.enabled"
    value = "true"
  }
  set { # 10Gbit should be more than enough
    name  = "persistence.size"
    value = "10Gi"
  }
  set { # use k8s native storage
    name  = "persistence.type"
    value = "pvc"
  } 
}

resource "kubernetes_secret" "cloudflared_cert_pem" {
    metadata {
        name      = "cloudflared-cert-pem"
        namespace = var.loki_namespace
    }

    type = "Opaque"

    data = {
        "cert.pem" = var.cloudflared_tunnel_token
    }
}

locals {
  dockercfg = {
    "docker.pkg.github.com" = {
      email    = "hello@ironpeak.be"
      username = "hazcod"
      password = var.github_token
    }
  }
}

resource "kubernetes_secret" "github_registry_auth" {
  metadata {
    name      = "github-registry-auth"
    namespace = var.loki_namespace
  }

  data = {
    ".dockercfg" = "${ jsonencode(local.dockercfg) }"
  }

  type = "kubernetes.io/dockercfg"
}

resource "kubernetes_deployment" "loki_grafana_tunnel_deployment" {
  metadata {
    name      = "loki-grafana-tunnel-deployment"
    namespace = var.loki_namespace
    labels    = {
      type = "tunnel"
    }
  }
  spec {
    replicas = 1
    min_ready_seconds = 5

    selector {
      match_labels = {
       type = "tunnel"
      }
    }
    
    template {
      metadata {
        labels = {
          type = "tunnel"
        }
      }
      spec {
        termination_grace_period_seconds = 30
        
        image_pull_secrets {
          name = "github-registry-auth"
        }
        
        volume {
          name = kubernetes_secret.cloudflared_cert_pem.metadata.0.name
          secret {
            secret_name   = kubernetes_secret.cloudflared_cert_pem.metadata.0.name
            default_mode  = "0400"
          }
        }

        container {
          image = "docker.io/ironpeakservices/iron-argo:latest"
          name  = "grafana-cloudflared"

          args = [
            "--url=http://grafana.logging",
            "--hostname=logging.ironpeak.be",
            "--no-autoupdate",
            "--origincert=/etc/cloudflared/cert.pem"
          ]

          volume_mount {
            name        = kubernetes_secret.cloudflared_cert_pem.metadata.0.name
            mount_path  = "/etc/cloudflared"
            read_only   = true
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
