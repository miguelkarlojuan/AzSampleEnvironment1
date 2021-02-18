terraform {
  required_providers {
    azurerm     = {
      source    = "hashicorp/azurerm"
      version   = ">=2.47.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "mod_resourcegroup" {
  source        = "./resourcegroup"
  rgname        = "resourcegroup1"
  rglocation    = "australiaeast"
}

module "mod_storageaccount1" {
  source            = "./storageaccount"
  storagename       = "redcloudterraform"
  rgname            = module.mod_resourcegroup.out_resourcegroup1name
  rglocation        = module.mod_resourcegroup.out_resourcegroup1location
  storagetier       = "Standard"
  replicationtype   = "LRS"
}

module "mod_vnet1" {
  source        = "./vnet"
  vnetname      = "sample-vnet"
  vnetaddrspace = ["10.10.0.0/16"]
  vnetlocation  = module.mod_resourcegroup.out_resourcegroup1location
  vnetrgname    = module.mod_resourcegroup.out_resourcegroup1name
  subnetname    = "subnet1"
  subnetrgname  = module.mod_resourcegroup.out_resourcegroup1name
  addrprefix    = ["10.10.1.0/24"]
}

module "mod_vm1" {
  source = "./vm"
  vmnicname = "vm1-nic"
  vmniclocation = module.mod_resourcegroup.out_resourcegroup1location
  vmnicrg = module.mod_resourcegroup.out_resourcegroup1name
  subnetid = module.mod_vnet1.out_subnet1.id
  vmname = "vm1"
  vmrg = module.mod_resourcegroup.out_resourcegroup1name
  vmlocation = module.mod_resourcegroup.out_resourcegroup1location
  vmsize = "Standard_D2_v3"
  vmadminuser = "vm1admin"
  vmadminpass = "Welcome012345"
}