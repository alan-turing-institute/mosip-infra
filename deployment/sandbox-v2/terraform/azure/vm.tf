resource "azurerm_linux_virtual_machine" "console" {
  name                = var.hostname[0]
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  network_interface_ids = [azurerm_network_interface.myterraformnic.id]

  size           = var.vm_size[0]
  computer_name  = var.hostname[0]
  admin_username = "${var.admin_username}"
  admin_password = "${var.admin_password}"
  disable_password_authentication = false
  

  provisioner "file" {
    source      = "./console_auth.sh"
    destination = "/tmp/console_auth.sh"

    connection {
      type     = "ssh"
      user     = "${var.admin_username}"
      password = "${var.admin_password}"
      host     = "${var.domain_name_label}.uksouth.cloudapp.azure.com"
    }
  } 
  
   provisioner "remote-exec" {
    inline = [
       "chmod +x /tmp/console_auth.sh",
       "sudo /tmp/console_auth.sh console.sb",
   ]
    connection {
      type     = "ssh"
      user     = "${var.admin_username}"
      password = "${var.admin_password}"
      host     = "${var.domain_name_label}.uksouth.cloudapp.azure.com"
    }
  }

# changed 14/01/21 by CDM. This all gets called in ./preinstall.sh
#    provisioner "file" {
#    source      = "./console.sh"
#    destination = "/tmp/console.sh"

 #   connection {
 #     type     = "ssh"
 #     user     = "${var.admin_username}"
 #     password = "${var.admin_password}"
 #     host     = "${var.domain_name_label}.uksouth.cloudapp.azure.com"
 #   }
 # } 
  
#   provisioner "remote-exec" {
#    inline = [
#       "chmod +x /tmp/console.sh",
#       "/tmp/console.sh args",
#   ]
#    connection {
#      type     = "ssh"
#      user     = "${var.admin_username}"
#      password = "${var.admin_password}"
#      host     = "${var.domain_name_label}.uksouth.cloudapp.azure.com"
#    }
#  }
 
   os_disk {
    name                 = "${var.hostname[0]}-OsDisk"
    caching              = "ReadWrite"
    #storage_account_type = "${var.storage_account_type}"
    #changes 14/01/21
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb = 128 #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#disk_size_gb
   }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.7"
    version   = "latest"
  }
  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = file("${var.ssh_public_key}")
  }
 
  tags = {
    environment = "${var.tags}"
  }


}

#---

resource "azurerm_linux_virtual_machine" "myterraformvm1" {
  name                = "${var.hostname[1]}"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  network_interface_ids = [azurerm_network_interface.myterraformnic1.id]

  size           = "${var.vm_size[1]}"
  computer_name  = "${var.hostname[1]}"
  admin_username = "${var.admin_username}"
  admin_password = "${var.admin_password}"
  disable_password_authentication = false
  
  os_disk {
    name                 = "${var.hostname[1]}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "${var.storage_account_type}"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.7"
    version   = "latest"
  }
  
   admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = file("${var.ssh_public_key}")
  }
 

  tags = {
    environment = "${var.tags}"
  }
}

#---

resource "azurerm_linux_virtual_machine" "myterraformvm2" {
  name                = "${var.hostname[2]}"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  network_interface_ids = [azurerm_network_interface.myterraformnic2.id]

  size           = "${var.vm_size[1]}"
  computer_name  = "${var.hostname[2]}"
  admin_username = "${var.admin_username}"
  admin_password = "${var.admin_password}"
  disable_password_authentication = false
  
  os_disk {
    name                 = "${var.hostname[2]}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "${var.storage_account_type}"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.7"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = file("${var.ssh_public_key}")
  }
 


  tags = {
    environment = "${var.tags}"
  }
}

#---
resource "azurerm_linux_virtual_machine" "myterraformvm3" {
  name                = "${var.hostname[6]}"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  network_interface_ids = [azurerm_network_interface.myterraformnic3.id]

  size           = "${var.vm_size[2]}"
  computer_name  = "${var.hostname[6]}"
  admin_username = "${var.admin_username}"
  admin_password = "${var.admin_password}"
  disable_password_authentication = false


  os_disk {
    name                 = "${var.hostname[6]}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "${var.storage_account_type}"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.7"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = file("${var.ssh_public_key}")
  }
 


  tags = {
    environment = "${var.tags}"
  }
}

#---

resource "azurerm_linux_virtual_machine" "myterraformvm4" {
  name                = "${var.hostname[3]}"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  network_interface_ids = [azurerm_network_interface.myterraformnic4.id]

  size           = "${var.vm_size[2]}"
  computer_name  = "${var.hostname[3]}"
  admin_username = "${var.admin_username}"
  admin_password = "${var.admin_password}"
  disable_password_authentication = false

  os_disk {
    name                 = "${var.hostname[3]}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "${var.storage_account_type}"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.7"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = file("${var.ssh_public_key}")
  }
 

  tags = {
    environment = "${var.tags}"
  }
}

#------

resource "azurerm_linux_virtual_machine" "myterraformvm5" {
  name                = "${var.hostname[4]}"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  network_interface_ids = [azurerm_network_interface.myterraformnic5.id]

  size           = "${var.vm_size[2]}"
  computer_name  = "${var.hostname[4]}"
  admin_username = "${var.admin_username}"
  admin_password = "${var.admin_password}"
  disable_password_authentication = false
  
  os_disk {
    name                 = "${var.hostname[4]}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "${var.storage_account_type}"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.7"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = file("${var.ssh_public_key}")
  }
 
tags = {
    environment = "${var.tags}"
  }
}

#---

resource "azurerm_linux_virtual_machine" "myterraformvm6" {
  name                = "${var.hostname[5]}"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  network_interface_ids = [azurerm_network_interface.myterraformnic6.id]

  size           = "${var.vm_size[2]}"
  computer_name  = "${var.hostname[5]}"
  admin_username = "${var.admin_username}"
  admin_password = "${var.admin_password}"
  disable_password_authentication = false

  os_disk {
    name                 = "${var.hostname[5]}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "${var.storage_account_type}"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.7"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = file("${var.ssh_public_key}")
  }
 


  tags = {
    environment = "${var.tags}"
  }
}

