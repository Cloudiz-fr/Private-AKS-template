resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-private-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksprivdemo"

  private_cluster_enabled = true

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name           = "system"
    node_count     = 2
    vm_size        = "Standard_D4ds_v5"
    vnet_subnet_id = azurerm_subnet.snet_aks.id
  }

  network_profile {
    network_plugin = "azure"
    outbound_type  = "userDefinedRouting"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  ingress_application_gateway {
    gateway_id = azurerm_application_gateway.appgw.id

    identity {
      type                      = "UserAssigned"
      user_assigned_identity_id = azurerm_user_assigned_identity.agic.id
    }
  }
}
