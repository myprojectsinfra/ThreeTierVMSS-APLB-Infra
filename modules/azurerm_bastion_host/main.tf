resource "azurerm_bastion_host" "bastion" {
  depends_on          = [data.azurerm_public_ip.bastionpip, data.azurerm_subnet.bastionsubnet]
  for_each            = var.bastion_config
  name                = each.value.bastion_name
  location            = each.value.bastion_location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.bastion_ip_name
    subnet_id            = data.azurerm_subnet.bastionsubnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.bastionpip[each.key].id
  }
}