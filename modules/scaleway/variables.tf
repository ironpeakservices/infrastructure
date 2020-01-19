variable scaleway_accesstoken {}

variable scaleway_secrettoken {}

variable node_type {
    default = "GP1-XS"
}

variable node_default_count {
    type = number
    default = 1
}

variable node_minimum_count {
    type = number
    default = 1
}

variable node_maximum_count {
    type = number
    default = 1
}

variable "zone" {
    default = "fr-par-1"
}

variable "region" {
    default = "fr-par"
}