#All the changes you can do it in this config file
variable "subscription_id" {
  default = "a8604fcd-7cc8-4801-a975-a4b777a179a4"
}

#Change the domain name label according to our env need.
variable "domain_name_label" {
  default = "mosipsb"
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
  default = "uksouth"
}

variable "vm_size" {
  type    = list(string)
  default = ["Standard_F4s_v2", "Standard_D4_v4"] #masters, workers
  #updated 14/01/21 to be closer to mosip sandbox readme
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

/* Recommended not to change names */
variable "console" {
  default =  {
    "name" : "console.sb",
    "private_ip": "10.20.20.10",
    "disk_size" : 128,
    "storage" : "StandardSSD_LRS",
    "size" : "Standard_F4s_V2"
  }
}

/* Recommended not to change names */
#uncomment vm names below to deploy full sandbox.
variable "kube_names" {
   type = map(string)

   default = {
     "mzmaster.sb": "10.20.20.99",
     "mzworker0.sb": "10.20.20.100",
     "mzworker1.sb": "10.20.20.101",
     "mzworker2.sb": "10.20.20.102",
   #  "mzworker3.sb": "10.20.20.103",
   #  "mzworker4.sb": "10.20.20.104",
   #  "mzworker5.sb": "10.20.20.105",
   #  "mzworker6.sb": "10.20.20.106",
   #  "mzworker7.sb": "10.20.20.107",
   #  "mzworker8.sb": "10.20.20.108",
     "dmzmaster.sb": "10.20.20.199",
     "dmzworker0.sb": "10.20.20.200"
   }
}


variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}
#change your tag according to your needs.
variable "tags" {
  default = "testing" 
    }
