output "id" {
    value = scaleway_k8s_cluster_beta.ironpeakbe-main-cluster.id
}

output "status" {
    value = scaleway_k8s_cluster_beta.ironpeakbe-main-cluster.status
}

output "apiserver_url" {
    value = scaleway_k8s_cluster_beta.ironpeakbe-main-cluster.apiserver_url
}

output "wildcard_dns" {
    value = scaleway_k8s_cluster_beta.ironpeakbe-main-cluster.wildcard_dns
}

output "host" {
    sensitive = true
    value     = scaleway_k8s_cluster_beta.ironpeakbe-main-cluster.kubeconfig[0].config_file.host
}

output "token" {
    sensitive = true
    value     = scaleway_k8s_cluster_beta.ironpeakbe-main-cluster.kubeconfig[0].config_file.token
}

output "cluster_ca_certificate" {
    sensitive = true
    value     = scaleway_k8s_cluster_beta.ironpeakbe-main-cluster.kubeconfig[0].cluster_ca_certificate
}

output "kubeconfig" {
    sensitive = true
    value     = scaleway_k8s_cluster_beta.ironpeakbe-main-cluster.kubeconfig
}
