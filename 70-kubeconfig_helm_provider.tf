data "azurerm_kubernetes_cluster" "aks_creds" {
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = azurerm_resource_group.rg.name
}

locals {
  kubeconfig = data.azurerm_kubernetes_cluster.aks_creds.kube_config_raw
}

output "kubeconfig" {
  value     = local.kubeconfig
  sensitive = true
}

provider "helm" {
  kubernetes {
    host                   = yamldecode(local.kubeconfig)["clusters"][0]["cluster"]["server"]
    client_certificate     = base64decode(yamldecode(local.kubeconfig)["users"][0]["user"]["client-certificate-data"])
    client_key             = base64decode(yamldecode(local.kubeconfig)["users"][0]["user"]["client-key-data"])
    cluster_ca_certificate = base64decode(yamldecode(local.kubeconfig)["clusters"][0]["cluster"]["certificate-authority-data"])
  }
}
