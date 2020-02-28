provider "scaleway" {
    access_key      = var.scaleway_accesstoken
    secret_key      = var.scaleway_secrettoken
    organization_id = var.scaleway_organization

    zone       = var.zone
    region     = var.region
}

resource "scaleway_k8s_cluster_beta" "ironpeakbe-main-cluster" {
    name = var.cluster_name
    version = var.k8s_version
    tags = [ "k8s", "ironpeakbe", "main-cluster", "prd" ]
    
    enable_dashboard = true

    ingress = "none"
    cni = "flannel"
    // admission_plugins =
    // feature_gates =

    default_pool {
        node_type = var.node_type

        autoscaling = true
        autohealing = true

        size = var.node_default_count
        min_size = var.node_minimum_count
        max_size = var.node_maximum_count

        container_runtime = "containerd"
    }

    /*
    auto_upgrade {
        enable = true

        maintenance_window {
            start_hour = 3
            day = "any"
        }
    }
    */   
}
