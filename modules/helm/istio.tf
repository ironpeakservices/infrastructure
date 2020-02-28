# repo of the istio helm charts
data "helm_repository" "istio" {
  name = "istio.io"
  url  = "https://storage.googleapis.com/istio-release/releases/${var.istio_version}/charts/"
}

# initialize our istio Custom Resource Defitinations
# these are needed for the real istio charts
resource "helm_release" "istio_init" {
  name        = "istio-init"
  repository  = data.helm_repository.istio.metadata[0].name
  chart       = "istio-init"
  version     = var.istio_version
  namespace   = var.istio_namespace
  
  timeout         = 600
  #atomic          = true
  #cleanup_on_fail = true
  recreate_pods   = true
  verify          = false
}

# ability to use istio as a CNI instead of cilium/canico
resource "helm_release" "istio_cni" {
  depends_on  = [helm_release.istio_init]

  name        = "istio-cni"
  repository  = data.helm_repository.istio.metadata[0].name
  chart       = "istio-cni"
  version     = var.istio_version
  namespace   = var.istio_namespace
  
  timeout         = 600
  #atomic          = true
  #cleanup_on_fail = true
  recreate_pods   = true
  verify          = false
}

# istio chart for the real components
resource "helm_release" "istio" {
  depends_on  = [helm_release.istio_cni]

  name        = "istio"
  repository  = data.helm_repository.istio.metadata[0].name
  chart       = "istio"
  version     = var.istio_version
  namespace   = var.istio_namespace
  
  timeout         = 600
  #atomic          = true
  #cleanup_on_fail = true
  recreate_pods   = true
  verify          = false
  
  set { # we are going to use Cloudflare Argo for ingress traffic
    name  = "gateways.istio-ingressgateway.enabled"
    value = "false"
  }
  set { # egress should go through our gateway
    name  = "gateways.istio-egressgateway.enabled"
    value = "true"
  }
  set { # never allow cluster ingress traffic
    name  = "global.k8sIngress.enabled"
    value = "false"
  }
  set { # istio grafana dashboard
    name  = "grafana.enabled"
    value = "true"
  }
  set { # enable the cni plugin to replace canico
    name  = "istio_cni.enabled"
    value = "true"
  }
  set { # enable container mtls by default
    name  = "mtls.enabled"
    value = "true"
  }
  set { # only allow traffic that is defined in the service registry
    name  = "outboundTrafficPolicy.mode"
    value = "REGISTRY_ONLY"
  }
}
