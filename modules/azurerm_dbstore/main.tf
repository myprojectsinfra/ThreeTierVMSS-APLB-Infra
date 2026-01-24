resource "azurerm_mssql_server" "threetier-dbserver" {
  # depends_on                   = [data.azurerm_key_vault_secret.dbmusername, data.azurerm_key_vault_secret.dbpassword]
  for_each                     = var.dbstore
  name                         = each.value.sql_server_name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.sql_server_location
  version                      = "12.0"
  administrator_login          = "ankitadmin"
  administrator_login_password = "Password@123#"
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "threetier-db" {
  depends_on   = [azurerm_mssql_server.threetier-dbserver]
  for_each     = var.dbstore
  name         = each.value.sql_database_name
  server_id    = azurerm_mssql_server.threetier-dbserver[each.key].id
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

}