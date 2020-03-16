# infrastructure
Terraform configuration of the ironpeak infrastructure.

Deploy status: ![Deploy](https://github.com/ironPeakServices/infrastructure/workflows/Deploy/badge.svg?branch=master)

## Topology
This repository contains all necessary configuration to bring the full ironpeak.be stack online.

1. Terraform will apply the configuration to our base infrastructure:
    - Cloudflare resources in `modules/cloudflare/`
    - GitHub resources in `modules/github/`
    - Scaleway Kapsule which brings us our Kubernetes cluster in `modules/scaleway/`
    - Kubernetes configuration (shared resources such as namespaces) in `kubernetes/`
2. Install shared application instances via Helm 3 in `helm/`
3. `istio/`: the istio policy configuration via `istioctl`

## Running manually
Test the plan with `terraform plan` or execute it: `terraform apply`.
