resource "kubernetes_limit_range" "default-resource-limitations" {
  metadata {
    name = "default-resource-limitations"
  }

  spec {
    limit {
      type = "Pod"
      max = {
        cpu    = "200m"
        memory = "2048M"
      }
    }

    limit {
        type = "PersistentVolumeClaim"
        min = {
            storage = "10M"
        }
        max = {
            storage = "1000M"
        }
    }

    limit {
      type = "Container"
      default = {
        cpu    = "50m"
        memory = "500M"
      }
    }
  }
}