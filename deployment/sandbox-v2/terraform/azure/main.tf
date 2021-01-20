provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {
    
  }
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-Subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.20.20.0/24"]
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.prefix}-Vnet"
  address_space       = ["10.20.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

