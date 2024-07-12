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
# File: azure/outputs.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Main output file for the Azure Terraform configuration for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This file has all the output blocks.
# - Can add/remove the output block, if you are using it seprately.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Output from Network Module
output "subnet_id" {
  value       = var.azure_network ? module.network[0].subnet_id : null
  description = "The ID of the subnet created in the network module"
}

output "nsg_id" {
  value       = var.azure_network ? module.network[0].nsg_id : null
  description = "The ID of the Network Security Group created in the network module"
}

output "vnet_id" {
  value       = var.azure_network ? module.network[0].vnet_id : null
  description = "The ID of the Virtual Network created in the network module"
}

# ------------------------------------------------------------------------------
# Output from VPN Module
output "vnet_gateway_id" {
  value         = var.azure_vpn ? module.vpn[0].vnet_gateway_id : null
  description   = "The ID of the Gateway Subnet created for the Virtual Network in VPN Module"
}

output "lng_id" {
  value         = var.azure_vpn ? module.vpn[0].lng_id : null
  description   = "The ID of Local Network Gateway created in VPN Module"
}

output "vng_ip_id" {
  value         = var.azure_vpn ? module.vpn[0].vng_ip_id : null
  description   = "The ID of the Virtual Network Gateway Public IP Address created in the VPN Module"
}

output "vng_ip" {
  value         = var.azure_vpn ? module.vpn[0].vng_ip : null
  description   = "The Public IP Address for Virtual Network Gateway created in the VPN Module"
}

output "vng_id" {
  value         = var.azure_vpn ? module.vpn[0].vng_id : null
  description   = "The ID of the Virtual Network Gateway created in the VPN Module"
}

output "connection_id" {
  value         = var.azure_vpn ? module.vpn[0].connection_id : null
  description   = "The ID of the Connection created in the VPN Module between Local Network Gateway and Virtual Network Gateway."
}

output "ipinfo" {
  value       = var.azure_vpn ? module.vpn[0].ipinfo : null
  description = "The Public IP Address for the installation Machine."
}

# ------------------------------------------------------------------------------
# Output from Storage Module
output "storage_name" {
  value       = var.azure_storage ? module.storage[0].storage_name : null
  description = "The Name of the Storage Account"
}

output "storage_id" {
  value       = var.azure_storage ? module.storage[0].storage_id : null
  description = "The ID of the Storage Account"
}

output "container_id" {
  value       = var.azure_storage ? module.storage[0].container_id : null
  description = "The ID of the Storage Account Container"
}

output "vhd_id" {
  value       = var.azure_storage ? module.storage[0].vhd_id : null
  description = "The ID of the Uploaded VHD in Storage Account Container"
}

output "vhd_url" {
  value       = var.azure_storage ? module.storage[0].vhd_url : null
  description = "The URL of the Uploaded VHD in Storage Account Container"
}

# ------------------------------------------------------------------------------
# Output from Image Module
output "image_id" {
  value       = var.azure_images ? module.image[0].image_id : null
  description = "The ID of the Azure Image"
}

# output "gallery_id" {
#   value       = var.azure_images ? module.image[0].gallery_id : null
#   description = "The ID of the Azure Compute Gallery"
# }

# output "shared_image_id" {
#   value       = var.azure_images ? module.image[0].shared_image_id : null
#   description = "The ID of the Shared Image within Azure Compute Gallery"
# }

# output "image_version_id" {
#   value       = var.azure_images ? module.image[0].image_version_id : null
#   description = "The ID of the Version for Shared Image within Azure Compute Gallery"
# }

# ------------------------------------------------------------------------------
# Output from the Controller
# output "controller_agr" {
#   value       = var.azure_controller ? module.controller[0].controller_agr : null
#   description = "Marketplace OS Agreement for Controller"
# }

# output "ssh_public_key" {
#   value       = var.azure_controller ? module.controller[0].ssh_public_key : null
#   description = "Container SSH Public Key for Authentication"
# }

# output "ssh_private_key" {
#   value       = var.azure_controller ? module.controller[0].ssh_private_key : null
#   sensitive   = true
#   description = "Container SSH Private Key to store some where safely"
# }

# output "ssh_public_key_id" {
#   value       = var.azure_controller ? module.controller[0].ssh_public_key_id : null
#   description = "Container SSH Public Key ID"
# }

output "controller_public_ip_id" {
  value       = var.azure_controller ? module.controller[0].controller_public_ip_id : null
  description = "The ID of the Public IP Address created for the Controller"
}

output "controller_public_ip_address" {
  value       = var.azure_controller ? module.controller[0].controller_public_ip_address : null
  description = "The Public IP Address created for the Controller"
}

output "controller_nic" {
  value       = var.azure_controller ? module.controller[0].controller_nic : null
  description = "The ID of the Network Interface created for the Controller"
}

output "controller_id" {
  value       = var.azure_controller ? module.controller[0].controller_id : null
  description = "The ID of the Controller"
}

output "controller_os_disk_name" {
  value       = var.azure_controller ? module.controller[0].controller_os_disk_name : null
  description = "The OS Disk Name created for the Controller"
}

output "controller_os_disk_id" {
  value       = var.azure_controller ? module.controller[0].controller_os_disk_id : null
  description = "The  OS Disk Name ID created for the Controller"
}

# output "controller_ssh_key_path" {
#   value       = var.azure_controller ? module.controller[0].controller_ssh_key_path : null
#   description = "The Controller SSH Key Path"
# }

# ------------------------------------------------------------------------------
# Output from the Node
output "hostnames" {
  value =   length(local.hostnames) > 0 ? local.hostnames : []
  description = "The list of hostnames if it has values; otherwise, an empty list"
}

output "node_nic" {
  value       = var.azure_node ? module.node[0].node_nic : null
  description = "The ID of the Network Interface created for the Node"
}

output "node_id" {
  value       = var.azure_node ? module.node[0].node_id : null
  description = "The ID of the Node"
}

output "node_os_disk_name" {
  value       = var.azure_node ? module.node[0].node_os_disk_name : null
  description = "The OS Disk Name created for the Node"
}

output "node_os_disk_id" {
  value       = var.azure_node ? module.node[0].node_os_disk_id : null
  description = "The  OS Disk Name ID created for the Node"
}
