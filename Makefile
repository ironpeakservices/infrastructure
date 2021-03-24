TERRAFORM_DIR="terraform/"
TERRAFORM_VARFILE="test.tfvars"
TERRAFORM_GCLOUD_CONFIG="terraform-sa.json"

all: validate plan

clean:
	rm .terraform.lock.hcl || true
	rm -r .terraform/ || true
	rm .terraform.lock.hcl || true

init:
	terraform init $(TERRAFORM_DIR)

validate:
	terraform validate $(TERRAFORM_DIR)

plan:
	terraform plan \
		-lock=false \
		-input=false \
		-var 'gcloud_client_config=$(shell cat $(TERRAFORM_GCLOUD_CONFIG))' \
		-var-file=$(TERRAFORM_VARFILE) \
		$(TERRAFORM_DIR)

apply:
	terraform apply \
		-auto-approve \
		-lock=false \
		-input=false \
		-var 'gcloud_client_config=$(shell cat $(TERRAFORM_GCLOUD_CONFIG))' \
		-var-file=$(TERRAFORM_VARFILE) \
		$(TERRAFORM_DIR)
