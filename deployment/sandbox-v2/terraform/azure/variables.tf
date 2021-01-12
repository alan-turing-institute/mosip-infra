#All the changes you can do it in this config file
variable "subscription_id" {
  default = "a8604fcd-7cc8-4801-a975-a4b777a179a4"
}
#if want to add new vm, add here as list and pass this parameter in to vm.tf config file.
variable "hostname" {
  type    = list(string)
  default = ["console.sb", "mzmaster.sb", "dmzmaster.sb", "mzworker0.sb", "mzworker1.sb", "mzworker2.sb", "dmzworker0.sb"]
}
#Change the domain name label according to our env need.
variable "domain_name_label" {
  default = "sandboxv2"
}

variable "admin_username" {
  default = "mosipuser"
}

variable "admin_password" {
  default = "roli7219@ati"
}

variable "vpc_cidr" { #azure vnet.tf
  default  = "10.20.0.0/16"
}

#This prefix is using as parameter in resources (vnet,subnet,nsg)
variable "prefix" {
#    type = "string"
    default = "test-machine"
}


variable "resource_group_name" {
  default = "mosip-sandbox-test"
}

variable "location" {
  default = "UK South"
}

variable "vm_size" {
  type    = list(string)
  default = ["Standard_F2s_v2", "Standard_F4s_v2", "Standard_D4_v3"]
}

variable "storage_account_type" {
  default = "Standard_LRS"
}


variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}
#change your tag according to your needs.
variable "tags" {
  default = "testing" 
    }
