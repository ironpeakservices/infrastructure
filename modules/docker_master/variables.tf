variable "ssh_root_private_key" {}

variable "ssh_root_public_key" {}

variable "ssh_tech_public_key" {}

variable "scaleway_organization" {}

variable "scaleway_api_token" {}

variable "manager_instance_count" {
    type    = "number"
    default = 1
}