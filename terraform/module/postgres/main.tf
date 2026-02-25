terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

resource "azurerm_postgresql_flexible_server" "postgresql" {
  name                         = lower(("ry-${var.location}-${var.environment}-postgresql"))
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "18"
  administrator_login          = var.postgresql_admin_username
  administrator_password       = var.postgresql_admin_password
  storage_mb                   = var.postgresql_storage_mb
  sku_name                     = var.postgresql_sku_name
  authentication {
    active_directory_auth_enabled = true
    tenant_id                     = "7b9420ef-1647-4623-b859-1b4969f5b198"

  }
  identity {
    type         = "SystemAssigned"
  }
}