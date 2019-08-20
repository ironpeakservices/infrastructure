# infrastructure
Terraform configuration of the ironpeak infrastructure.


## Running manually
Test the plan: `terraform plan -var 'ssh_private_key_path=my-key' -var 'ssh_public_key_path=my-pub' -var 'api_token=SCALEWAY_API_TOKEN'`
Execute the plan: `terraform apply -auto-approve -var 'ssh_private_key_path=my-key' -var 'ssh_public_key_path=my-pub' -var 'api_token=SCALEWAY_API_TOKEN'`
