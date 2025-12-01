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
  subscription_id = "4164e4f7-8365-48f6-bb5a-3d896da4934b"
  resource_provider_registrations = "none"
}
