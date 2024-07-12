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
# File: azure/modules/controller/variables.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Variables file for the all resources for the controller.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - Define all the input variables required by the vpn module.
# - Update the default values as needed to match the target environment.
# - Ensure sensitive variables are handled securely.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ #
# Azure Resource Group & Subnet ID
variable "azure_resource_group" {
  description = "The name of the Resource Group"
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

variable "image_id" {
  type        = string
  default     = ""
  description = "The ID of the Azure Image which is created by the VHD"
}

variable "hostnames" {
  type        = list
  description = "The ID of the subnet to place the VM in"
  default     = []
}

variable "azure_vm_network_ip_name" {
  description = "The Network IP Name for the Controller"
  type        = string
  default     = "internal"
}

variable "storage_name" {
  type        = string
  description = "The Name of the Storage Account"
}

# Azure Resource Group & Subnet ID
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







