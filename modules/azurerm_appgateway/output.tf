output "backend_pool_id" {
  description = "Backend address pool IDs per Application Gateway"
  value = {
    for k, appgw in azurerm_application_gateway.appgw :
    k => one([
      for pool in appgw.backend_address_pool :
      pool.id
      if pool.name == "frontend-vmss-pool"
    ])
  }
}