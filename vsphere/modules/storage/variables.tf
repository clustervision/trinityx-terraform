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
# File: azure/modules/storage/variables.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Variables file for the Storage Account, conatiner and VHD.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - Define all the input variables required by the main configuration and modules.
# - Update the default values as needed to match the target environment.
# - Ensure sensitive variables are handled securely.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ #
# Azure Resource Group
variable "azure_resource_group" {
  description = "The name of the Network Security Group"
  type        = object({ 
    name      = string
    location  = string
  })
  default     = {
    name      = "TrinityX"
    location  = "Germany West Central"
  }
}
# Azure Resource Group
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Storage Account, Blob Container, VHD Upload, Azure Image, Shared Image Gallery & Versioning.
variable "azure_storage_account" {
  description = "The Account Name for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_account_tag" {
  description = "The Tags for the Storage Account"
  type    = map(string)
  default = {
    HPC        = "TrinityX"
    module     = "storage",
    sub-module = "account"
  }
}

variable "azure_storage_account_kind" {
  description = "The Account kind for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_account_tier" {
  description = "The Account Tier for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_replication_type" {
  description = "The Replication Type for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_access_tier" {
  description = "The Access Tier for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_min_tls" {
  description = "The Minimum TLS for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_https_traffic" {
  description = "The HTTPS traffic for Azure Storage Account"
  type        = bool
  default     = true
}

variable "azure_storage_access_key" {
  description = "The Access Key for Azure Storage Account"
  type        = bool
  default     = true
}

variable "azure_storage_public_network" {
  description = "The Public network access for Azure Storage Account"
  type        = bool
  default     = true
}

variable "azure_storage_oauth" {
  description = "The OAuth for Azure Storage Account"
  type        = bool
  default     = false
}

variable "azure_storage_hns" {
  description = "The Hierarchical namespace for Azure Storage Account"
  type        = bool
  default     = false
}

variable "azure_storage_nfsv3" {
  description = "The NFS V3 for Azure Storage Account"
  type        = bool
  default     = false
}

variable "azure_storage_blob_versioning" {
  description = "The Blob Versioning for Azure Storage Account"
  type        = string
  default     = ""
}
variable "azure_storage_blob_change_feed" {
  description = "The Blob Change Feed for Azure Storage Account"
  type        = string
  default     = ""
}

variable "azure_storage_retain_deleted_blobs" {
  description = "The Retain Deleted Blobs for Azure Storage Account"
  type        = number
  default     = 7
}
# Azure Storage Account, Blob Container, VHD Upload, Azure Image, Shared Image Gallery & Versioning.
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Storage Account Container
variable "azure_storage_container" {
  description = "The Container Name for the Azure Storage Account"
  type        = string
  default     = "trinityx-images"
}

variable "azure_storage_container_access_type" {
  description = "The Container Access Type for the Azure Storage Account"
  type        = string
  default     = "private"
}
# Azure Storage Account Container
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Storage Storage Blob VHD
variable "azure_vhd" {
  description = "The name of the storage blob"
  type        = string
  default     = "azure.vhd"
}
variable "azure_vhd_type" {
  description = "The type of the storage blob"
  type        = string
  default     = "Page"
}

variable "azure_vhd_file_path" {
  description = "The local path to the VHD file"
  type        = string
  default     = "/trinity/images/azure.vhd"
}

variable "azure_vhd_access_tier" {
  description = "The access tier for the VHD file"
  type        = string
  default     = "Hot"
}
# Azure Storage Storage Blob VHD
# ------------------------------------------------------------------------------ #




