resource "local_file" "kubeconfig" {
    filename = "kubeconfig"
    sensitive_content  = module.scaleway.kubeconfig[0].config_file
}
