resource "azurerm_linux_virtual_machine_scale_set" "myVMSS" {
  depends_on          = [data.azurerm_subnet.mysubnet]
  for_each            = var.vmss_config
  name                = each.value.vmss_name
  location            = each.value.vmss_location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku_size
  instances           = 1
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  # REQUIRED to allow password login
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  network_interface {
    name    = each.value.nic_name
    primary = true

    ip_configuration {
      name                                         = "internal"
      primary                                      = true
      subnet_id                                    = data.azurerm_subnet.mysubnet[each.key].id
      application_gateway_backend_address_pool_ids = var.vmss_role == "frontend" ? [var.backend_pool_id] : null
      load_balancer_backend_address_pool_ids       = var.vmss_role == "backend" ? [var.backend_pool_id] : null

    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  custom_data = base64encode(<<EOF
#!/bin/bash
apt-get update
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
EOF
  )
}
