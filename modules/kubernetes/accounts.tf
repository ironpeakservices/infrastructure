resource "kubernetes_service_account" "github-mainwebsite-deployer" {
    metadata {
        namespace = kubernetes_namespace.mainwebsite.metadata.0.name
        name = "github-mainwebsite-deployer"
    }
}

resource "kubernetes_secret" "sa-github-mainwebsite-deployer" {
    metadata {
        namespace = kubernetes_namespace.mainwebsite.metadata.0.name
        name = "sa-github-mainwebsite-deployer"
        annotations = {
          "kubernetes.io/service-account.name" = "${kubernetes_service_account.github-mainwebsite-deployer.metadata.0.name}"
        }
    }

    /*
    data = {
        token = ""
    }
    */
    
    type = "kubernetes.io/service-account-token"
}
