terraform {
  required_version = ">=1.9.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.1.1"
    }
  }
}

provider "kubernetes" {
  host = module.kubernetes.kubeconfig_data["server"]

  cluster_ca_certificate = module.kubernetes.kubeconfig_data["ca"]

  client_certificate = module.kubernetes.kubeconfig_data["cert"]
  client_key         = module.kubernetes.kubeconfig_data["key"]
}

provider "helm" {
  kubernetes = {
    host = module.kubernetes.kubeconfig_data["server"]

    cluster_ca_certificate = module.kubernetes.kubeconfig_data["ca"]

    client_certificate = module.kubernetes.kubeconfig_data["cert"]
    client_key         = module.kubernetes.kubeconfig_data["key"]
  }
}
