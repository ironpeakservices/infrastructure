resource "kubernetes_service_account" "sa_system_tiller" {
  metadata {
    name = "tiller"
    namespace = "istio"
  }
  
  automount_service_account_token = true
}

resource "kubernetes_cluster_role_binding" "rb_system_tiller" {
  metadata {
    name = "tiller"
  }
  
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  
  subject {
    api_group = ""
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.sa_system_tiller.metadata.0.name
    namespace = "kube-system"
  }
}
