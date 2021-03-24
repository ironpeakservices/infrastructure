resource "google_service_account" "k8s_node_default_serviceaccount" {
    project = var.project_id
    account_id = "k8s_node_default_sa"
    display_name = "Default kubernetes node service account"
}

resource "google_project_iam_member" "k8s_node_default_sa_role_metricwriter" {
    project = var.project_id
    role    = "roles/monitoring.metricWriter"
    member  = "user:${google_service_account.k8s_node_default_serviceaccount.email}"
}

resource "google_project_iam_member" "k8s_node_default_sa_role_monitoringviewer" {
    project = var.project_id
    role    = "roles/monitoring.viewer"
    member  = "user:${google_service_account.k8s_node_default_serviceaccount.email}"
}

resource "google_project_iam_member" "k8s_node_default_sa_role_logwriter" {
    project = var.project_id
    role    = "roles/logging.logWriter"
    member  = "user:${google_service_account.k8s_node_default_serviceaccount.email}"
}