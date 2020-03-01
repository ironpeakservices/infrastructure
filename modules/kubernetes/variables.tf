variable "host" {}

variable "token" {}

variable "cluster_ca_certificate" {}

variable "cloudflared_tunnel_token" {}

variable cluster_name {
  default = "default"
}

variable "istio_namespace" {
  default = "istio"
}
