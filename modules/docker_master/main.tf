module "docker" { source = "../docker"

    is_master            = true

    ssh_root_private_key = "${var.ssh_root_private_key}"
    ssh_root_public_key  = "${var.ssh_root_public_key}"

    provider "scaleway" {

        organization            = "${var.scaleway_organization}"
        api_token               = "${var.scaleway_api_token}"
        ssh_root_private_key    = "${var.ssh_root_private_key}"
        ssh_root_public_key     = "${var.ssh_root_public_key}"
        ssh_tech_public_key     = "${var.ssh_tech_public_key}"

        tags            = [ "docker", "swarm_master" ]
        instance_count  = "${var.manager_instance_count}"

        provisioner "remote-exec" {
            inline = [
                "docker swarm init --advertise-addr ${self.private_ip}",
            ]
        }

    }

}