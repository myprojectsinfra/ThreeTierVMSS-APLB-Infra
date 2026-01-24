
resource "azurerm_resource_group" "myrg" {
  for_each   = var.rg_config
  name       = each.value.resource_group_name
  location   = each.value.resource_group_location
  managed_by = each.value.managed_by
  tags       = var.tags

}