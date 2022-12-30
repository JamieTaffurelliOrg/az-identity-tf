terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.30"
    }
    azurerm = {
      configuration_aliases = [azurerm.logs]
      source                = "hashicorp/azurerm"
      version               = "~> 3.20"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }

  }
  required_version = "~> 1.3.0"
}
