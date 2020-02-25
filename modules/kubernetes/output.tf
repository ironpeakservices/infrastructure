# these are pass-through values to create an inter-module dependency
# so the kubernetes provider will be a requirement for any modules using these outputs

output host {
    sensitive = true
    value     = var.host
}

output token {
    sensitive = true
    value     = var.token
}

output cluster_ca_certificate {
    sensitive   = true
    value       = var.cluster_ca_certificate
}
