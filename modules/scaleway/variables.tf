variable "region" {
  default = "ams1"
}

variable "organization" {
  default = "7e4b03e9-8d86-4a69-8001-309889fffbeb"
}

variable "api_token" {
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

variable "docker_api_ip" {
  default = "127.0.0.1"
}

variable "ssh_port" {
  default = "2234"
}

variable "ssh_private_key_path" {
  default = "ssh.priv"
}

variable "ssh_public_key_path" {
  default = "ssh.pub"
}