resource "scaleway_security_group" "swarm_instance" {
  name        = "swarm_instances"
  description = "Allow SSH, HTTP(S) and internal Swarm traffic"

  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"
  stateful                = true
}

resource "scaleway_security_group_rule" "ssh_accept" {
  security_group = "${scaleway_security_group.swarm_instance.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = "${var.ssh_port}"
}

resource "scaleway_security_group_rule" "http_accept" {
  security_group = "${scaleway_security_group.swarm_instance.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 80
}

resource "scaleway_security_group_rule" "https_accept" {
  security_group = "${scaleway_security_group.swarm_instance.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 443
}

resource "scaleway_security_group_rule" "swarm_tcp_2377_accept" {
  security_group = "${scaleway_security_group.swarm_instance.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "TCP"
  port      = 2377
}

resource "scaleway_security_group_rule" "swarm_tcp_7946_accept" {
  security_group = "${scaleway_security_group.swarm_instance.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "TCP"
  port      = 7946
}

resource "scaleway_security_group_rule" "swarm_udp_7946_accept" {
  security_group = "${scaleway_security_group.swarm_instance.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "UDP"
  port      = 7946
}

resource "scaleway_security_group_rule" "swarm_udp_4789_accept" {
  security_group = "${scaleway_security_group.swarm_instance.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "UDP"
  port      = 4789
}