terraform {
  backend "azurerm" {
    # À adapter avec tes valeurs réelles de stockage d'état
    resource_group_name  = "rg-tfstate"
    storage_account_name = "stterraformstate001"
    container_name       = "tfstate"
    key                  = "aks-private-appgw/terraform.tfstate"
  }
}
