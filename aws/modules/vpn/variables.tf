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
# File: azure/modules/vpn/variables.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Variables file for the main Terraform configuration for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - Define all the input variables required by the vpn module.
# - Update the default values as needed to match the target environment.
# - Ensure sensitive variables are handled securely.
# ------------------------------------------------------------------------------

variable "azure_virtual_network" {
  description = "The name of the Virtual Network"
  type        = string
  default     = "TrinityX-Vnet"
}

variable "azure_vpn" {
  description = "The Azure VPN."
  type        = bool
  default     = false
}

variable "azure_resource_group" {
  description = "The name of the Network Security Group"
  type        = object({ 
    name      = string
    location  = string
  })
  default     = {
    name      = "TrinityX"
    location  = "Germany West Central"
  }
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to place the VM in"
}

variable "azure_virtual_network_gateway_subnet" {
  description = "The name of the Network Security Group"
  type        = object({
    name                  = string
    address_prefix        = string
    security_group        = string
  })
  default     = {"name": "GatewaySubnet", "address_prefix": "10.141.255.0/27", "security_group": null}
}

variable "azure_local_network_gateway" {
  description = "The name of the Local Network Gateway"
  type        = string
  default     = "TrinityXLNG"
}

variable "azure_local_network_gateway_tags" {
  description = "The Tags for the Local Network Gateway"
  type    = map(string)
  default = {
    HPC        = "TrinityX",
    module     = "network",
    sub-module = "local network gateway"
  }
}

variable "azure_local_network_gateway_ip_address" {
  description = "The IP Address for the Local Network Gateway"
  type        = string
  default     = ""
}

variable "azure_local_network_gateway_address_space" {
  description = "The Address Space for the Local Network Gateway"
  type        = list
  default     = ["192.168.20.0/24"]
}

variable "azure_local_network_gateway_bgp_asn" {
  description = "The Local Network Gateway BGP ASN"
  type        = number
  default     = 0
}

variable "azure_local_network_gateway_bgp_peering_address" {
  description = "The Local Network Gateway BGP Peering Address."
  type        = string
  default     = ""
}

variable "azure_local_network_gateway_bgp_peer_weight" {
  description = "The Local Network Gateway BGP Peering Weight."
  type        = number
  default     = 0
}

variable "azure_vpn_public_ip" {
  description = "The Public IP Address for the VPN"
  type        = string
  default     = "TrinityXVNGIP"
}

variable "azure_vpn_public_ip_tags" {
  description = "The Tags for the Public IP Address for the VPN"
  type    = map(string)
  default = {
    HPC        = "TrinityX",
    module     = "network",
    sub-module = "virtual network gateway"
  }
}

variable "azure_vpn_public_ip_allocation_method" {
  description = "The IP Address Allocation Method for the VPN Public IP"
  type        = string
  default     = "Static"
}

variable "azure_vpn_public_ip_sku" {
  description = "The SKU for VPN Public IP"
  type        = string
  default     = "Standard"
}

variable "azure_vpn_public_ip_zones" {
  description = "The Zones for the VPN Public IP"
  type        = list
  default     = ["1", "2", "3"]
}

variable "azure_virtual_network_gateway" {
  description = "The Name of the Virtual Network Gateway"
  type        = string
  default     = "TrinityXVNG"
}

variable "azure_virtual_network_gateway_tags" {
  description = "The Tags for the Virtual Network Gateway"
  type    = map(string)
  default = {
    HPC        = "TrinityX",
    module     = "network",
    sub-module = "virtual network gateway"
  }
}

variable "azure_virtual_network_gateway_type" {
  description = "The gateway type for the Virtual Network Gateway"
  type        = string
  default     = "Vpn"
}

variable "azure_virtual_network_gateway_vpn_type" {
  description = "The VPN type for the Virtual Network Gateway"
  type        = string
  default     = "RouteBased"
}

variable "azure_virtual_network_gateway_sku" {
  description = "The gateway SKU for the Virtual Network Gateway"
  type        = string
  default     = "VpnGw2"
}

variable "azure_virtual_network_gateway_generation" {
  description = "The Generation for the Virtual Network Gateway"
  type        = string
  default     = "Generation2"
}

variable "azure_virtual_network_gateway_bgp_nat" {
  description = "The gateway BGP NAT routing for the Virtual Network Gateway"
  type        = bool
  default     = false
}

variable "azure_virtual_network_gateway_active_active" {
  description = "The Active-Active mode for the Virtual Network Gateway"
  type        = bool
  default     = false
}

variable "azure_virtual_network_gateway_bgp" {
  description = "The BGP Enabled for the Virtual Network Gateway"
  type        = bool
  default     = false
}

variable "azure_virtual_network_gateway_address_space" {
  description = "The Gateway Address Space for the Virtual Network Gateway"
  type        = list
  default     = ["192.168.20.0/24"]
}

variable "azure_virtual_network_gateway_ip_config_name" {
  description = "The IP Configuration name for the Virtual Network Gateway"
  type        = string
  default     = "GatewayIpConfig"
}

variable "azure_virtual_network_gateway_private_allocation" {
  description = "The Private IP Allocation for the Virtual Network Gateway"
  type        = string
  default     = "Dynamic"
}

variable "azure_virtual_network_gateway_connection" {
  description = "The Connection name for the Virtual Network Gateway"
  type        = string
  default     = "azureconn"
}

variable "azure_virtual_network_gateway_connection_tags" {
  description = "The Tags for the Virtual Network Gateway"
  type    = map(string)
  default = {
    HPC        = "TrinityX",
    module     = "network",
    sub-module = "local-vertual network gateway connection"
  }
}

variable "azure_virtual_network_gateway_connection_type" {
  description = "The Connection type for the Virtual Network Gateway"
  type        = string
  default     = "IPsec"
}

variable "azure_virtual_network_gateway_connection_mode" {
  description = "The Connection mode for the Virtual Network Gateway"
  type        = string
  default     = "Default"
}

variable "azure_virtual_network_gateway_connection_shared_key" {
  description = "The Shared Key for the connection for Virtual Network Gateway"
  type        = string
  default     = ""
}
