[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

# Cloudijs Platform

Hosting platform based on Kubernetes. This repository contain the Terraform used to setup this platform on [Hetzner](https://www.hetzner.com). The platform relies heavily on the amazing [terraform-hcloud-kubernetes](https://github.com/hcloud-k8s/terraform-hcloud-kubernetes) Terraform module.

## Deployment

To deploy the platform you will need a Hetzner account and create a [token](https://docs.hetzner.com/cloud/api/getting-started/generating-api-token/). In this example a Hetzner object storage is used for storing the Terraform state. Then run Terraform or Tofu after setting the required variables:
```bash
export TF_VAR_HCLOUD_TOKEN="<your-token>"
export TF_VAR_STATE_BUCKET_NAME="<your-object-storage-bucket-name>"
export TF_VAR_STATE_BUCKET_ACCESS_KEY="<your-s3-credentials-access-key>"
export TF_VAR_STATE_BUCKET_SECRET_KEY="<your-s3-credentials-secret-key>"
terraform plan
terraform apply
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