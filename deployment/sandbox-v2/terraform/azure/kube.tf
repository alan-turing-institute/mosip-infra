# Sets up vms, public ips, nics, and nsg assocs for both kubenetes clusters,

resource "azurerm_linux_virtual_machine" "kube" {
  for_each = var.kube_names
  name                = each.key
  location            = azurerm_resource_group.resource_group.location 
  resource_group_name = azurerm_resource_group.resource_group.name

  network_interface_ids = [azurerm_network_interface.kube_nics[each.key].id]

  #masters have slightly larger vms
  size           = each.key == "mzmaster.sb" || each.key == "dmzmaster.sb" ? var.vm_size[0] : var.vm_size[1]
  computer_name  = each.key
  admin_username = var.admin_username
  admin_password = var.admin_password
  disable_password_authentication = false
  
  os_disk {
    name                 = "${each.key}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
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
    Name = each.key
    environment = var.tags
  }
  
}

#---

resource "azurerm_public_ip" "kube_ips" {
  for_each            = var.kube_names
  name                = "${each.key}-PublicIP"
  location            = azurerm_resource_group.resource_group.location 
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
}


resource "azurerm_network_interface" "kube_nics" {
  for_each            = var.kube_names
  name                = "${each.key}-NIC"
  location            = azurerm_resource_group.resource_group.location 
  resource_group_name = azurerm_resource_group.resource_group.name
#mzmaster.sb
  ip_configuration {
    name                          = "${each.key}-NicConfiguration1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = each.value
    public_ip_address_id          = azurerm_public_ip.kube_ips[each.key].id
  }
}


resource "azurerm_network_interface_security_group_association" "kube_nsga" {
    for_each  = var.kube_names
    network_interface_id      = azurerm_network_interface.kube_nics[each.key].id
    network_security_group_id = azurerm_network_security_group.kube_nsg.id
}