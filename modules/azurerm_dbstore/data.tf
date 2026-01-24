# data "azurerm_key_vault" "mydatakv" {
#   for_each            = var.dbstore
#   name                = each.value.key_vault_name
#   resource_group_name = each.value.key_vault_rg_name
# }
# data "azurerm_key_vault_secret" "dbmusername" {
#   for_each     = var.dbstore
#   name         = each.value.key_vault_user
#   key_vault_id = data.azurerm_key_vault.mydatakv[each.key].id
# }

# data "azurerm_key_vault_secret" "dbpassword" {
#   for_each     = var.dbstore
#   name         = each.value.key_vault_pass
#   key_vault_id = data.azurerm_key_vault.mydatakv[each.key].id
# }