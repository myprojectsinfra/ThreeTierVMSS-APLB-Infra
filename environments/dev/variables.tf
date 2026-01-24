variable "subscription_id" {
  description = "The value of the subscription id"
  type        = string
}

variable "rg_config" {
  description = "The configuration values of the resource group"
  type = map(object({
    resource_group_name     = string
    resource_group_location = string
    managed_by              = optional(string)
  }))
}

variable "networks" {
  description = "The Configuration of Virtual Networks"
  type = map(object(
    {
      virtual_network_name     = string
      resource_group_name      = string
      virtual_network_location = string
      address_space            = list(string)
      subnets = optional(map(object(
        {
          subnet_name      = string
          address_prefixes = list(string)
        }
      )), {})
      tags = optional(map(object(
        {
          value       = string
          description = optional(string)
        }
      )), {})
    }
  ))

}

variable "public_ip_config" {
  description = "The Configuration of Public IP address"
  type = map(object(
    {
      public_ip_address_name     = string
      public_ip_address_location = string
      resource_group_name        = string
      allocation_method          = string
      sku                        = string
    }
  ))
}

#Azure Bastion
variable "bastion_config" {
  description = "This contains the configuration values for bastion"
  type = map(object(
    {
      bastion_name         = string
      bastion_location     = string
      bastion_ip_name      = string
      resource_group_name  = string
      bastion_pip          = string
      subnet_name          = string
      virtual_network_name = string
    }
  ))

}
#Azure Application Gateway
variable "appgtw_config" {
  description = "This contains the configuration values for Application Gateway"
  type = map(object(
    {
      appgtw_name              = string
      appgtw_location          = string
      resource_group_name      = string
      ip_gtw_config_name       = string
      appgtw_subnet_name       = string
      virtual_network_name     = string
      front_ipcfg_name         = string
      appgtw_pip_name          = string
      appgw_back_add_pool_name = string

    }
  ))

}

# Virtual machine Scale Set
variable "vmss_config" {
  description = "This contains the configuration values for VMSS"
  type = map(object(
    {
      vmss_name            = string
      vmss_location        = string
      resource_group_name  = string
      sku_size             = string
      admin_username       = string
      admin_password       = string
      nic_name             = string
      subnet_name          = string
      virtual_network_name = string


    }
  ))

}


#Load balancer
variable "loadbalancer_config" {
  description = "This contains the configuration for internal Load balancer"
  type = map(object(
    {
      lb_name              = string
      lb_location          = string
      resource_group_name  = string
      front_ip_config_name = string
      subnet_name          = string
      virtual_network_name = string
      lb_backendpool_name  = string
      lb_probe_name        = string
    }
  ))
}

variable "vmss_back_config" {
  description = "This contains the configuration values for VMSS"
  type = map(object(
    {
      vmss_name            = string
      vmss_location        = string
      resource_group_name  = string
      sku_size             = string
      admin_username       = string
      admin_password       = string
      nic_name             = string
      subnet_name          = string
      virtual_network_name = string


    }
  ))

}

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