output "workspace" {
  value = "${terraform.workspace}"
}

output "public_ip" {
  value = "${scaleway_instance_server.instance.*.public_ip}"
}

output "private_ip" {
  value = "${scaleway_instance_server.instance.*.private_ip}"
}

output "instance_id" {
  value = "${scaleway_instance_server.instance.*.id}"
}