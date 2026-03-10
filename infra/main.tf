module "kubernetes" {
  source  = "hcloud-k8s/kubernetes/hcloud"
  version = "3.26.1"

  # General configuration
  cluster_name = "platform"
  hcloud_token = var.hcloud_token

  cluster_delete_protection = false

  # Export configs for talosctl and kubectl
  cluster_kubeconfig_path  = var.kubernetes_config_path
  cluster_talosconfig_path = var.talos_config_path

  # Firewall configuration
  firewall_use_current_ipv4 = true

  # Enable Cilium Gateway API and Cert Manager
  cert_manager_enabled       = true
  cilium_gateway_api_enabled = true

  control_plane_nodepools = [
    { name = "control", type = "cx23", location = "fsn1", count = 1 }
  ]
  worker_nodepools = [
    { name = "worker", type = "cx33", location = "fsn1", count = 2 }
  ]
}

# Setup Cloudijs System
module "cloudijs-system" {
  depends_on = [module.kubernetes]
  source     = "./modules/cloudijs-system"

  namespace       = var.system_namespace
  repository_url  = var.repository_url
  repository_ref  = var.repository_ref
  repository_path = var.repository_path
}