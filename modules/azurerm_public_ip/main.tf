resource "azurerm_public_ip" "ankit_public_ip" {
  for_each            = var.public_ip_config
  name                = each.value.public_ip_address_name
  location            = each.value.public_ip_address_location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}