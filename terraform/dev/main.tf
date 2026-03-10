terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

module "platform" {
  source = "../"

  location                     = "newzealandnorth"
  environment                  =  "dev"
  admin_username              = "postgres"
  admin_password = "lasso"
}