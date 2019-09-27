data "template_file" "docker_conf" {
  template = "${file("${path.module}/conf/docker.tpl")}"
}

data "template_file" "docker_daemon_json" {
  template = "${file("${path.module}/conf/daemon.tpl")}"

  vars = {
    ip = "${var.docker_api_ip}"
  }
}

// ----

provisioner "remote-exec" {
    inline = [
        "chmod 400 /etc/docker/* /etc/docker/certs/*",

        "echo 'DOCKER_CONTENT_TRUST=1' | sudo tee -a /etc/environment",

        "useradd --home-dir /home/container --user-group --create-home --shell /bin/true container",
        "chown container:container -R /home/container",
        "passwd -l container"
    ]
}

provisioner "remote-exec" {
    inline = [
      # directory to store the node/master certs for the docker api
      "mkdir /etc/docker/certs",
      # make it u=rx,g=,o=
      "chmod 550 /etc/docker /etc/docker/certs",
    ]
  }

  provisioner "local-exec" {
    command = "chmod +x ${path.module}/scripts/tlsgen-node.sh && ${path.module}/scripts/tlsgen-node.sh ${self.private_ip} ${self.public_ip}"
  }

  provisioner "file" {
    source = "./certs/ca.pem"
    destination = "/etc/docker/certs/ca.pem"
  }
  provisioner "file" {
    source = "./certs/${self.private_ip}/server-key.pem"
    destination = "/etc/docker/certs/swarm-priv-key.pem"
  }
  provisioner "file" {
    source = "./certs/${self.private_ip}/server-cert.pem"
    destination = "/etc/docker/certs/swarm-cert.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /etc/systemd/system/docker.service.d",
    ]
  }

  provisioner "file" {
    content     = "${data.template_file.docker_conf.rendered}"
    destination = "/etc/systemd/system/docker.service.d/docker.conf"
  }

  provisioner "file" {
    content     = "${data.template_file.docker_daemon_json.rendered}"
    destination = "/etc/docker/daemon.json"
  }

  provisioner "remote-exec" {
        inline = [
            "systemctl daemon-reload",
            "systemctl restart docker",
        ]
  }

  # drain worker on destroy
  provisioner "remote-exec" {
    when = "destroy"

    inline = [
      "docker node update --availability drain ${self.name}",
    ]

    on_failure = "continue"

    connection {
      type = "ssh"
      user = "root"
      host = "${scaleway_ip.swarm_manager_ip.0.ip}"
    }
  }

  # leave swarm on destroy
  provisioner "remote-exec" {
    when = "destroy"

    inline = [
      "docker swarm leave",
    ]

    on_failure = "continue"
  }

  # remove node on destroy
  provisioner "remote-exec" {
    when = "destroy"

    inline = [
      "docker node rm --force ${self.name}",
    ]

    on_failure = "continue"

    connection {
      type = "ssh"
      user = "root"
      host = "${scaleway_ip.swarm_manager_ip.0.ip}"
    }
  }

    # extract the swarm tokens
    data "external" "swarm_tokens" {
    program = ["${path.module}/scripts/fetch-tokens.sh"]

    query = {
        host = "${scaleway_ip.swarm_manager_ip.0.ip}"
        sshkeypath = "${var.ssh_root_private_key}"
    }

    depends_on = ["scaleway_server.swarm_manager"]
    }

}
