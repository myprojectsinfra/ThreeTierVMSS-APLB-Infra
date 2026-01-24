variable "rg_config" {
  description = "The configuration values of the resource group"
  type = map(object({
    resource_group_name     = string
    resource_group_location = string
    managed_by              = optional(string)
  }))
}

variable "tags" {}