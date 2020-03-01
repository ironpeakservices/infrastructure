resource "kubernetes_namespace" "logging" {
    metadata {
        annotations = {
            app = "logging"
        }
        
        name = "logging"
    }
}
