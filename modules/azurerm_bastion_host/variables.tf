variable "bastion_config" {
  description = "This contains the configuration values for bastion"
  type = map(object({
    bastion_name         = string
    bastion_location     = string
    bastion_ip_name      = string
    resource_group_name  = string
    bastion_pip          = string
    subnet_name          = string
    virtual_network_name = string
  }))

}