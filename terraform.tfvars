resource "azurerm_resource_group" "rgdelta" {
  for_each = var.devrg
  name     = each.value.name
  location = each.value.location
}

resource "azurerm_virtual_network" "virtualnetwork" {
  for_each            = var.devvnet
  name                = each.value.name
  resource_group_name = azurerm_resource_group.rgdelta[each.value.rg_key].name
  location            = azurerm_resource_group.rgdelta[each.value.rg_key].location
  address_space       = each.value.address_space

}

resource "azurerm_subnet" "subnet" {
  for_each             = var.devsubnet
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.rgdelta[each.value.rg_key].name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}
