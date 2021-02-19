variable "rgname" {
  type = string
  default = "terraform1-rg"
}

variable "rglocation" {
  type = string
  default = "australiaeast"
}

variable "storagename" {
  type = string
  default = "terredstorage123"
}

variable "storagetier" {
  type = string
  default = "Standard"
}

variable "replicationtype" {
  type = string
  default = "LRS"
}

variable "vnetname" {
  type = string
  default = "example-vnet"
}

variable "vnetaddrspace" {
  type = list
  default = ["10.10.0.0/16"]
}

variable "subnetname" {
  type = string
  default = "frontend"
}

variable "addrprefix" {
  type = list
  default = ["10.10.1.0/24"]
}

variable "vm1nicname" {
  type = string
  default = "vm1-nic"
}

variable "vm1name" {
  type = string
  default = "vm1"
}

variable "vmsize" {
  type = string
  default = "Standard_D2_v3"
}

variable "vmadminuser" {
  type = string
}

variable "vmadminpass" {
  type = string
}