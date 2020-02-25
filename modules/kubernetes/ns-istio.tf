# istio namespace
resource "kubernetes_namespace" "istio" {
    metadata {
        annotations = {
            env = "prd"
        }

        labels = {
            env = "prd"
            type = "system"
        }

        name = "istio"
    }
}
