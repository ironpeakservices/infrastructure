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

/*
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
*/

resource "kubernetes_deployment" "loki_grafana_tunnel_deployment" {
  metadata {
    name      = "traefik-tunnel"
    namespace = var.traefik_namespace
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
        
        security_context {
          run_as_user   = 1000
          run_as_group  = 1000
          run_as_non_root = true
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
          name  = "traefik-tunnel"

          args = [
            "--url=http://traefik",
            "--hostname=cluster.ironpeak.be",
            "--no-autoupdate",
            "--origincert=/etc/cloudflared/cert.pem",
            "--loglevel=debug"
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