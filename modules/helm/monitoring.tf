# repo of the netdata chart
# TODO: https://github.com/netdata/helmchart/issues/74
data "helm_repository" "netdata" {
  name = "netdata"
  url  = "https://github.com/netdata/helmchart"
}

# install netdata for our cluster & pod monitoring 
resource "helm_release" "netdata" {
  name        = "netdata"
  repository  = data.helm_repository.netdata.metadata[0].name
  chart       = "netdata/helmchart"
  version     = var.netdata_version
  namespace   = var.netdata_namespace
  
  #atomic          = true
  #cleanup_on_fail = true
  recreate_pods   = true
  verify          = false
  
  set { # don't expose access to netdata by default
    name  = "ingress.enabled"
    value = "false"
  }
  set { # add an annotation to pods that are monitored
    name  = "slave.podAnnotations"
    value = "{\"monitored\":\"true\"}"
  }
  set { # keep our monitors persisted
    name  = "master.database.persistence"
    value = "true"
  }
  set { # restrict our monitor storage to 1Gbit
    name  = "master.database.volumesize"
    value = "1Gi"
  }
  set { # store our alarms aswel
    name  = "master.alarms.persistence"
    value = "true"
  }
  set { # restrict our alarms storage to 100Mbit
    name  = "master.alarms.volumesize"
    value = "100Mi"
  }
}
