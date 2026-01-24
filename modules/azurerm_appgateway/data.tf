data "azurerm_subnet" "appgw" {
  for_each             = var.appgtw_config
  name                 = each.value.appgtw_subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "appgw_pip" {
  for_each            = var.appgtw_config
  name                = each.value.appgtw_pip_name
  resource_group_name = each.value.resource_group_name
}


