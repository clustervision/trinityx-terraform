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
# Virtual Network [Gateway Subnet] Addition
# This block will add gatwway subnet to the Virtual Nerwork.
# ------------------------------------------------------------------------------
resource "azurerm_subnet" "gateway_subnet" {
  name                  = var.azure_virtual_network_gateway_subnet.name
  resource_group_name   = var.azure_resource_group.name
  virtual_network_name  = var.azure_virtual_network
  address_prefixes      = [var.azure_virtual_network_gateway_subnet.address_prefix]
  
  depends_on = [var.subnet_id]

  # lifecycle {
  #   prevent_destroy = true
  # }

}

# ------------------------------------------------------------------------------
# Get Public IP Address
# This data block will get the public IP Address for the running machine and will
# use for the VPN Configuration.
# ------------------------------------------------------------------------------
data "http" "ipinfo" {
  url = "https://ipinfo.io/json"
}

# ------------------------------------------------------------------------------
# Local Network Gateway Definition
# This Local Network will be used by Controllers, nodes and LNG and VNG.
# ------------------------------------------------------------------------------
resource "azurerm_local_network_gateway" "lng" {
  name                = var.azure_local_network_gateway
  resource_group_name = var.azure_resource_group.name
  location            = var.azure_resource_group.location
  gateway_address     = var.azure_local_network_gateway_ip_address != "" ? var.azure_local_network_gateway_ip_address : jsondecode(data.http.ipinfo.response_body).ip
  address_space       = var.azure_local_network_gateway_address_space
  tags                = var.azure_local_network_gateway_tags

  # lifecycle {
  #   prevent_destroy = true
  # }

}

# ------------------------------------------------------------------------------
# Virtual Private Network Gateway Public IP Definition
# This block will be used to get an public IP addresss for VPN.
# ------------------------------------------------------------------------------
resource "azurerm_public_ip" "vng_ip" {
  name                = var.azure_vpn_public_ip
  resource_group_name = var.azure_resource_group.name
  location            = var.azure_resource_group.location
  allocation_method   = var.azure_vpn_public_ip_allocation_method
  sku                 = var.azure_vpn_public_ip_sku
  tags                = var.azure_vpn_public_ip_tags

  # lifecycle {
  #   prevent_destroy = true
  # }

}

# ------------------------------------------------------------------------------
# Virtual Network Gateway (VPN) Definition
# This block will create a virtual network gateway and will be used by LNG and VNG.
# ------------------------------------------------------------------------------
resource "azurerm_virtual_network_gateway" "vng" {
  name                                  = var.azure_virtual_network_gateway
  resource_group_name                   = var.azure_resource_group.name
  location                              = var.azure_resource_group.location
  type                                  = var.azure_virtual_network_gateway_type
  vpn_type                              = var.azure_virtual_network_gateway_vpn_type
  sku                                   = var.azure_virtual_network_gateway_sku
  generation                            = var.azure_virtual_network_gateway_generation
  bgp_route_translation_for_nat_enabled = var.azure_virtual_network_gateway_bgp_nat
  active_active                         = var.azure_virtual_network_gateway_active_active
  enable_bgp                            = var.azure_virtual_network_gateway_bgp
  tags                                  = var.azure_virtual_network_gateway_tags

  ip_configuration {
    name                          = var.azure_virtual_network_gateway_ip_config_name
    subnet_id                     = azurerm_subnet.gateway_subnet.id
    public_ip_address_id          = azurerm_public_ip.vng_ip.id
    private_ip_address_allocation = var.azure_virtual_network_gateway_private_allocation
  }

  # lifecycle {
  #   prevent_destroy = true
  # }

}

# ------------------------------------------------------------------------------
# Virtual Network Gateway Connection Definition
# This block will creates a connection between LNG and VNG.
# ------------------------------------------------------------------------------
resource "azurerm_virtual_network_gateway_connection" "connection" {
  name                       = var.azure_virtual_network_gateway_connection
  resource_group_name        = var.azure_resource_group.name
  location                   = var.azure_resource_group.location
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vng.id
  local_network_gateway_id   = azurerm_local_network_gateway.lng.id
  type                       = var.azure_virtual_network_gateway_connection_type
  connection_mode            = var.azure_virtual_network_gateway_connection_mode
  shared_key                 = var.azure_virtual_network_gateway_connection_shared_key
  tags                       = var.azure_virtual_network_gateway_connection_tags

  # lifecycle {
  #   prevent_destroy = true
  # }
  
}


