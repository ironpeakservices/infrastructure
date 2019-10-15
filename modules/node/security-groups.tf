locals {
  tcpPorts = ["${var.ssh_port}", 80, 433, 2377, 7946]
  udpPorts = [7946, 4789]
}

resource "scaleway_security_group" "swarm_instance" {
  name        = "swarm_instances"
  description = "Allow SSH, HTTP(S) and internal Swarm traffic"

  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"
  stateful                = true

  dynamic "inbound_rule" {
    for_each = local.tcpPorts
    content {
      action    = "accept"
      port      = inbound_rule.value
      protocol  = "TCP"
    }
  }

  dynamic "inbound_rule" {
    for_each = local.udpPorts
    content {
      action    = "accept"
      port      = inbound_rule.value
      protocol  = "UDP"
    }
  }
}