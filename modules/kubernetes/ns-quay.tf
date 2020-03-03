resource "kubernetes_namespace" "quay" {
    metadata {
        annotations = {
            app = var.quay_namespace
        }
        
        name = var.quay_namespace
    }
}