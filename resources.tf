resource "local_file" "kubeconfig" {
    #file_permission = "0400"
    filename = "kubeconfig"
    sensitive_content  = module.scaleway.kubeconfig[0].config_file
}
