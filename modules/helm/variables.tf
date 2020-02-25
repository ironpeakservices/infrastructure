variable "host" {}

variable "token" {}

variable "cluster_ca_certificate" {}

variable "istio_version" {
  default = "1.4.5"  
}

variable "istio_namespace" {
  default = "istio"
}
