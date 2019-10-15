variable "ssh_root_private_key" {}

variable "ssh_root_public_key" {}

variable "ssh_tech_public_key" {}

variable "scaleway_organization" {}

variable "scaleway_api_token" {}

variable "docker_api_ip" {
  default = "127.0.0.1"
}

variable "is_master" {
    default = false
}

variable "instance_count" {
  default = 1
}

variable "tags" {
  type    = "list"
  default = [ "docker" ]
}

variable "ssh_port" {
  default = 22
}