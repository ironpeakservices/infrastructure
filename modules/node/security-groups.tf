resource "scaleway_instance_security_group" "node_rules" {
  name        = "node_rules"
  description = "Set node rules"

  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  dynamic "inbound_rule" {
    for_each = local.open_tcp_ports
    content {
      action    = "accept"
      port      = inbound_rule.value
      protocol  = "TCP"
    }
  }

  dynamic "inbound_rule" {
    for_each = local.open_udp_ports
    content {
      action    = "accept"
      port      = inbound_rule.value
      protocol  = "UDP"
    }
  }
}