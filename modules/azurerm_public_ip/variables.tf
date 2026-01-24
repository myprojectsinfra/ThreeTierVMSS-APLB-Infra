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