resource "azurerm_network_security_group" "console_nsg" {
  name                = "console_security_group"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "Port-22"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Port-443"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Port-30090"
    priority                    = 102
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "30090"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
  security_rule {
    name                       = "Port-80"
    priority                    = 103
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
  security_rule {
    name                       = "Port-30616"
    priority                    = 104
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "30616"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
  security_rule {
    name                       = "Port-53"
    priority                    = 105
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Udp"
    source_port_range           = "*"
    destination_port_range      = "53"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
  # The azure implementation allows all ports within the virtual private network.
  security_rule {
    name                       = "Port-cidr"
    priority                    = 106
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "10.20.0.0/16"
    destination_address_prefix  = "10.20.0.0/16"
  }
    security_rule {
    name                       = "allow-ping"
    priority                    = 107
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Icmp"
    source_port_range           = "8"
    destination_port_range      = "0"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }

  security_rule {
    name                       = "out"
    priority                    = 108
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "0"
    destination_port_range      = "0"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
  tags = {
    Name = "console"
  }
}

resource "azurerm_network_security_group" "kube_nsg" {
  name                = "kube_security_group"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  #for ssh
  security_rule {
    name                       = "Port-22"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # The azure implementation allows all ports within the virtual private network.
  security_rule {
    name                       = "Port-cidr"
    priority                    = 101
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "10.20.0.0/16"
    destination_address_prefix  = "10.20.0.0/16"
  }
    security_rule {
    name                       = "allow-ping"
    priority                    = 102
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Icmp"
    source_port_range           = "8"
    destination_port_range      = "0"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }

  security_rule {
    name                       = "out"
    priority                    = 103
    direction                   = "Outbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "0"
    destination_port_range      = "0"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
  tags = {
    Name = "kube"
  }
}









