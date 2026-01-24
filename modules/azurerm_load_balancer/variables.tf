#Load balancer
variable "loadbalancer_config" {
  description = "This contains the configuration for internal Load balancer"
  type = map(object(
    {
      lb_name              = string
      lb_location          = string
      resource_group_name  = string
      front_ip_config_name = string
      subnet_name          = string
      virtual_network_name = string
      lb_backendpool_name  = string
      lb_probe_name        = string
    }
  ))
}