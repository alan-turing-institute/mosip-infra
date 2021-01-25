# Module sets up resources for console vm, public ip, and nic.

locals {
  host = format("%s.%s.cloudapp.azure.com", var.domain_name_label, var.location) 
  hostname = lookup(var.console, "name")
}

resource "azurerm_linux_virtual_machine" "console" {
  name                = local.hostname
  location            = azurerm_resource_group.resource_group.location 
  resource_group_name = azurerm_resource_group.resource_group.name

  network_interface_ids = [azurerm_network_interface.console_nic.id]

  size           = lookup(var.console, "size")
  computer_name  = local.hostname
  admin_username = var.admin_username
  admin_password = var.admin_password
  disable_password_authentication = false


  provisioner "file" {
    source      = "./console.sh"
    destination = "/tmp/console.sh"

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = local.host
    }
  } 
  
   provisioner "remote-exec" {
    inline = [
       "chmod +x /tmp/console.sh",
       "/tmp/console.sh args",
   ]
    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = local.host
    }
  }
 
   os_disk {
    name                 = "${local.hostname}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = lookup(var.console, "storage")
    disk_size_gb = lookup(var.console, "disk_size") #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#disk_size_gb
   }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.7"
    version   = "latest"
  }
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }
 
  tags = {
    environment = var.tags
  }
}

resource "azurerm_public_ip" "console_ip" {
  name                = "${local.hostname}-PublicIP"
  location            = azurerm_resource_group.resource_group.location 
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
  domain_name_label   = var.domain_name_label
}

resource "azurerm_network_interface" "console_nic" {
  name                = "${local.hostname}-NIC"
  location            = azurerm_resource_group.resource_group.location 
  resource_group_name = azurerm_resource_group.resource_group.name
  ip_configuration {
    name                          = "${local.hostname}-NicConfiguration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "static"
    private_ip_address		  = lookup(var.console, "private_ip")
    public_ip_address_id          = azurerm_public_ip.console_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "console_nsga" {
    network_interface_id      = azurerm_network_interface.console_nic.id
    network_security_group_id = azurerm_network_security_group.console_nsg.id
}