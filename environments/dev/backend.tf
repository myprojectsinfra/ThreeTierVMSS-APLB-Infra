terraform {
  backend "azurerm" {
    resource_group_name  = "mybackendrg"
    storage_account_name = "mybackstoreaccnt"
    container_name       = "myblobcontainer"
    key                  = "threetierVMSS.tfstate"
  }
}