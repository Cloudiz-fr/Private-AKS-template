resource "azurerm_user_assigned_identity" "agic" {
  name                = "uai-agic-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
