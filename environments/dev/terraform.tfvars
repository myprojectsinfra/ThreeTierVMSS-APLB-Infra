subscription_id = ""
rg_config = {
  rg1 = {
    resource_group_name     = "threetier-appgtw-ilb-vmss-rg"
    resource_group_location = "norwayeast"
    managed_by              = "Terraform"
  }
}

networks = {
  vnet1 = {
    virtual_network_name     = "threetier-appgtw-ilb-vnet"
    resource_group_name      = "threetier-appgtw-ilb-vmss-rg"
    virtual_network_location = "norwayeast"
    address_space            = ["192.168.0.0/16"]
    subnets = {
      subnetappgtw = {
        subnet_name      = "AzureApplicationGatewaySubnet"
        address_prefixes = ["192.168.1.0/24"]
      }
      subnetfront = {
        subnet_name      = "subnetfrontend"
        address_prefixes = ["192.168.2.0/24"]
      }
      subnetbackend = {
        subnet_name      = "subnetbackend"
        address_prefixes = ["192.168.3.0/24"]
      }
      subnetbastion = {
        subnet_name      = "AzureBastionSubnet"
        address_prefixes = ["192.168.4.0/24"]
      }
    }
    tags = {
      environment = {
        value       = "development"
        description = "This Virtual network for development environment"
      }
    }


  }
}

public_ip_config = {
  pipappgtw = {
    public_ip_address_name     = "pip-appgw"
    resource_group_name        = "threetier-appgtw-ilb-vmss-rg"
    public_ip_address_location = "norwayeast"
    allocation_method          = "Static"
    sku                        = "Standard"

  }
  pipbastion = {
    public_ip_address_name     = "pip-bastion"
    resource_group_name        = "threetier-appgtw-ilb-vmss-rg"
    public_ip_address_location = "norwayeast"
    allocation_method          = "Static"
    sku                        = "Standard"

  }
}

bastion_config = {
  bstn1 = {
    bastion_name         = "vmssbackbastion"
    bastion_location     = "norwayeast"
    bastion_ip_name      = "mybastionip"
    resource_group_name  = "threetier-appgtw-ilb-vmss-rg"
    bastion_pip          = "pip-bastion"
    subnet_name          = "AzureBastionSubnet"
    virtual_network_name = "threetier-appgtw-ilb-vnet"
  }

}

appgtw_config = {
  appgtw1 = {
    appgtw_name     = "appgw-frontend"
    appgtw_location = "norwayeast"

    resource_group_name      = "threetier-appgtw-ilb-vmss-rg"
    ip_gtw_config_name       = "appgw-ipcfg"
    appgtw_subnet_name       = "AzureApplicationGatewaySubnet"
    virtual_network_name     = "threetier-appgtw-ilb-vnet"
    front_ipcfg_name         = "public-ip"
    appgtw_pip_name          = "pip-appgw"
    appgw_back_add_pool_name = "frontend-vmss-pool"
  }

}

vmss_config = {
  vmss1 = {
    vmss_name            = "frontend-vmss"
    vmss_location        = "norwayeast"
    resource_group_name  = "threetier-appgtw-ilb-vmss-rg"
    sku_size             = "Standard_D2a_v4"
    vmss_instances       = 1
    admin_username       = "ankitadmin"
    admin_password       = "Passw0rd@123#"
    nic_name             = "frontend-nic"
    subnet_name          = "subnetfrontend"
    virtual_network_name = "threetier-appgtw-ilb-vnet"


  }

}

loadbalancer_config = {
  lb1 = {
    lb_name              = "internalLoadbalance"
    lb_location          = "norwayeast"
    resource_group_name  = "threetier-appgtw-ilb-vmss-rg"
    front_ip_config_name = "lbfrtend-ip"
    subnet_name          = "subnetbackend"
    virtual_network_name = "threetier-appgtw-ilb-vnet"
    lb_backendpool_name  = "lbbackendpool"
    lb_probe_name        = "lbprobename"
  }
}

vmss_back_config = {
  vmss1 = {
    vmss_name            = "backend-vmss"
    vmss_location        = "norwayeast"
    resource_group_name  = "threetier-appgtw-ilb-vmss-rg"
    sku_size             = "Standard_D2a_v4"
    vmss_instances       = 1
    admin_username       = "ankitadmin"
    admin_password       = "Passw0rd@123#"
    nic_name             = "backend-nic"
    subnet_name          = "subnetbackend"
    virtual_network_name = "threetier-appgtw-ilb-vnet"


  }

}

dbstore = {
  dataStore1 = {
    resource_group_name = "threetier-appgtw-ilb-vmss-rg"
    sql_server_location = "norwayeast"
    sql_server_name     = "myinfra-dbserver"
    sql_database_name   = "myinfra-database"
    key_vault_rg_name   = "mybackendrg"
    key_vault_name      = "myappsecretsKv"
    key_vault_user      = "dbusername"
    key_vault_pass      = "dbpassword"


  }
}