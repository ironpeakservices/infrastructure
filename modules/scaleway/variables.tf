variable "organization" {}

variable "secret_key" {}

variable "access_key" {}

variable "ssh_root_private_key" {}

variable "ssh_root_public_key" {}

variable "ssh_tech_public_key" {}

variable "region" {
  default = "ams1"
}

variable "manager_instance_type" {
  default = "DEV1-S"
}

variable "worker_instance_type" {
  default = "DEV1-S"
}

variable "worker_instance_count" {
  default = 1
}

variable "manager_instance_count" {
  default = 1
}

variable "docker_api_ip" {
  default = "127.0.0.1"
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