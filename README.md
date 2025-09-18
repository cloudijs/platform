[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

# Cloudijs Platform

Hosting platform based on Kubernetes. This repository contain the IAC used to setup this platform on [Hetzner](https://www.hetzner.com). The platform relies heavily on the amazing [terraform-hcloud-kubernetes](https://github.com/hcloud-k8s/terraform-hcloud-kubernetes) Terraform module.

## Deployment

To deploy the platform you will need a Hetzer account and create a [token](https://docs.hetzner.com/cloud/api/getting-started/generating-api-token/). Then run Terraform or Tofu after setting the token variable:
```bash
export TF_VAR_hcloud_token="<your-token>"
tofu plan
tofy apply
```

## Sources

* https://github.com/hcloud-k8s/terraform-hcloud-kubernetes
* https://registry.terraform.io/modules/hcloud-k8s/kubernetes/hcloud/latest
* https://registry.terraform.io/providers/hetznercloud/hcloud/latest
* https://docs.hetzner.cloud/changelog#2025-04-23-talos-linux-v195-iso-now-available
* https://github.com/hetznercloud/hcloud-cloud-controller-manager/tree/main

## License

[MIT license](LICENSE)