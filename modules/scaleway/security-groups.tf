resource "scaleway_instance_security_group" "swarm_managers" {
  name                    = "swarm_managers"
  description             = "Whitelist HTTP(S) and SSH traffic"

  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"
 
  inbound_rule {
    action    = "accept"
    ip_range  = "0.0.0.0/0"
    protocol  = "TCP"
    port      = var.ssh_port
  }

  inbound_rule {
    action    = "accept"
    ip_range  = "0.0.0.0/0"
    protocol  = "TCP"
    port      = 80
  }

  inbound_rule {
    action    = "accept"
    ip_range  = "0.0.0.0/0"
    protocol  = "TCP"
    port      = 443
  }

  inbound_rule {
    action    = "accept"
    ip_range  = var.private_subnet
    protocol  = "TCP"
    port      = 2377
  }

  inbound_rule {
    action    = "accept"
    ip_range  = var.private_subnet
    protocol  = "TCP"
    port      = 7946
  }

  inbound_rule {
    action    = "accept"
    ip_range  = var.private_subnet
    protocol  = "UDP"
    port      = 7946
  }

  inbound_rule {
    action    = "accept"
    ip_range  = var.private_subnet
    protocol  = "UDP"
    port      = 4789
  }
}

# -----

resource "scaleway_instance_security_group" "swarm_workers" {
  name        = "swarm_workers"
  description = "Allow SSH traffic"

  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action    = "accept"
    ip_range  = "0.0.0.0/0"
    protocol  = "TCP"
    port      = var.ssh_port
  }

  inbound_rule {
    action    = "accept"
    ip_range  = "0.0.0.0/0"
    protocol  = "TCP"
    port      = 80
  }

  inbound_rule {
    action    = "accept"
    ip_range  = "0.0.0.0/0"
    protocol  = "TCP"
    port      = 443
  }

  inbound_rule {
    action    = "accept"
    ip_range  = var.private_subnet
    protocol  = "TCP"
    port      = 2377
  }

  inbound_rule {
    action    = "accept"
    ip_range  = var.private_subnet
    protocol  = "TCP"
    port      = 7946
  }

  inbound_rule {
    action    = "accept"
    ip_range  = var.private_subnet
    protocol  = "UDP"
    port      = 7946
  }

  inbound_rule {
    action    = "accept"
    ip_range  = var.private_subnet
    protocol  = "UDP"
    port      = 4789
  }
}