terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=2.52.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "tchow-state"
    storage_account_name = "tchowtfstate"
    container_name = "tchowtstate"
    key = "terraform.state"
  }
}

# Configure the Microsoft Azure Provider 
provider "azurerm" {
  features {}
}

# Create a resource group 
resource "azurerm_resource_group" "examplerg" {
    name = "example_rg"
    location = var.primary_location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "examplevnet" {
  name                = "example-network"
  location            = azurerm_resource_group.examplerg.location
  resource_group_name = azurerm_resource_group.examplerg.name
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet within the vnet 
resource "azurerm_subnet" "examplesubnet" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.examplerg.name
  virtual_network_name = azurerm_virtual_network.examplevnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
