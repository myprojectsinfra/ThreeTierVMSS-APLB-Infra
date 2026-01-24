output "lb_backend_pool_id" {
  description = "Backend address pool IDs per Load Balancer"
  value = {
    for k, lb in azurerm_lb.internal :
    k => one([
      for pool_k, pool in azurerm_lb_backend_address_pool.backend_pool :
      pool.id
      if pool_k == k && pool.name == "lbbackendpool"
    ])
  }
}
