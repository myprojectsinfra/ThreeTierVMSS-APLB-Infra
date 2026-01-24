resource "azurerm_lb" "internal" {
  for_each            = var.loadbalancer_config
  name                = each.value.lb_name
  location            = each.value.lb_location
  resource_group_name = each.value.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = each.value.front_ip_config_name
    subnet_id                     = data.azurerm_subnet.mysubnet[each.key].id
    private_ip_address_allocation = "Static"
    private_ip_address            = "192.168.3.10"
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  depends_on      = [azurerm_lb.internal]
  for_each        = var.loadbalancer_config
  name            = each.value.lb_backendpool_name
  loadbalancer_id = azurerm_lb.internal[each.key].id
}

resource "azurerm_lb_probe" "backend_probe" {
  depends_on      = [azurerm_lb.internal]
  for_each        = var.loadbalancer_config
  name            = each.value.lb_probe_name
  loadbalancer_id = azurerm_lb.internal[each.key].id
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "backend_rule" {
  depends_on                     = [azurerm_lb.internal, azurerm_lb_backend_address_pool.backend_pool, azurerm_lb_probe.backend_probe]
  for_each        = var.loadbalancer_config
  name                           = "lb-rule"
  loadbalancer_id                = azurerm_lb.internal[each.key].id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = each.value.front_ip_config_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
  probe_id                       = azurerm_lb_probe.backend_probe[each.key].id
}
