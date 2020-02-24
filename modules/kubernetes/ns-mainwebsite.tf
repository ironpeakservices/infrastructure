# mainwebsite namespace
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

# by default deny all ingress/egress traffic
resource "kubernetes_network_policy" "default-networkpolicy" {
  metadata {
    name      = "default-networkpolicy"
    namespace = "mainwebsite"
  }

  spec {
    pod_selector {}
    policy_types = ["Ingress", "Egress"]
  }
}

# have a service account to deploy
resource "kubernetes_service_account" "github-mainwebsite-deployer" {
    metadata {
        namespace = kubernetes_namespace.mainwebsite.metadata.0.name
        name = "github-mainwebsite-deployer"
    }
}

# secret for the deployer service account
resource "kubernetes_secret" "sa-github-mainwebsite-deployer" {
    metadata {
        namespace = kubernetes_namespace.mainwebsite.metadata.0.name
        name = "sa-github-mainwebsite-deployer"
        annotations = {
          "kubernetes.io/service-account.name" = "${kubernetes_service_account.github-mainwebsite-deployer.metadata.0.name}"
        }
    }
    
    type = "kubernetes.io/service-account-token"
}
