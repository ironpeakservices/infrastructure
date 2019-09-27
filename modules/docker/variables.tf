variable "ssh_root_private_key" {
}

variable "ssh_root_public_key" {
}

variable "docker_api_ip" {
  default = "127.0.0.1"
}

variable "is_master" {
    type    = bool
    default = false
}