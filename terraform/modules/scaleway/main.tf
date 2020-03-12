data "external" "get_kubernetes_version" {
  program = ["${path.module}/extract-kubernetes-version.sh", "${path.module}/.kubernetes/go.mod"]
}

resource "scaleway_k8s_cluster_beta" "ironpeakbe-main-cluster" {
    name = var.cluster_name
    version = var.k8s_version == "" ? data.external.get_kubernetes_version.result : var.k8s_version
    tags = [ "k8s", "ironpeakbe", "main-cluster", "prd" ]
    
    enable_dashboard = false

    ingress = "none"
    cni = "cilium"
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
}
