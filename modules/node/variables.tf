variable "scaleway_organization" {
}

variable "scaleway_api_token" {
}

variable "ssh_root_private_key" {
}

variable "ssh_root_public_key" {
}

variable "ssh_tech_public_key" {
}

variable "scaleway_region" {
  default = "ams1"
}

variable "manager_instance_type" {
  default = "DEV1-S"
}

variable "worker_instance_type" {
  default = "DEV1-S"
}

variable "ssh_port" {
  default = "22"
}

variable "private_subnet" {
  default = "10.0.0.0/8"
}

variable "node_arch" {
  default = "x86_64"
}

variable "instance_count" {
  default = 1
}

variable "tags" {
  type    = "list"
  default = []
}