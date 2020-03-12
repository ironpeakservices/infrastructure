variable cluster_name {
    default = "default"
}

data "external" "get_kubernetes_version" {
  program = ["${path.module}/extract-kubernetes-version.sh", "${path.module}/.kubernetes/go.mod"]
}

variable k8s_version {
    default = "${data.external.get_kubernetes_version.result}"
}

variable node_type {
    default = "DEV1-M"
}

variable node_default_count {
    type = number
    default = 1
}

variable node_minimum_count {
    type = number
    default = 1
}

variable node_maximum_count {
    type = number
    default = 1
}
