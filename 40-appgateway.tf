resource "azurerm_application_gateway" "appgw" {
  name                = "agw-aks-private"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "gwipc"
    subnet_id = azurerm_subnet.snet_appgw.id
  }

  frontend_ip_configuration {
    name                          = "frontendPrivateIP"
    subnet_id                     = azurerm_subnet.snet_appgw.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.10"
  }

  frontend_port {
    name = "frontendPortHttp"
    port = 80
  }

  backend_address_pool {
    name = "backendPoolAks"
  }

  backend_http_settings {
    name                  = "backendHttpSettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "frontendPrivateIP"
    frontend_port_name             = "frontendPortHttp"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "httpListener"
    backend_address_pool_name  = "backendPoolAks"
    backend_http_settings_name = "backendHttpSettings"
  }
}
