resource "kubernetes_service_account" "github-mainwebsite-deployer" {
    metadata {
        namespace = kubernetes_namespace.mainwebsite.metadata.0.name
        name = "github-mainwebsite-deployer"
    }

    secret {
        name = kubernetes_secret.sa-github-mainwebsite-deployer.metadata.0.name
    }
}

resource "kubernetes_secret" "sa-github-mainwebsite-deployer" {
    metadata {
        namespace = kubernetes_namespace.mainwebsite.metadata.0.name
        name = "sa-github-mainwebsite-deployer"
    }

    /*
    data = {
        token = ""
    }
    */
    
    type = "kubernetes.io/service-account-token"
}
