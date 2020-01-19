resource "kubernetes_namespace" "mainwebsite" {
    metadata {
        annotations = {
            env = "prd"
        }

        labels = {
            env = "prd"
            type = "website"
        }

        name = "mainwebsite"
    }
}