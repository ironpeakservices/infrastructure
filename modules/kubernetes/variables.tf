variable "host" {}

variable "token" {}

variable "cluster_ca_certificate" {}

variable cluster_name {
  default = "default"
}

variable "istio_namespace" {
  default = "istio"
}
