resource "helm_release" "k8sdashboard" {
    name        = "dashboard"
    repository  = data.helm_repository.stable.metadata[0].name
    chart       = "stable/kubernetes-dashboard"
    version     = var.dashboard_version
    namespace   = var.dashboard_namespace

    atomic          = true
    cleanup_on_fail = true
    recreate_pods   = true
    verify          = false
  
    set {
        name  = "ingress.enabled"
        value = true
    }
    set {
        name  = "ingress.hosts[0]"
        value = var.cluster_hostname
    }
    set_string {
        name  = "ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/app-root"
        value = "/k8sdashboard"
    }
    set_string {
        name  = "ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
        value = "/"
    }
}