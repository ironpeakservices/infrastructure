variable "host" {}

variable "token" {}

variable "cluster_ca_certificate" {}

variable "cluster_name" {
  default = "default"
}

# --- istio --------------

variable "istio_version" {
  default = "1.4.5"  
}

variable "istio_namespace" {
  default = "istio"
}

# --- loki ---------------

variable "loki_version" {
  default = "0.32.1"
}

variable "loki_namespace" {
  default = "logging"
}

variable "grafana_version" {
  default = "5.0.3"
}

# --- monitoring ----------

variable "netdata_version" {
  default = "1.1.13"
}

variable "netdata_namespace" {
  default = "monitoring"
}

