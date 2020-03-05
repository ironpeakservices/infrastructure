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
  set {
    name  = "ingress.enabled"
    value = true
  }
  set {
    name  = "ingress.hosts[0]"
    value = var.cluster_hostname
  }
  set {
    name  = "ingress.path"
    value = "/logs"
  }
  set_string {
    name  = "ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/app-root"
    value = "/logs"
  }
  
}
