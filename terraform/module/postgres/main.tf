terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

data "azurerm_client_config" "current" {}

data "azuread_user" "adlogin" {
  object_id = data.azurerm_client_config.current.object_id
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
  zone = "1"
  authentication {
    active_directory_auth_enabled = true
    tenant_id                     = "7b9420ef-1647-4623-b859-1b4969f5b198"

  }
  identity {
    type         = "SystemAssigned"
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "dbt" {
  for_each = local.dbt_ips

  server_id        = azurerm_postgresql_flexible_server.postgresql.id
  name             = "dbt-${replace(each.value, ".", "-")}"
  start_ip_address = each.value
  end_ip_address   = each.value
}

resource "azurerm_postgresql_flexible_server_database" "dbt" {
  name = "dbt"
  server_id = azurerm_postgresql_flexible_server.postgresql.id
  collation = "C"
  charset = "UTF8"
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "example" {
  server_name         = azurerm_postgresql_flexible_server.postgresql.name
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azuread_user.adlogin.object_id
  principal_name      = data.azuread_user.adlogin.display_name
  principal_type      = "User"
}

