variable "organization" {
}

variable "api_token" {
}


variable "ssh_root_private_key_path" {
}

variable "ssh_root_public_key_path" {
}

variable "ssh_tech_public_key_path" {
}

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