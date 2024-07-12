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
# File: azure/modules/network/variables.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Variables file for the main Terraform configuration for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - Define all the input variables required by the network module.
# - Update the default values as needed to match the target environment.
# - Ensure sensitive variables are handled securely.
# ------------------------------------------------------------------------------

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

variable "azure_nsg" {
  description = "The name of the Network Security Group"
  type        = string
  default     = "TrinityX-NSG"
  validation {
    condition     = length(var.azure_nsg) > 1 && length(var.azure_nsg) < 65
    error_message = "The Azure Network Security Group Name must be between 2 and 64 characters."
  }
}

variable "azure_nsg_tags" {
  description = "The Tags for the Network Security Group"
  type        = map(string)
  default     = {
    HPC         = "TrinityX",
    module      = "network",
    sub-module  = "security group"
  }
}

variable "azure_nsg_security_rules" {
  description = "List of ports to allow"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string
  }))
  default = [
    {
      name                       = "Allow-SSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 22 for SSH."
    },
    {
      name                       = "Allow-HTTP"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 80 for Nginx."
    },
    {
      name                       = "Allow-HTTPS"
      priority                   = 300
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 443 for SSL."
    },
    {
      name                       = "Allow-HTTP-Alt"
      priority                   = 400
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 8080 for OOD."
    },
    {
      name                       = "Allow-Custom-1"
      priority                   = 500
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "7050"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 7050 for Lunqa2 Daemon."
    },
    {
      name                       = "Allow-Custom-2"
      priority                   = 600
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "7055"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 7055 for Nginx."
    },
    {
      name                       = "Allow-Custom-3"
      priority                   = 700
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "7051"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 7051 for Nginx."
    },
    {
      name                       = "Allow-TFTP"
      priority                   = 800
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "69"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 69 for TFTP."
    },
    {
      name                       = "Allow-WireGuard"
      priority                   = 900
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "51820"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 51820 for TFTP."
    },
    {
      name                       = "Allow-SSH-Out"
      priority                   = 1000
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 22 for SSH."
    },
    {
      name                       = "Allow-HTTP-Out"
      priority                   = 1100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 80 for Nginx."
    },
    {
      name                       = "Allow-HTTPS-Out"
      priority                   = 1200
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 443 for SSL."
    },
    {
      name                       = "Allow-HTTP-Alt-Out"
      priority                   = 1300
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 8080 for OOD."
    },
    {
      name                       = "Allow-Custom-1-Out"
      priority                   = 1400
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "7050"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 7050 for Lunqa2 Daemon."
    },
    {
      name                       = "Allow-Custom-2-Out"
      priority                   = 1500
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "7055"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 7055 for Nginx."
    },
    {
      name                       = "Allow-Custom-3-Out"
      priority                   = 1600
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "7051"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 7051 for Nginx."
    },
    {
      name                       = "Allow-TFTP-Out"
      priority                   = 1700
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "69"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 69 for TFTP."
    },
    {
      name                       = "Allow-WireGuard-Out"
      priority                   = 1800
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "51820"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "TrinityX Using Port 51820 for TFTP."
    }
  ]
}

variable "azure_virtual_network" {
  description = "The name of the Network Security Group"
  type        = string
  default     = "TrinityX-Vnet"
}

variable "azure_virtual_network_tags" {
  description = "The Tags for the Virtual Network"
  type        = map(string)
  default     = {
    HPC         = "TrinityX",
    module      = "network",
    sub-module  = "virtual network"
  }
}

variable "azure_virtual_network_address_space" {
  description = "The address spcae for the Virtual Network"
  type        = list
  default     = [
    "10.1.0.0/16"  
  ]
}

variable "azure_virtual_network_encryption" {
  description = "The Virtual Network Encryption"
  type        = string
  default     = "AllowUnencrypted"
}

variable "azure_virtual_network_subnets" {
  description = "The Subnets for the Virtual Network"
  type        = list(object({
    name            = string
    address_prefix  = string
    security_group  = string
  }))
  default     = [
    {"name": "cluster",   "address_prefix": "10.1.0.0/24", "security_group": "TrinityX-NSG"}
  ]
}
