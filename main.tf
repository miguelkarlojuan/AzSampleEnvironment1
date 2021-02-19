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
  rgname        = var.rgname
  rglocation    = var.rglocation
}

module "mod_storageaccount1" {
  source            = "./storageaccount"
  storagename       = var.storagename
  rgname            = module.mod_resourcegroup.out_resourcegroup1name
  rglocation        = module.mod_resourcegroup.out_resourcegroup1location
  storagetier       = var.storagetier
  replicationtype   = var.replicationtype
}

module "mod_vnet1" {
  source        = "./vnet"
  vnetname      = var.vnetname
  vnetaddrspace = var.vnetaddrspace
  vnetlocation  = module.mod_resourcegroup.out_resourcegroup1location
  vnetrgname    = module.mod_resourcegroup.out_resourcegroup1name
  subnetname    = "subnet1"
  subnetrgname  = module.mod_resourcegroup.out_resourcegroup1name
  addrprefix    = var.addrprefix
}

module "mod_vm1" {
  source = "./vm"
  vmnicname = var.vm1nicname
  vmniclocation = module.mod_resourcegroup.out_resourcegroup1location
  vmnicrg = module.mod_resourcegroup.out_resourcegroup1name
  subnetid = module.mod_vnet1.out_subnet1.id
  vmname = var.vm1name
  vmrg = module.mod_resourcegroup.out_resourcegroup1name
  vmlocation = module.mod_resourcegroup.out_resourcegroup1location
  vmsize = var.vmsize
  vmadminuser = var.vmadminuser
  vmadminpass = var.vmadminpass
}