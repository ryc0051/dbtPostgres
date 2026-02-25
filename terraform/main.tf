terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = lower(("ry-${var.location}-${var.environment}-rg"))
  location = var.location
}

resource "azurerm_storage_account" "st" {
  name                     = replace(lower(("ry-${var.location}-${var.environment}-st")), "-", "")
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "stc" {
  name                  = lower(("ry-${var.location}-${var.environment}-stc"))
  storage_account_id =   azurerm_storage_account.st.id
  container_access_type = "private"
}

module "postgressql" {
  source = "./module/postgres"

  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  environment                  = var.environment
  postgresql_admin_username    = var.admin_username
  postgresql_admin_password    = var.admin_password
  postgresql_storage_mb       = 32768
  postgresql_sku_name         = "B_Standard_B1ms"
  
}