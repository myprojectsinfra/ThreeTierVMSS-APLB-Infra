variable "dbstore" {
  description = "The configuration of the database and database server"
  type = map(object({
    resource_group_name = string
    sql_server_location = string
    sql_server_name     = string
    sql_database_name   = string
    key_vault_rg_name   = string
    key_vault_name      = string
    key_vault_user      = string
    key_vault_pass      = string

  }))
}