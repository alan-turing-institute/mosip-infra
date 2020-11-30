resource "azurerm_network_interface" "myterraformnic" {
  name                = "${var.hostname[0]}-NIC"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name
#console.sb
  ip_configuration {
    name                          = "${var.hostname[0]}-NicConfiguration"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "static"
    private_ip_address		  = "10.20.20.10"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
  }
}

resource "azurerm_network_interface" "myterraformnic1" {
  name                = "${var.hostname[1]}-NIC"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name
#mzmaster.sb
  ip_configuration {
    name                          = "${var.hostname[1]}-NicConfiguration1"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.20.20.99"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip1.id
  }
}

resource "azurerm_network_interface" "myterraformnic2" {
  name                = "${var.hostname[2]}-NIC"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name
#dmzmaster.sb
  ip_configuration {
    name                          = "${var.hostname[2]}-NicConfiguration2"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.20.20.199"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip2.id
  }
}

resource "azurerm_network_interface" "myterraformnic3" {
  name                = "${var.hostname[6]}-NIC"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name
#dmzworker0.sb
  ip_configuration {
    name                          = "${var.hostname[6]}-NicConfiguration3"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.20.20.200"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip3.id
  }
}

resource "azurerm_network_interface" "myterraformnic4" {
  name                = "${var.hostname[3]}-NIC"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name
#mzworker0.sb
  ip_configuration {
    name                          = "${var.hostname[3]}-NicConfiguration4"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.20.20.100"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip4.id
  }
}

resource "azurerm_network_interface" "myterraformnic5" {
  name                = "${var.hostname[4]}-NIC"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name
#mzworker1.sb
  ip_configuration {
    name                          = "${var.hostname[4]}-NicConfiguration5"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.20.20.101"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip5.id
  }
}
#mzworker2.sb
resource "azurerm_network_interface" "myterraformnic6" {
  name                = "${var.hostname[5]}-NIC"
  location            = azurerm_resource_group.myterraformgroup.location 
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  ip_configuration {
    name                          = "${var.hostname[5]}-NicConfiguration6"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.20.20.102"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip6.id
  }
}
