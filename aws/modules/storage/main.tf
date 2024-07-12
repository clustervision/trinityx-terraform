
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
# File: azure/modules/storage/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Terraform module for creating Storage account, blob container,
#               and upload the VHD in.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This module expects certain variables to be passed in for proper configuration.
# - Ensure that the parent module provides the required variables.
# - The module includes best practices for Storage Account, Container and VHD.
# - All variables will be passed by the Root(parent) module.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Storage Account Name Definition
# This block will create Storage Account Name which should be unique across the Azure.
# ------------------------------------------------------------------------------
resource "random_string" "rnd" {
  length      = 4
  min_numeric = 4
  special     = false
  lower       = true
}

# ------------------------------------------------------------------------------
# Storage Account Definition
# This block will create a Storage Account.
# ------------------------------------------------------------------------------
resource "azurerm_storage_account" "storage" {
  # name                          = "${var.azure_storage_account}${formatdate("YYYYMMDDhhmmss", timestamp())}${random_string.rnd.result}"
  name                          = "${var.azure_storage_account}${formatdate("YYYYMMDDhhmmss", timestamp())}"
  resource_group_name           = var.azure_resource_group.name
  location                      = var.azure_resource_group.location
  account_kind                  = var.azure_storage_account_kind
  account_tier                  = var.azure_storage_account_tier
  account_replication_type      = var.azure_storage_replication_type
  tags                          = var.azure_storage_account_tag
  access_tier                   = var.azure_storage_access_tier
  min_tls_version               = var.azure_storage_min_tls
  enable_https_traffic_only     = var.azure_storage_https_traffic
  shared_access_key_enabled     = var.azure_storage_access_key
  public_network_access_enabled = var.azure_storage_public_network
  default_to_oauth_authentication = var.azure_storage_oauth
  is_hns_enabled = var.azure_storage_hns
  nfsv3_enabled = var.azure_storage_nfsv3
  blob_properties {
    versioning_enabled = var.azure_storage_blob_versioning
    change_feed_enabled = var.azure_storage_blob_change_feed
    delete_retention_policy {
      days = var.azure_storage_retain_deleted_blobs
    }
  }
  
  # lifecycle {
  #   prevent_destroy = true
  # }
  
}

# ------------------------------------------------------------------------------
# Storage Account Container Definition
# This block will create a blob Container inside the Storage Account.
# ------------------------------------------------------------------------------
resource "azurerm_storage_container" "container" {
  name                  =  var.azure_storage_container
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = var.azure_storage_container_access_type

  # lifecycle {
  #   prevent_destroy = true
  # }

}

# ------------------------------------------------------------------------------
# Upload VHD
# This block will upload VHD file to the blob Container inside the Storage Account.
# ------------------------------------------------------------------------------
resource "azurerm_storage_blob" "vhd" {
  name                   = var.azure_vhd
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = var.azure_vhd_type
  source                 = var.azure_vhd_file_path
  # access_tier            = var.azure_vhd_access_tier
  depends_on             = [azurerm_storage_container.container]

  # lifecycle {
  #   prevent_destroy = true
  # }

}




