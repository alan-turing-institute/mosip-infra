resource "azurerm_network_interface_security_group_association" "console" {
    network_interface_id      = azurerm_network_interface.myterraformnic.id
    network_security_group_id = azurerm_network_security_group.console.id
}

resource "azurerm_network_interface_security_group_association" "mzmaster" {
    network_interface_id      = azurerm_network_interface.myterraformnic1.id
    network_security_group_id = azurerm_network_security_group.console.id
}

resource "azurerm_network_interface_security_group_association" "dmzmaster" {
    network_interface_id      = azurerm_network_interface.myterraformnic2.id
    network_security_group_id = azurerm_network_security_group.console.id
}

resource "azurerm_network_interface_security_group_association" "mzworker0" {
    network_interface_id      = azurerm_network_interface.myterraformnic3.id
    network_security_group_id = azurerm_network_security_group.console.id
}

resource "azurerm_network_interface_security_group_association" "mzworker1" {
    network_interface_id      = azurerm_network_interface.myterraformnic4.id
    network_security_group_id = azurerm_network_security_group.console.id
}

resource "azurerm_network_interface_security_group_association" "mzworker2" {
    network_interface_id      = azurerm_network_interface.myterraformnic5.id
    network_security_group_id = azurerm_network_security_group.console.id
}

resource "azurerm_network_interface_security_group_association" "dmzworker0" {
    network_interface_id      = azurerm_network_interface.myterraformnic6.id
    network_security_group_id = azurerm_network_security_group.console.id
}
