# infrastructure

Terraform configuration of the ironpeak infrastructure.

Deploy status: ![Deploy](https://github.com/ironPeakServices/infrastructure/workflows/Deploy/badge.svg?branch=master)

##
 Topology
This repository contains all necessary configuration to bring the full ironpeak.be stack online.

1. Terraform will apply the configuration to our base infrastructure:
    - Cloudflare resources in `modules/cloudflare/`
    - GitHub resources in `modules/github/`
    - Scaleway Kapsule which brings us our Kubernetes cluster in `modules/scaleway/`
    - Kubernetes configuration (shared resources such as namespaces) in `kubernetes/`
2. Install shared application instances via Helm 3 in `helm/`
3. `istio/`: the istio policy configuration via `istioctl`

## Requirements

1. Install gcloud and authenticate.

```shell
% gcloud auth login $MY_USER
```

2. Create your google cloud project

```shell
% gcloud projects create --set-as-default --enable-cloud-apis --name $MY_PROJECT
```

3. Link your billing account to the project

```shell
% gcloud beta billing projects link $MY_PROJECT --billing-account $MY_BILLING_ACCOUNT
```

3. Create your terraform service account

```shell
% gcloud iam service-accounts create terraform-sa
```

4. Get the service account credentials

```shell
% gcloud iam service-accounts keys create terraform-sa.json --iam-account "terraform-sa@${MY_PROJECT}.iam.gserviceaccount.com" && chmod u=r,g=,o= terraform-sa.json 
```

5. Now add the required privileges

```shell
% gcloud projects add-iam-policy-binding ${MY_PROJECT} --member "serviceAccount:terraform-sa@${MY_PROJECT}.iam.gserviceaccount.com" --role roles/editor 
```

## Running manually

Run with `make`.
