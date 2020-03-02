variable "host" {}

variable "token" {}

variable "cluster_ca_certificate" {}

variable "github_token" {}

variable "cluster_name" {
  default = "default"
}

variable "istio_version" {
  default = "1.4.5"  
}

variable "istio_namespace" {
  default = "istio"
}

variable "loki_version" {
  default = "0.32.1"
}

variable "loki_namespace" {
  default = "logging"
}

variable "grafana_version" {
  default = "5.0.3"
}
