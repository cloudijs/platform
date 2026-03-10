# Create namespace for Cloudijs system deployments
resource "kubernetes_namespace_v1" "platform_system" {
  metadata {
    name = var.namespace
  }
}

# Deploy and configure Flux Operator
resource "helm_release" "flux_operator" {
  depends_on = [kubernetes_namespace_v1.platform_system]

  name       = "flux-operator"
  namespace  = var.namespace
  repository = "oci://ghcr.io/controlplaneio-fluxcd/charts"
  chart      = "flux-operator"
}

resource "helm_release" "flux_instance" {
  depends_on = [helm_release.flux_operator]

  name       = "flux"
  namespace  = var.namespace
  repository = "oci://ghcr.io/controlplaneio-fluxcd/charts"
  chart      = "flux-instance"

  set = [
    {
      name  = "instance.sync.kind"
      value = "GitRepository"
    },
    {
      name  = "instance.sync.url"
      value = var.repository_url
    },
    {
      name  = "instance.sync.ref"
      value = var.repository_ref
    },
    {
      name  = "instance.sync.path"
      value = var.repository_path
    }
  ]
}