module "kubernetes" {
  source  = "hcloud-k8s/kubernetes/hcloud"
  version = "3.1.0"

  cluster_delete_protection = false

  cluster_name = "platform"
  hcloud_token = var.hcloud_token

  # Export configs for Talos and Kube API access
  cluster_kubeconfig_path  = "kubeconfig"
  cluster_talosconfig_path = "talosconfig"

  # Addons
  cert_manager_enabled  = true
  ingress_nginx_enabled = true

  control_plane_nodepools = [
    { name = "control", type = "cx22", location = "fsn1", count = 1 }
  ]
  worker_nodepools = [
    { name = "worker", type = "cpx11", location = "fsn1", count = 2 }
  ]
}