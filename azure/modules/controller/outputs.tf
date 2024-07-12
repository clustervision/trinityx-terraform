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
# File: azure/modules/controller/outputs.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Terraform Controller Module Outputs file, will be output some of
#              important information, will be used further.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This output file outputs the controller related information.
# ------------------------------------------------------------------------------

# output "controller_agr" {
#   value       = azurerm_marketplace_agreement.controller_agr.id
#   description = "Marketplace OS Agreement for Controller"
# }

# output "ssh_public_key" {
#   value       = tls_private_key.trinityx.public_key_openssh
#   description = "Container SSH Public Key for Authentication"
# }

# output "ssh_private_key" {
#   value       = tls_private_key.trinityx.private_key_pem
#   sensitive   = true
#   description = "Container SSH Private Key to store some where safely"
# }

# output "ssh_public_key_id" {
#   value       = azurerm_ssh_public_key.trinityx_key.id
#   description = "Container SSH Public Key ID"
# }

output "controller_public_ip_id" {
  value       = azurerm_public_ip.controller_public_ip.id
  description = "The ID of the Public IP Address created for the Controller"
}

output "controller_public_ip_address" {
  value       = azurerm_public_ip.controller_public_ip.ip_address
  description = "The Public IP Address created for the Controller"
}

output "controller_nic" {
  value       = azurerm_network_interface.controller_nic.id
  description = "The ID of the Network Interface created for the Controller"
}

output "controller_id" {
  value       = azurerm_virtual_machine.controller.id
  description = "The ID of the Controller"
}

output "controller_os_disk_name" {
  value       = azurerm_virtual_machine.controller.storage_os_disk[0].name
  description = "The OS Disk Name created for the Controller"
}

output "controller_os_disk_id" {
  value       = azurerm_virtual_machine.controller.storage_os_disk[0].managed_disk_id
  description = "The  OS Disk Name ID created for the Controller"
}

# output "controller_ssh_key_path" {
#   value = [for config in azurerm_virtual_machine.controller.os_profile_linux_config : config.ssh_keys[0].path if config.ssh_keys != null][0]
#   description = "The Controller SSH Key Path"
# }

