variable "host" {}

variable "token" {}

variable "cluster_ca_certificate" {}

variable "istio_namespace" {
  default = "system-istio"
}
