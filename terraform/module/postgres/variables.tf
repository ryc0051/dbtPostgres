variable "resource_group_name" {
    description = "The name of the resource group to create."
    type        = string
}
variable "location" {
    description = "The Azure region to deploy resources in."
    type        = string
}

variable "environment" {
    description = "The environment for the resources (e.g., dev, prod)."
    type        = string
  
}
variable "postgresql_admin_username" {
    description = "The admin username for the PostgreSQL server."
    type        = string
}
variable "postgresql_admin_password" {
    description = "The admin password for the PostgreSQL server."
    type        = string
}
variable "postgresql_storage_mb" {
    description = "The storage size in MB for the PostgreSQL server."
    type        = number
}
variable "postgresql_sku_name" {
    description = "The SKU name for the PostgreSQL server."
    type        = string
}