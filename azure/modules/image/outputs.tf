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
# File: azure/modules/image/outputs.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Terraform Image Outputs file. It will output Image related info.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This output file outputs the Image related information.
# ------------------------------------------------------------------------------

output "image_id" {
  value       = azurerm_image.compute_image.id
  description = "The ID of the Azure Image"
}

# output "gallery_id" {
#   value       = azurerm_shared_image_gallery.gallery.id
#   description = "The ID of the Azure Compute Gallery"
# }

# output "shared_image_id" {
#   value       = azurerm_shared_image.shared_image.id
#   description = "The ID of the Shared Image within Azure Compute Gallery"
# }

# output "image_version_id" {
#   value       = azurerm_shared_image_version.image_version.id
#   description = "The ID of the Version for Shared Image within Azure Compute Gallery"
# }








