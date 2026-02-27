variable "location" {
  description = "The Azure region to deploy resources in."
  type        = string
  default     = "eastus"
}

variable "environment" {
    description = "The environment for the resources (e.g., dev, prod)."
    type        = string
    default     = "dev"
}

variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
  default     = "my-terraform-rg"
}
  
variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_DS1_v2"
}
variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "The admin password for the virtual machine."
  type        = string
}