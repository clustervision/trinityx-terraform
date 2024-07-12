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
# File: azure/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Variables file for the main Terraform configuration for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - Define all the input variables required by the main configuration and modules.
# - Update the default values as needed to match the target environment.
# - Ensure sensitive variables are handled securely.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ #
# Azure Cloud Modules
variable "azure_network" {
  description = "The Azure Networks."
  type        = bool
  default     = false
}

variable "azure_vpn" {
  description = "The Azure VPN."
  type        = bool
  default     = false
}

variable "azure_storage" {
  description = "The Azure Storage Account."
  type        = bool
  default     = false
}

variable "azure_images" {
  description = "The Azure OS Image (VHD)."
  type        = bool
  default     = false
}

variable "azure_controller" {
  description = "The Azure Controller."
  type        = bool
  default     = false
}

variable "azure_node" {
  description = "The Azure Node"
  type        = bool
  default     = false
}

# Azure Cloud Modules
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Cloud Credentials
variable "azure_subscription_id" {
  description = "The Subscription ID for Azure"
  type        = string
  default     = ""

  validation {
    condition     = length(var.azure_subscription_id) == 36
    error_message = "The Azure Subscription ID must be a valid subscription_id"
  }
}

variable "azure_client_id" {
  description = "The Client ID for Azure"
  type        = string
  default     = ""
}

variable "azure_client_secret" {
  description = "The Client Secret for Azure"
  type        = string
  sensitive   = true
  default     = ""
}

variable "azure_tenant_id" {
  description = "The Tenant ID for Azure"
  type        = string
  default     = ""
}
# Azure Cloud Credentials
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Resource Group & Location

variable "azure_resource_group" {
  description = "The Azure Resource Group Name"
  type        = string
  default     = ""
}

variable "azure_resource_group_tag" {
  description = "The Azure Resource Group Tags"
  type    = map(string)
  default = {
    HPC = "TrinityX"
  }
}

variable "azure_location" {
  description = "The Azure Resource Group Location"
  type        = string
  default     = "Germany West Central"
}

# Azure Resource Group & Location
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Network Service Group & Rules
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
  type    = map(string)
  default = {
    HPC = "TrinityX",
    module = "network",
    sub-module = "security group"
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
# Azure Network Service Group & Rules
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Virtual Network, Address Space, Subnets
variable "azure_virtual_network" {
  description = "The name of the Virtual Network"
  type        = string
  default     = "TrinityX-Vnet"
}

variable "azure_virtual_network_tags" {
  description = "The Tags for the Virtual Network"
  type    = map(string)
  default = {
    HPC = "TrinityX",
    module = "network",
    sub-module = "virtual network"
  }
}

variable "azure_virtual_network_encryption" {
  description = "The Virtual Network Encryption"
  type        = string
  default     = "AllowUnencrypted"
}

variable "azure_virtual_network_address_space" {
  description = "The address spcae for the Virtual Network"
  type        = list
  default     = [
    "10.1.0.0/16"    
  ]
}

variable "azure_virtual_network_subnets" {
  description = "The Subnets for the Virtual Network"
  type        = list(object({
    name                  = string
    address_prefix        = string
    security_group        = string
  }))
  default     = [
    {"name": "cluster",   "address_prefix": "10.1.0.0/24", "security_group": "TrinityX-NSG"}   
  ]
}

# Azure Virtual Network, Address Space, Subnets
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Virtual Network [Gateway Subnet], Virtual Network Gateway, Local Network Gatewat.
variable "azure_virtual_network_gateway_subnet" {
  description = "The name of the Network Security Group"
  type        = object({
    name                  = string
    address_prefix        = string
    security_group        = string
  })
  default     = {"name": "GatewaySubnet", "address_prefix": "10.1.255.0/27", "security_group": null}
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
# Azure Virtual Network [Gateway Subnet], Virtual Network Gateway, Local Network Gatewat.
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Storage Account, Blob Container, VHD Upload, Azure Image, Shared Image Gallery & Versioning.
variable "azure_storage_account" {
  description = "The Account Name for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_account_tag" {
  description = "The Tags for the Storage Account"
  type    = map(string)
  default = {
    HPC        = "TrinityX"
    module     = "storage",
    sub-module = "account"
  }
}

variable "azure_storage_account_kind" {
  description = "The Account kind for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_account_tier" {
  description = "The Account Tier for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_replication_type" {
  description = "The Replication Type for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_access_tier" {
  description = "The Access Tier for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_min_tls" {
  description = "The Minimum TLS for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_https_traffic" {
  description = "The HTTPS traffic for Azure Storage Account"
  type        = bool
  default     = true
}

variable "azure_storage_access_key" {
  description = "The Access Key for Azure Storage Account"
  type        = bool
  default     = true
}

variable "azure_storage_public_network" {
  description = "The Public network access for Azure Storage Account"
  type        = bool
  default     = true
}

variable "azure_storage_oauth" {
  description = "The OAuth for Azure Storage Account"
  type        = bool
  default     = false
}

variable "azure_storage_hns" {
  description = "The Hierarchical namespace for Azure Storage Account"
  type        = bool
  default     = false
}

variable "azure_storage_nfsv3" {
  description = "The NFS V3 for Azure Storage Account"
  type        = bool
  default     = false
}

variable "azure_storage_blob_versioning" {
  description = "The Blob Versioning for Azure Storage Account"
  type        = string
  default     = ""
}
variable "azure_storage_blob_change_feed" {
  description = "The Blob Change Feed for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_retain_deleted_blobs" {
  description = "The Retain Deleted Blobs for Azure Storage Account"
  type        = number
  default     = 7
}
# Azure Storage Account, Blob Container, VHD Upload, Azure Image, Shared Image Gallery & Versioning.
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Storage Account Container
variable "azure_storage_container" {
  description = "The Container Name for the Azure Storage Account"
  type        = string
  default     = "trinityx-images"
}

variable "azure_storage_container_access_type" {
  description = "The Container Access Type for the Azure Storage Account"
  type        = string
  default     = "private"
}
# Azure Storage Account Container
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Storage Storage Blob VHD
variable "azure_vhd" {
  description = "The name of the storage blob"
  type        = string
  default     = "azure.vhd"
}

variable "azure_vhd_type" {
  description = "The type of the storage blob"
  type        = string
  default     = "Page"
}

variable "azure_vhd_file_path" {
  description = "The local path to the VHD file"
  type        = string
  default     = "/trinity/images/azure.vhd"
}

variable "azure_vhd_access_tier" {
  description = "The access tier for the VHD file"
  type        = string
  default     = "Hot"
}
# Azure Storage Storage Blob VHD
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Image
variable "azure_image" {
  description = "The Name for Azure Image"
  type        = string
  default     = "TrinityX-Compute"
}

variable "azure_image_tags" {
  description = "The Tags for the Azure Image"
  type    = map(string)
  default = {
    HPC        = "TrinityX"
    module     = "image",
    sub-module = "vhd"
  }
}

variable "azure_image_zone_resilient" {
  description = "The zone resiliency for Azure Image"
  type        = bool
  default     = true
}

variable "azure_image_hyper_v_generation" {
  description = "The HyperV Generation Type for Azure Image"
  type        = string
  default     = "V2"
}

variable "azure_image_os_type" {
  description = "The operating system type for Azure Image"
  type        = string
  default     = "Linux"
}

variable "azure_image_os_state" {
  description = "The operating system state for Azure Image"
  type        = string
  default     = "Generalized"
}

variable "azure_image_cachinge" {
  description = "The caching mode for Azure Image"
  type        = string
  default     = "ReadWrite"
}
# Azure Image
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Compute Gallery
variable "azure_compute_gallery" {
  description = "The Account Name for Azure Compute Gallery"
  type        = string
  default     = "TrinityXGallery"
}

variable "azure_compute_gallery_tags" {
  description = "The Tags for the Azure Compute Gallery"
  type    = map(string)
  default = {
    HPC        = "TrinityX"
    module     = "image",
    sub-module = "gallery"
  }
}

variable "azure_compute_gallery_description" {
  description = "The Account Name for Azure Compute Gallery"
  type        = string
  default     = "This is TrinityX Image Gallery. Here you can attach your own OS Images and share depends on your need."
}

variable "azure_compute_gallery_sharing" {
  description = "The Account Name for Azure Storage Account"
  type        = string
  default     = "Private"
}
# Azure Compute Gallery
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Compute Gallery Image
variable "azure_shared_image" {
  description = "The Name for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "TrinityX-Compute"
}

variable "azure_shared_image_tags" {
  description = "The Tags for the Shared Image within a Shared Image Gallery"
  type    = map(string)
  default = {
    HPC        = "TrinityX"
    module     = "image",
    sub-module = "gallery shared"
  }
}

variable "azure_shared_image_os_type" {
  description = "The operating system type for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "Linux"
}

variable "azure_shared_image_trusted_launch" {
  description = "The Trusted Launch for Shared Image within a Shared Image Gallery"
  type        = bool
  default     = true
}

variable "azure_shared_image_hyper_v_generation" {
  description = "The HyperV Generation forShared Image within a Shared Image Gallery"
  type        = string
  default     = "V2"
}

variable "azure_shared_accelerated_network" {
  description = "The Accelerated Network for Shared Image within a Shared Image Gallery"
  type        = bool
  default     = true
}

variable "azure_shared_architecture" {
  description = "The Architecture for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "x64"
}

variable "azure_shared_image_publisher" {
  description = "The Publisher for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "TrinityX"
}

variable "azure_shared_image_offer" {
  description = "The Offers for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "HPC"
}

variable "azure_shared_image_sku" {
  description = "The SKU for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "iPXE-GRUB"
}
# Azure Compute Gallery Image
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Compute Gallery Image Version
variable "azure_shared_image_version" {
  description = "The Version for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "0.0.1"
}

variable "azure_shared_image_version_tags" {
  description = "The Tags for the Version of a Shared Image within a Shared Image Gallery"
  type        = map(string)
  default     = {
    HPC        = "TrinityX"
    module     = "image",
    sub-module = "gallery version"
  }
}

variable "azure_shared_image_version_replication_mode" {
  description = "The Replication Mode for Version of a Shared Image within a Shared Image Gallery"
  type        = string
  default     = "Full"
}

variable "azure_shared_image_version_regional_replica_count" {
  description = "The Account Name for Version of a Shared Image within a Shared Image Gallery"
  type        = number
  default     = 1
}

variable "azure_shared_image_version_latest" {
  description = "Exclude from Latest for Version of a Shared Image within a Shared Image Gallery"
  type        = bool
  default     = false
}

variable "azure_shared_image_version_storage_account_type" {
  description = "The Account Name for Version of a Shared Image within a Shared Image Gallery"
  type        = string
  default     = "Standard_ZRS"
}
# Azure Compute Gallery Image Version
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Controller
variable "azure_trinityx_ssh_key_algorithm" {
  description = "The Algorithm for SSH Key"
  type        = string
  default     = "RSA"
}

variable "azure_trinityx_ssh_key_rsa_bits" {
  description = "The Algorithm for SSH Key RSA Bits."
  type        = number
  default     = 4096
}

variable "azure_trinityx_ssh_key_name" {
  description = "The Name for SSH Key"
  type        = string
  default     = "TrinityX-SSH"
}

variable "azure_trinityx_ssh_key_tags" {
  description = "The Tags for the SSH Key"
  type        = map(string)
  default     = {
    HPC        = "TrinityX"
    module     = "controller",
    sub-module = "ssh"
  }
}

variable "azure_controller_ssh_public_key_access" {
  description = "The Public IP Address for the Controller"
  type        = string
  default     = "Blank"
}

variable "azure_controller_controller_public_ip" {
  description = "The Public IP Address for the Controller"
  type        = string
  default     = "TrinityXVNGIP"
}

variable "azure_controller_public_ip_tags" {
  description = "The Tags for the Public IP Address for the Controller"
  type    = map(string)
  default = {
    HPC        = "TrinityX",
    module     = "network",
    sub-module = "virtual network gateway"
  }
}

variable "azure_controller_public_ip_allocation_method" {
  description = "The IP Address Allocation Method for the Controller Public IP"
  type        = string
  default     = "Static"
}

variable "azure_controller_public_ip_sku" {
  description = "The SKU for Controller Public IP"
  type        = string
  default     = "Standard"
}

variable "azure_controller_public_ip_zones" {
  description = "The Zones for the Controller Public IP"
  type        = list
  default     = ["1", "2", "3"]
}

variable "azure_controller_network_interface" {
  description = "The Network Interface Name for the Controller"
  type        = string
  default     = "TrinityX-Controller-nic"
}

variable "azure_controller_network_interface_tags" {
  description = "The Tags for the Controller"
  type        = map(string)
  default     = {
    HPC        = "TrinityX"
    module     = "vm",
    sub-module = "controller"
  }
}

variable "azure_vm_network_ip_name" {
  description = "The Network IP Name for the Controller"
  type        = string
  default     = "internal"
}

variable "azure_controller_network_private_ip_allocation" {
  description = "The Private IP Allocation for the Controller"
  type        = string
  default     = "Static"
}

variable "azure_controller_private_ip_address" {
  description = "The Private IP Address for the Controller"
  type        = string
  default     = "10.1.0.254"
}

variable "azure_controller_private_ip_address_version" {
  description = "The Private IP Version for the Controller"
  type        = string
  default     = "IPv4"
}

variable "azure_controller_name" {
  description = "The Name of the Controller"
  type        = string
  default     = "TrinityX-Controller"
}

variable "azure_controller_size" {
  description = "The size of the Controller"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "azure_controller_delete_os_disk" {
  description = "Delete OS disk on Termination for Controller"
  type        = bool
  default     = true
}

variable "azure_controller_delete_data_disk" {
  description = "Delete Data disk on Termination for Controller"
  type        = bool
  default     = true
}

variable "azure_controller_image_publisher" {
  description = "Controller OS Image Publisher Name"
  type        = string
  default     = "resf"
}

variable "azure_controller_image_offer" {
  description = "Controller OS Image Publisher offer"
  type        = string
  default     = "rockylinux-x86_64"
}

variable "azure_controller_image_sku" {
  description = "Controller OS Image Publisher SKU"
  type        = string
  default     = "8-lvm"
}

variable "azure_controller_image_version" {
  description = "Controller OS Image Publisher Version"
  type        = string
  default     = "latest"
}

variable "azure_controller_image_marketplace_agreement" {
  description = "Controller OS Image Publisher Version"
  type        = bool
  default     = true
}

variable "azure_controller_os_caching" {
  description = "Controller OS Caching"
  type        = string
  default     = "ReadWrite"
}

variable "azure_controller_os_create" {
  description = "Controller OS Create Option from"
  type        = string
  default     = "FromImage"
}

variable "azure_controller_os_disk_type" {
  description = "The OS Disk Type for the Controller"
  type        = string
  default     = "Standard_LRS"
}

variable "azure_controller_os_plan" {
  description = "The OS Plan Name for the Controller"
  type        = string
  default     = "8-lvm"
}

variable "azure_controller_os_plan_publisher" {
  description = "The OS Plan Publisher for the Controller"
  type        = string
  default     = "resf"
}

variable "azure_controller_os_plan_product" {
  description = "The OS Plan Product for the Controller"
  type        = string
  default     = "rockylinux-x86_64"
}

variable "azure_controller_os_username" {
  description = "The OS Username for the Controller"
  type        = string
  default     = "azureuser"
}

variable "azure_controller_os_password" {
  description = "The OS Password for the Controller"
  type        = string
  default     = ""
}

variable "azure_controller_disable_auth" {
  description = "Disable password Authentication for the Controller"
  type        = bool
  default     = true
}
# Azure Controller
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Node
variable "azure_hostlist" {
  description = "List of Azure nodes in the format azvm[001-004]"
  default     = "azvm[001-004]"
}

variable "azure_node_network_private_ip_allocation" {
  description = "The Private IP Allocation for the Node(s)"
  type        = string
  default     = "Dynamic"
}

variable "azure_node_size" {
  description = "The size of the Node"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "azure_node_delete_os_disk" {
  description = "Delete OS disk on Termination for Node(s)"
  type        = bool
  default     = true
}

variable "azure_node_delete_data_disk" {
  description = "Delete Data disk on Termination for Node(s)"
  type        = bool
  default     = true
}

variable "azure_node_os_caching" {
  description = "Node OS Caching"
  type        = string
  default     = "ReadWrite"
}

variable "azure_node_os_create" {
  description = "Node OS Create Option from"
  type        = string
  default     = "FromImage"
}

variable "azure_node_os_disk_type" {
  description = "The OS Disk Type for the Node"
  type        = string
  default     = "Standard_LRS"
}

variable "azure_node_os_username" {
  description = "The OS Username for the Node"
  type        = string
  default     = "azureuser"
}

variable "azure_node_os_password" {
  description = "The OS Password for the Node"
  type        = string
  default     = ""
}

variable "azure_node_disable_auth" {
  description = "Disable password Authentication for the Node"
  type        = bool
  default     = false
}
# Azure Node
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Add By the the Previous Runs
variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to place the VM in"
  default     = ""
}
variable "image_id" {
  type        = string
  description = "The ID of the subnet to place the VM in"
  default     = ""
}

variable "storage_name" {
  type        = string
  description = "The ID of the subnet to place the VM in"
  default     = ""
}
# Add By the the Previous Runs
# ------------------------------------------------------------------------------ #





