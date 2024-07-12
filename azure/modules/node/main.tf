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
# File: azure/modules/node/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-06-03
# Description: Terraform module for creating Controller network Interface in Azure,
#              And The TrinityX Controller on Azure Cloud.
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
# Node Network Interface Definition
# This block will create Nodes network interface for TrinityX Controller.
# ------------------------------------------------------------------------------
resource "azurerm_network_interface" "node_nic" {
  for_each = toset(var.hostnames)
  name                = "${each.key}-nic"
  resource_group_name = var.azure_resource_group.name
  location            = var.azure_resource_group.location

  ip_configuration {
    name                          = var.azure_vm_network_ip_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.azure_node_network_private_ip_allocation
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
  
}

resource "azurerm_virtual_machine" "node" {
  for_each              = toset(var.hostnames)
  name                  = each.key
  resource_group_name   = var.azure_resource_group.name
  location              = var.azure_resource_group.location
  vm_size               = var.azure_node_size
  network_interface_ids = [azurerm_network_interface.node_nic[each.key].id]

  delete_os_disk_on_termination     = var.azure_node_delete_os_disk
  delete_data_disks_on_termination  = var.azure_node_delete_data_disk

  storage_os_disk {
    name              = "${each.key}-osdisk"
    caching           = var.azure_node_os_caching
    create_option     = var.azure_node_os_create
    managed_disk_type = var.azure_node_os_disk_type
    disk_size_gb      = 20
  }

  os_profile {
    computer_name  = each.key
    admin_username = var.azure_node_os_username
    admin_password = var.azure_node_os_password
  }

  os_profile_linux_config {
    disable_password_authentication = var.azure_node_disable_auth
  }

  storage_image_reference {
    id = var.image_id
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = "https://${var.storage_name}.blob.core.windows.net/"
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
  
}



