# VPC
resource "google_compute_network" "k8svpc" {
  project                 = var.project_id
  name                    = "${var.cluster_name}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  project       = var.project_id
  name          = "${var.cluster_name}-subnet"
  region        = var.region
  network       = google_compute_network.k8svpc.name
  ip_cidr_range = "10.10.0.0/16"
}