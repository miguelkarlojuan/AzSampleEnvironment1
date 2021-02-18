resource "azurerm_network_interface" "nic" {
  name                = var.vmnicname
  location            = var.vmniclocation
  resource_group_name = var.vmnicrg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vmname
  resource_group_name = var.vmrg
  location            = var.vmlocation
  size                = var.vmsize
  admin_username      = var.vmadminuser
  admin_password      = var.vmadminpass
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}