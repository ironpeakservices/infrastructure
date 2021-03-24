data "external" "get_kubernetes_version" {
  program = ["${path.module}/../.github/extract-kubernetes-version.sh", "${path.module}/../.github/kubernetes/go.mod"]
}