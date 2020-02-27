# istio namespace
resource "kubernetes_namespace" "istio" {
    metadata {
        annotations = {
            env = "prd"
        }

        labels = {
            env = "prd"
            type = "system"
        }

        name = var.istio_namespace
    }
}

# have a service account to deploy via tiller (helm v2)
resource "kubernetes_service_account" "sa_system_tiller" {
    metadata {
        namespace = "kube-system"
        name = "tiller"
    }
}

# now bind the role to the user for tiller (helm v2)
resource "kubernetes_role_binding" "rb_system_tiller" {
  metadata {
    namespace = "kube-system"
    name      = "rb-system-tiller"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.sa_system_tiller.metadata.0.name
  }
}
