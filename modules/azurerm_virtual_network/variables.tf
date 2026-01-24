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