provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

variables {
  resource_group_name = "Sandbox-RD"
  location            = "japanwest"

  vnet_name                   = "vnet-test"
  subnet_name                 = "subnet-test"
}
run "test" {
  command = plan

  assert {
    condition     = azurerm_virtual_network.vnet.name == var.vnet_name
    error_message = "virtual network name does not match var.vnet_name"
  }

  assert {
    condition     = azurerm_subnet.subnet.name == var.subnet_name
    error_message = "virtual network name does not match var.subnet_name"
  }
}
