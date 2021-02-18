resource "azurerm_storage_account" "storageaccount1" {
  name                     = var.storagename
  resource_group_name      = var.rgname
  location                 = var.rglocation
  account_tier             = var.storagetier
  account_replication_type = var.replicationtype
}