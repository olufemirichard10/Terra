terraform {
  backend "azurerm" {
    resource_group_name  = "Terra-rg-test"
    storage_account_name = "terrastorage22"
    container_name       = "terracont22"
    key                  = "terraform.tfstate"
  }
}