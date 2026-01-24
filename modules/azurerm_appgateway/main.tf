resource "azurerm_application_gateway" "appgw" {
  for_each            = var.appgtw_config
  name                = each.value.appgtw_name
  location            = each.value.appgtw_location
  resource_group_name = each.value.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = each.value.ip_gtw_config_name
    subnet_id = data.azurerm_subnet.appgw[each.key].id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = each.value.front_ipcfg_name
    public_ip_address_id = data.azurerm_public_ip.appgw_pip[each.key].id
  }

  backend_address_pool {
    name = each.value.appgw_back_add_pool_name
  }

  backend_http_settings {
    name                  = "http-settings"
    protocol              = "Http"
    port                  = 80
    request_timeout       = 30
    cookie_based_affinity = "Disabled"
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "public-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "http-rule"
    rule_type                  = "Basic"
    priority                   = 100
    http_listener_name         = "http-listener"
    backend_address_pool_name  = each.value.appgw_back_add_pool_name
    backend_http_settings_name = "http-settings"
  }
}
