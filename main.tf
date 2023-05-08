## Create a Resource Group for Storage
resource "azurerm_resource_group" "rg_storage" {
  location = "eastus"
  name     = "rg-atokongo-storage"
}

## Azure Storage Accounts requires a globally unique names
## https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview
## Create a File Storage Account 
resource "azurerm_storage_account" "storage" {
  name                     = "store4875"
  resource_group_name      = azurerm_resource_group.rg_storage.name
  location                 = azurerm_resource_group.rg_storage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  tags = {
    environment = "development-zone"
  }

}

resource "azurerm_storage_share" "FSShare" {
  name                 = "fsshare"
  storage_account_name = azurerm_storage_account.storage.name
  quota                = 20
  access_tier          = "Hot"
  depends_on           = [azurerm_storage_account.storage]
  enabled_protocol     = "SMB"
}