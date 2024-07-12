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
# File: azure/modules/storage/outputs.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Terraform Sotrage Account, Container, and VHD Outputs file. It will
#              output storage account and VHD information, will be used further.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This output file outputs the Sotrage related information.
# ------------------------------------------------------------------------------

output "storage_name" {
  value       = azurerm_storage_account.storage.name
  description = "The Name of the Storage Account"
}

output "storage_id" {
  value       = azurerm_storage_account.storage.id
  description = "The ID of the Storage Account"
}

output "container_id" {
  value       = azurerm_storage_container.container.id
  description = "The ID of the Storage Account Container"
}

output "vhd_id" {
  value       = azurerm_storage_blob.vhd.id
  description = "The ID of the Uploaded VHD in Storage Account Container"
}

output "vhd_url" {
  value       = azurerm_storage_blob.vhd.url
  description = "The URL of the Uploaded VHD in Storage Account Container"
}


