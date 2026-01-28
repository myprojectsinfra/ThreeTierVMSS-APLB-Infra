variable "backend_pool_id" {

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
      vmss_instances       = number
      admin_username       = string
      admin_password       = string
      nic_name             = string
      subnet_name          = string
      virtual_network_name = string


    }
  ))

}

variable "vmss_role" {}