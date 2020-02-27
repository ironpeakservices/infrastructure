resource "local_file" "kubeconfig" {
    file_permission = "0400"
    filename = "../../kubeconfig" #"${path.root}/kubeconfig"
    sensitive_content  = scaleway_k8s_cluster_beta.ironpeakbe-main-cluster.kubeconfig[0].config_file
}
