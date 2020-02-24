# default cluster resource limitations
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

# default disruption budgets
resource "kubernetes_pod_disruption_budget" "default-pod-disruption-budget" {
  metadata {
    name = "default-pod-disruption-budget"
  }
  spec {
    selector {}
    min_available = 1
  }
}
