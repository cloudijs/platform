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

  # Disable scheduling on control plane nodes
  cluster_allow_scheduling_on_control_planes = false

  control_plane_nodepools = [
    { name = "control", type = "cx23", location = "fsn1", count = 1 }
  ]
  worker_nodepools = [
    { name = "worker", type = "cx33", location = "fsn1", count = 2 }
  ]
}

# Create custom system namespace
resource "kubernetes_namespace_v1" "platform_system" {
  metadata {
    name = var.system_namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels
    ]
  }
}

# Deploy and configure Flux Operator
resource "helm_release" "flux_operator" {
  depends_on = [kubernetes_namespace_v1.platform_system]

  name       = "flux-operator"
  namespace  = var.system_namespace
  repository = "oci://ghcr.io/controlplaneio-fluxcd/charts"
  chart      = "flux-operator"

  values = [
    yamlencode({
      web = {
        config = {
          baseURL = "https://${var.flux_domain}"
          authentication = {
            type = "OAuth2"
            oauth2 = {
              provider = "OIDC"
              clientID = "0a956c2e-32f7-434c-827e-c7c5e4ec4b42"
              clientSecret = "55ctAw8C3oIcXSFtEqGcn4jNCQD8Tha5"
              issuerURL = var.oidc_url
            }
          }
        }
        networkPolicy = {
          create = false
        }
        httpRoute = {
          enabled = true
          parentRefs = [
            {
              name = "shared-gateway-http"
              namespace = var.system_namespace
            }
          ]
          hostnames = [ var.flux_domain ]
        }
      }
      grafana = {
        enabled = true
        adminPassword = "change-me"
        ingress = {
          enabled = true
          hosts   = ["grafana.example.com"]
        }
      }
    })
  ]
}

resource "helm_release" "flux_instance" {
  depends_on = [helm_release.flux_operator]

  name       = "flux"
  namespace  = var.system_namespace
  repository = "oci://ghcr.io/controlplaneio-fluxcd/charts"
  chart      = "flux-instance"

  values = [
    yamlencode({
      instance = {
        cluster = {
          networkPolicy = false
        }
        sync = {
          kind = "GitRepository"
          url  = var.repository_url
          ref  = var.repository_ref
          path = var.repository_path
        }
      }
    })
  ]
}
