resource "local_file" "kubeconfig" {
    filename = "kubeconfig"
    content  = module.kubernetes.kubeconfig
}