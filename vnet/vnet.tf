resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnetname
  address_space       = var.vnetaddrspace
  location            = var.vnetlocation
  resource_group_name = var.vnetrgname
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnetname
  resource_group_name  = var.subnetrgname
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = var.addrprefix
}