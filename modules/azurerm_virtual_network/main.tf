resource "azurerm_virtual_network" "myvnet" {
  for_each            = var.networks
  name                = each.value.virtual_network_name
  location            = each.value.virtual_network_location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space

  dynamic "subnet" {
    for_each = each.value.subnets
    content {
      name             = subnet.value.subnet_name
      address_prefixes = subnet.value.address_prefixes
    }
  }

  tags = { for k, v in each.value.tags : k => v.value }
}