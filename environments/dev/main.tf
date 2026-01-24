locals {
  common_tags = {
    environment = "dev"
    owner       = "DevOps Team"
  }
}

module "rg_module" {
  source    = "../../modules/azurerm_resource_group"
  rg_config = var.rg_config
  tags      = local.common_tags
}

module "network_module" {
  depends_on = [module.rg_module]
  source     = "../../modules/azurerm_virtual_network"
  networks   = var.networks
}

module "ipaddress_module" {
  depends_on       = [module.rg_module, module.network_module]
  source           = "../../modules/azurerm_public_ip"
  public_ip_config = var.public_ip_config
}

module "bastion_module" {
  depends_on     = [module.rg_module, module.network_module, module.ipaddress_module]
  source         = "../../modules/azurerm_bastion_host"
  bastion_config = var.bastion_config
}

module "appgtw_module" {
  depends_on    = [module.rg_module, module.network_module, module.ipaddress_module]
  source        = "../../modules/azurerm_appgateway"
  appgtw_config = var.appgtw_config
}

module "vmss_module" {
  depends_on      = [module.rg_module, module.network_module, module.ipaddress_module, module.appgtw_module]
  source          = "../../modules/azurerm_vmss"
  vmss_config     = var.vmss_config
  vmss_role       = "frontend"
  backend_pool_id = module.appgtw_module.backend_pool_id["appgtw1"]
}

module "ilb_module" {
  depends_on          = [module.rg_module, module.network_module, module.ipaddress_module]
  source              = "../../modules/azurerm_load_balancer"
  loadbalancer_config = var.loadbalancer_config
}

module "vmss_module_back" {
  depends_on      = [module.rg_module, module.network_module, module.ipaddress_module, module.appgtw_module, module.ilb_module]
  source          = "../../modules/azurerm_vmss"
  vmss_config     = var.vmss_back_config
  vmss_role       = "backend"
  backend_pool_id = module.ilb_module.lb_backend_pool_id["lb1"]
}

module "dbstore" {
  depends_on = [module.rg_module, module.network_module, module.ipaddress_module, module.appgtw_module, module.ilb_module]
  source     = "../../modules/azurerm_dbstore"
  dbstore    = var.dbstore
}