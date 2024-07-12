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
# File: azure/modules/network/outputs.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Terraform Network Module Outputs file, will be output some of
#              important information, will be used further.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This output file outputs the network related information.
# ------------------------------------------------------------------------------

output "vnet_gateway_id" {
  value         = azurerm_subnet.gateway_subnet.id
  description   = "The ID of the Gateway Subnet created for the Virtual Network in VPN Module"
}

output "lng_id" {
  value         = azurerm_local_network_gateway.lng.id
  description   = "The ID of Local Network Gateway created in VPN Module"
}

output "vng_ip_id" {
  value         = azurerm_public_ip.vng_ip.id
  description   = "The ID of the Virtual Network Gateway Public IP Address created in the VPN Module"
}

output "vng_ip" {
  value         = azurerm_public_ip.vng_ip.ip_address
  description   = "The Public IP Address for Virtual Network Gateway created in the VPN Module"
}

output "vng_id" {
  value         = azurerm_virtual_network_gateway.vng.id
  description   = "The ID of the Virtual Network Gateway created in the VPN Module"
}

output "connection_id" {
  value         = azurerm_virtual_network_gateway_connection.connection.id
  description   = "The ID of the Connection created in the VPN Module between Local Network Gateway and Virtual Network Gateway."
}

output "ipinfo" {
  value       = jsondecode(data.http.ipinfo.response_body).ip
  description = "The Public IP Address for the installation Machine."
}
