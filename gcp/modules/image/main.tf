
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
# File: azure/modules/image/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Terraform module for creating Image resources in Azure,
#              including Shared Image Gallery and versioning.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This module expects certain variables to be passed in for proper configuration.
# - Ensure that the parent module provides the required variables.
# - The module includes best practices for OS Image, Gallery, and Versioning.
# - All variables will be passed by the Root(parent) module.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Image Definition
# This block will create a image defination with the VHD Blob.
# ------------------------------------------------------------------------------
resource "azurerm_image" "compute_image" {
  name                = var.azure_image
  resource_group_name = var.azure_resource_group.name
  location            = var.azure_resource_group.location
  tags                = var.azure_image_tags
  hyper_v_generation  = var.azure_image_hyper_v_generation
  zone_resilient      = var.azure_image_zone_resilient
  os_disk {
    os_type   = var.azure_image_os_type
    os_state  = var.azure_image_os_state
    blob_uri  = var.vhd_url
    caching   = var.azure_image_cachinge    
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
  
}

# ------------------------------------------------------------------------------
# Shared Image Gallery Definition
# This block will create a azure compute(shared) image gallery.
# ------------------------------------------------------------------------------
# resource "azurerm_shared_image_gallery" "gallery" {
#   name                = var.azure_compute_gallery
#   resource_group_name = var.azure_resource_group.name
#   location            = var.azure_resource_group.location
#   description         = var.azure_compute_gallery_description
#   tags                = var.azure_compute_gallery_tags
#   sharing {
#     permission = var.azure_compute_gallery_sharing
#   }
# }

# ------------------------------------------------------------------------------
# Shared Image Definition
# This block will create a Shared image.
# ------------------------------------------------------------------------------
# resource "azurerm_shared_image" "shared_image" {
#   name                                = var.azure_shared_image
#   gallery_name                        = azurerm_shared_image_gallery.gallery.name
#   resource_group_name                 = var.azure_resource_group.name
#   location                            = var.azure_resource_group.location
#   tags                                = var.azure_shared_image_tags

#   os_type                             = var.azure_shared_image_os_type
#   hyper_v_generation                  = var.azure_shared_image_hyper_v_generation
#   trusted_launch_supported            = var.azure_shared_image_trusted_launch
#   accelerated_network_support_enabled = var.azure_shared_accelerated_network
#   architecture                        = var.azure_shared_architecture
#   identifier {
#     publisher = var.azure_shared_image_publisher
#     offer     = var.azure_shared_image_offer
#     sku       = var.azure_shared_image_sku
#   }
# }

# ------------------------------------------------------------------------------
# Shared Image Version
# This block will create a Version to use the Shared image.
# ------------------------------------------------------------------------------
# resource "azurerm_shared_image_version" "image_version" {
#   name                = var.azure_shared_image_version
#   gallery_name        = azurerm_shared_image_gallery.gallery.name
#   image_name          = azurerm_shared_image.shared_image.name
#   resource_group_name = var.azure_resource_group.name
#   location            = var.azure_resource_group.location
#   tags                = var.azure_shared_image_version_tags
#   blob_uri            = var.vhd_url
#   storage_account_id  = var.storage_id
#   replication_mode    = var.azure_shared_image_version_replication_mode
#   target_region {
#     name                        = azurerm_shared_image.shared_image.location
#     regional_replica_count      = var.azure_shared_image_version_regional_replica_count
#     exclude_from_latest_enabled = var.azure_shared_image_version_latest
#     storage_account_type        = var.azure_shared_image_version_storage_account_type
#   }
# }





