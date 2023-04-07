# Use the Azure Resource Manager provider
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

# Create resource group

resource "azurerm_resource_group" "rg" {
  name     = "femi-terra-rg"
  location = "East US"
   tags = {
    owner       = "femi"
    orgnization = "peace4eva"
  }
}

## Create an Azure SQL Server
resource "azurerm_sql_server" "server" {
  name                         = "sqlriamqacus001femi45" # NOTE: needs to be globally unique
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqlriamqacus001-saadmin"
  administrator_login_password = "Cy045i!@34ml2"
}

resource "azurerm_sql_active_directory_administrator" "Activedirectory" {
  server_name         = azurerm_sql_server.server.name
  resource_group_name = azurerm_resource_group.rg.name
  login               = "peace4eva74@gmail.com"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
}


# Create an Azure SQL Elastic Pool
resource "azurerm_sql_elasticpool" "pool" {
  name                = "sqlepriamqacus001femi45"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.server.name
  edition             = "Basic"
  dtu                 = 50
  db_dtu_min          = 0
  db_dtu_max          = 5
  pool_size           = 5000
}

# Create an Azure SQL Databases
resource "azurerm_sql_database" "database" {
  name                             = "sqldbriamqacus001femi45"
  resource_group_name              = azurerm_resource_group.rg.name
  server_name                      = azurerm_sql_server.server.name
  location                         = azurerm_resource_group.rg.location
  edition                          = "Basic"
  collation                        = "SQL_Latin1_General_CP1_CI_AS"
  max_size_bytes                   = "1073741824"
  requested_service_objective_name = "Basic"
}

resource "azurerm_sql_database" "database2" {
  name                             = "sqldbriamqacus002femi45"
  resource_group_name              = azurerm_resource_group.rg.name
  server_name                      = azurerm_sql_server.server.name
  location                         = azurerm_resource_group.rg.location
  edition                          = "Basic"
  collation                        = "SQL_Latin1_General_CP1_CI_AS"
  max_size_bytes                   = "1073741824"
  requested_service_objective_name = "Basic"
}