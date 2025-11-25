# Optionnel : ressources de stockage pour le backend distant
# ⚠️ Ces ressources doivent exister avant le premier `terraform init`
# Tu peux les créer à la main ou via un projet de bootstrap séparé.

resource "azurerm_resource_group" "rg_state" {
  name     = "rg-tfstate"
  location = "westeurope"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "stterraformstate001"
  resource_group_name      = azurerm_resource_group.rg_state.name
  location                 = azurerm_resource_group.rg_state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
