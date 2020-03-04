variable "github_token" {}

variable "cloudflared_tunnel_token" {}

variable "cluster_hostname" {
  default = "cluster.ironpeak.be"
}

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

variable "nginx_namespace" {
  default = "kube-system"
}

variable "nginx_version" {
  default = "1.33.1"
}

variable "dashboard_namespace" {
  default = "kube-system"
}

variable "dashboard_version" {
  default = "1.10.1"
}