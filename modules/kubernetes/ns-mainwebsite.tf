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
resource "kubernetes_network_policy" "default_networkpolicy" {
  metadata {
    name      = "default-networkpolicy"
    namespace = kubernetes_namespace.mainwebsite.metadata.0.name
  }

  spec {
    pod_selector {}
    policy_types = ["Ingress", "Egress"]
  }
}

# have a service account to deploy
resource "kubernetes_service_account" "github_mainwebsite_deployer" {
    metadata {
        namespace = kubernetes_namespace.mainwebsite.metadata.0.name
        name = "github-mainwebsite-deployer"
    }
}

# secret for the deployer service account
resource "kubernetes_secret" "sa_github_mainwebsite_deployer" {
    metadata {
        namespace = kubernetes_namespace.mainwebsite.metadata.0.name
        name = "sa-github-mainwebsite-deployer"
        annotations = {
          "kubernetes.io/service-account.name" = "${kubernetes_service_account.github-mainwebsite-deployer.metadata.0.name}"
        }
    }
    
    type = "kubernetes.io/service-account-token"
}

# deployer role for GitHub
resource "kubernetes_role" "ro_github_mainwebsite_deployer" {
  metadata {
    name = "ro-github-mainwebsite-deployer"
    namespace = kubernetes_namespace.mainwebsite.metadata.0.name
  }

  rule {
    api_groups     = ["", "extensions", "apps"]
    resources      = ["deployments", "replicasets", "pods"]
    verbs          = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

# now bind the role to the user
resource "kubernetes_role_binding" "rb_github_mainwebsite_deployer" {
  metadata {
    name      = "rb-github-mainwebsite-deployer"
    namespace = kubernetes_namespace.mainwebsite.metadata.0.name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.github_mainwebsite_deployer.metadata.0.name
  }
}
