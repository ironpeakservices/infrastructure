resource "scaleway_security_group" "swarm_managers" {
  name                    = "swarm_managers"
  description             = "Whitelist HTTP(S) and SSH traffic"

  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"
  stateful                = true
}

resource "scaleway_security_group_rule" "ssh_accept" {
  security_group = "${scaleway_security_group.swarm_managers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = "${var.ssh_port}"
}
resource "scaleway_security_group_rule" "http_accept" {
  security_group = "${scaleway_security_group.swarm_managers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 80
}

resource "scaleway_security_group_rule" "https_accept" {
  security_group = "${scaleway_security_group.swarm_managers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 443
}

resource "scaleway_security_group_rule" "swarm_tcp_2377_accept" {
  security_group = "${scaleway_security_group.swarm_managers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "TCP"
  port      = 2377
}

resource "scaleway_security_group_rule" "swarm_tcp_7946_accept" {
  security_group = "${scaleway_security_group.swarm_managers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "TCP"
  port      = 7946
}

resource "scaleway_security_group_rule" "swarm_udp_7946_accept" {
  security_group = "${scaleway_security_group.swarm_managers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "UDP"
  port      = 7946
}

resource "scaleway_security_group_rule" "swarm_udp_4789_accept" {
  security_group = "${scaleway_security_group.swarm_managers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "UDP"
  port      = 4789
}

# -----

resource "scaleway_security_group" "swarm_workers" {
  name        = "swarm_workers"
  description = "Allow SSH traffic"

  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"
  stateful                = true
}

resource "scaleway_security_group_rule" "ssh_accept_workers" {
  security_group = "${scaleway_security_group.swarm_workers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = "${var.ssh_port}"
}

resource "scaleway_security_group_rule" "http_accept_workers" {
  security_group = "${scaleway_security_group.swarm_workers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 80
}

resource "scaleway_security_group_rule" "https_accept_workers" {
  security_group = "${scaleway_security_group.swarm_workers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 443
}

resource "scaleway_security_group_rule" "swarm_tcp_2377_accept_workers" {
  security_group = "${scaleway_security_group.swarm_workers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "TCP"
  port      = 2377
}

resource "scaleway_security_group_rule" "swarm_tcp_7946_accept_workers" {
  security_group = "${scaleway_security_group.swarm_workers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "TCP"
  port      = 7946
}

resource "scaleway_security_group_rule" "swarm_udp_7946_accept_workers" {
  security_group = "${scaleway_security_group.swarm_workers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "UDP"
  port      = 7946
}

resource "scaleway_security_group_rule" "swarm_udp_4789_accept_workers" {
  security_group = "${scaleway_security_group.swarm_workers.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "${var.private_subnet}"
  protocol  = "UDP"
  port      = 4789
}
