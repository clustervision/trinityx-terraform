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

variable "storage_name" {
  type        = string
  description = "The Name of the Storage Account"
}

# Azure Resource Group & Subnet ID
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

