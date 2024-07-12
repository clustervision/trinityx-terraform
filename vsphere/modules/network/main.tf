# ------------------------------------------------------------------------------
# This code is part of the TrinityX software suite
# Copyright (C) 2023  ClusterVision Solutions b.v.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# File: azure/modules/network/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Terraform module for creating network resources in Azure,
#              including virtual networks and network security groups.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This module expects certain variables to be passed in for proper configuration.
# - Ensure that the parent module provides the required variables.
# - The module includes best practices for network security and scalability.
# - All variables will be passed by the Root(parent) module.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Network Security Group Definition
# This security group is a default security group which will be used by the Controller & nodes.
# ------------------------------------------------------------------------------
resource "azurerm_network_security_group" "nsg" {
  name                = var.azure_nsg
  resource_group_name = var.azure_resource_group.name
  location            = var.azure_resource_group.location
  tags                = var.azure_nsg_tags

  # lifecycle {
  #   prevent_destroy = true
  # }

}

# ------------------------------------------------------------------------------
# Network Security Group Rules
# This will add the rules for Network security group which is created above.
# ------------------------------------------------------------------------------
resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = { for rule in var.azure_nsg_security_rules : rule.name => rule }

  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  network_security_group_name = azurerm_network_security_group.nsg.name
  resource_group_name         = azurerm_network_security_group.nsg.resource_group_name
  description                 = each.value.description

  # lifecycle {
  #   prevent_destroy = true
  # }

}

# ------------------------------------------------------------------------------
# Virtual Network Definition
# This Virtual Network will be used by Controllers, nodes and LNG and VNG.
# ------------------------------------------------------------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = var.azure_virtual_network
  resource_group_name = var.azure_resource_group.name
  location            = var.azure_resource_group.location
  address_space       = var.azure_virtual_network_address_space
  tags                = var.azure_virtual_network_tags
  encryption {
    enforcement = var.azure_virtual_network_encryption
  }

  # lifecycle {
  #   prevent_destroy = true
  # }

}

# ------------------------------------------------------------------------------
# Virtual Network Subnets Addition
# This block will add Subnets to the Virtual Nerwork.
# ------------------------------------------------------------------------------
resource "azurerm_subnet" "subnet" {
  count = length(var.azure_virtual_network_subnets)
  name                 = var.azure_virtual_network_subnets[count.index].name
  resource_group_name = var.azure_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = [var.azure_virtual_network_subnets[count.index].address_prefix]

  # lifecycle {
  #   prevent_destroy = true
  # }

}

# ------------------------------------------------------------------------------
# Virtual Network Subnets Network Security Group Association
# This block will Associate the Network Security Group to the Virtual Network Subnets.
# ------------------------------------------------------------------------------
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  count = length(var.azure_virtual_network_subnets)
  depends_on = [azurerm_subnet.subnet]
  subnet_id                 = azurerm_subnet.subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id

  # lifecycle {
  #   prevent_destroy = true
  # }
  
}




