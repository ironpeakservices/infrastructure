module "docker" {
    source = "./modules/docker"

    is_master            = false
    
    ssh_root_private_key = "${var.ssh_root_private_key}"
    ssh_root_public_key  = "${var.ssh_root_public_key}"

    provider "scaleway" {

        organization            = "${var.scaleway_organization}"
        api_token               = "${var.scaleway_api_token}"
        ssh_root_private_key    = "${var.ssh_root_private_key}"
        ssh_root_public_key     = "${var.ssh_root_public_key}"
        ssh_tech_public_key     = "${var.ssh_tech_public_key}"

        tags            = [ "docker", "swarm_worker" ]
        instance_count  = "${var.worker_instance_count}"

        provisioner "remote-exec" {
            inline = [
                "docker swarm join --token ${data.external.swarm_tokens.result.worker} ${scaleway_server.swarm_manager.0.private_ip}:2377",
            ]
        }

    }

}