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
# File: azure/modules/node/outputs.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Terraform Node Module Outputs file, will be output some of
#              important information, will be used further.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This output file outputs the node related information.
# ------------------------------------------------------------------------------

output "node_nic" {
  value       = { for k, v in azurerm_network_interface.node_nic : k => v.id }
  description = "The ID of the Network Interface created for the Node"
}

output "node_id" {
  value       = { for k, v in azurerm_virtual_machine.node : k => v.id }
  description = "The ID of the Node"
}

output "node_os_disk_name" {
  value       = { for k, v in azurerm_virtual_machine.node : k => v.storage_os_disk[0].name }
  description = "The OS Disk Name created for the Node"
}

output "node_os_disk_id" {
  value       = { for k, v in azurerm_virtual_machine.node : k => v.storage_os_disk[0].managed_disk_id }
  description = "The  OS Disk Name ID created for the Node"
}


