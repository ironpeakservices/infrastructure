resource "google_container_cluster" "k8s_cluster" {
    # necessary for now for networking_mode
    # TODO: remove google-beta in gcloud module when networking_mode is out of beta
    provider = google-beta

    name     = var.cluster_name
    location = var.region
    min_master_version = var.k8s_version

    # cluster_ipv4_cidr

    addons_config {
        horizontal_pod_autoscaling {
            disabled = false
        }

        http_load_balancing {
            disabled = false
        }

        network_policy_config {
            disabled = false
        }

        istio_config {
            disabled = false
            auth = "AUTH_MUTUAL_TLS"
        }

        # cloudrun_config
        # dns_cache_config
        # gce_persistent_disk_csi_driver_config
        # kalm_config
        # config_connector_config
    }

    cluster_autoscaling {
        enabled = true

        autoscaling_profile = "BALANCED"

        resource_limits {
            resource_type = "cpu"
            maximum       = 4
        }
        resource_limits {
            resource_type = "memory"
            maximum       = 12000
        }
    }

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.k8svpc.name
  subnetwork = google_compute_subnetwork.subnet.name
  networking_mode = "VPC_NATIVE"

  network_policy {
    enabled = true
    provider = "CALICO"
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/16"
    services_ipv4_cidr_block = "/24"
  }

  database_encryption {
      state = "ENCRYPTED"
      key_name = var.gke_database_secret
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.k8s_cluster.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.k8s_cluster.name
  version    = var.k8s_version

  initial_node_count = var.node_default_count
  autoscaling {
      min_node_count = 1
      max_node_count = 5
  }

  management {
      auto_repair  = true
      auto_upgrade = true
  }

  upgrade_settings {
      max_surge = 1
      max_unavailable = 1
  }

  node_config {
    disk_size_gb = "50"
    disk_type    = "pd-standard"

    image_type   = "cos_containerd"

    machine_type = "n1-standard-1"
    preemptible  = false

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    tags         = ["gke-node", "gke-${var.project_id}"]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}