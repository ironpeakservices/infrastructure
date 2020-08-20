variable access_key {}

variable secret_key {}

variable org_id {}

variable zone {}

variable region {}

variable k8s_version {}

variable cluster_name {
    default = "default"
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