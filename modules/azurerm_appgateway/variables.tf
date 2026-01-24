variable "appgtw_config" {
  description = "This contains the configuration values for Application Gateway"
  type = map(object(
    {
      appgtw_name     = string
      appgtw_location = string

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