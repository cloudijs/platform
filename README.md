[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

# Cloudijs Platform

Hosting platform based on Kubernetes. This repository contain the Terraform code used to setup this platform on [Hetzner](https://www.hetzner.com). The platform relies heavily on the amazing [terraform-hcloud-kubernetes](https://github.com/hcloud-k8s/terraform-hcloud-kubernetes) Tofu/Terraform module.

## Pre-requisites

* [Hetzner Account](https://www.hetzner.com)
* [OpenTofu](https://opentofu.org/docs/intro/install/)
* [Taskfile](https://taskfile.dev/docs/installation)

## Deployment

To deploy the platform you will need a Hetzner account, create an S3 bucket and create an [API token](https://docs.hetzner.com/cloud/api/getting-started/generating-api-token/). Make sure to gather the values for the S3 bucket configuration. These can be specified as environment variables or in an `.env` file:
```sh
export HCLOUD_TOKEN="<your-token>"

export STATE_BUCKET_NAME="<your-object-storage-bucket-name>"
export STATE_BUCKET_KEY="<your-object-storage-bucket-key>"

export STATE_BUCKET_ACCESS_KEY="<your-s3-credentials-access-key>"
export STATE_BUCKET_SECRET_KEY="<your-s3-credentials-secret-key>"
```
```
# .env

HCLOUD_TOKEN="<your-token>"

STATE_BUCKET_NAME="<your-object-storage-bucket-name>"
STATE_BUCKET_KEY="<your-object-storage-bucket-key>"

STATE_BUCKET_ACCESS_KEY="<your-s3-credentials-access-key>"
STATE_BUCKET_SECRET_KEY="<your-s3-credentials-secret-key>"
```
Run Tofu after setting the required variables to setup the platform:
```sh
task create
```
Other available tasks like destroying the environment can be found using the `task` command.

## Operations

Suspend and resume reconcilation in Flux:
```sh
flux suspend source git cloudijs-system -n cloudijs-system
flux resume source git cloudijs-system -n cloudijs-system
```

## Sources

* https://github.com/hcloud-k8s/terraform-hcloud-kubernetes
* https://registry.terraform.io/modules/hcloud-k8s/kubernetes/hcloud/latest
* https://registry.terraform.io/providers/hetznercloud/hcloud/latest
* https://docs.hetzner.cloud/changelog#2025-04-23-talos-linux-v195-iso-now-available
* https://github.com/hetznercloud/hcloud-cloud-controller-manager/tree/main
* https://github.com/dflook/terraform-github-actions

## License

[MIT license](LICENSE)
