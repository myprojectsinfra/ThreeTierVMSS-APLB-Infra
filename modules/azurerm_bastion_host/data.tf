data "azurerm_subnet" "bastionsubnet" {
  for_each             = var.bastion_config
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "bastionpip" {
  for_each            = var.bastion_config
  name                = each.value.bastion_pip
  resource_group_name = each.value.resource_group_name
}

