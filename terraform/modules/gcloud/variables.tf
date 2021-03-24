variable cluster_name {}

variable region {}

variable client_config {}

variable project_id {}

variable gke_database_secret {}

variable k8s_version {
  default = ""   
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
