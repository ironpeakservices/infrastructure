variable cluster_name {
    default = "default"
}

variable k8s_version {
    default = "1.17.3"
}

variable node_type {
    default = "DEV1-M"
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
    default = "nl-ams-1"
}
