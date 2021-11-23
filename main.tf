provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you are using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}


resource "azurerm_resource_group" "example" {
  name     = "${var.team_name}-datalake"
  location = var.region
}

resource "azurerm_storage_account" "example" {
  name                     = "${var.team_name}-storageacc"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "example" {
  name               = "example"
  storage_account_id = azurerm_storage_account.example.id

  properties = {
    var.property = base64encode(var.property)
  }
}