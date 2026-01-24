data "azurerm_subnet" "mysubnet" {
  for_each             = var.vmss_config
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}