data "kubernetes_secret" "cloudflared_cert_pem" {
    metadata {
        name = "cloudflared_cert_pem"
    }

    type = "Opaque"

    data {
        cert = var.cloudflared_tunnel_token
    }
}