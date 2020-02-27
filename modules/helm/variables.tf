variable host {}

variable token {}

variable cluster_ca_certificate {}

variable cluster_name {}

variable kubeconfig_path {
  default = "../kubeconfig"
}

variable istio_version {
  default = "1.4.5"  
}

variable istio_namespace {
  default = "system-istio"
}
