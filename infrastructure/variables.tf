# Hetzner secrets
variable "hcloud_token" {
  sensitive = true
  type      = string
}

# Config paths
variable "kubernetes_config_path" {
  default = "../.kubeconfig"
  type    = string
}
variable "talos_config_path" {
  default = "../.talosconfig"
  type    = string
}

# System variables
variable "system_namespace" {
  default = "cloudijs-system"
  type    = string
}

# Git repository
variable "repository_url" {
  default = "https://github.com/cloudijs/platform"
  type    = string
}
variable "repository_ref" {
  default = "refs/heads/main"
  type    = string
}
variable "repository_path" {
  default = "services"
  type    = string
}
