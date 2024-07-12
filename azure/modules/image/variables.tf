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
# File: azure/modules/image/variables.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Variables file for the Images, Shared Images, And Versioning.
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
# Storage & VHD Variable from Storage Module
variable "storage_id" {
  type        = string
  description = "The ID of the Storage Account"
  default     = ""
}

variable "vhd_url" {
  description = "The URL of the Uploaded VHD"
  type        = string
  default     = ""
}
# Storage & VHD Variable from Storage Module
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Image
variable "azure_image" {
  description = "The Name for Azure Image"
  type        = string
  default     = "TrinityX-Compute"
}

variable "azure_image_tags" {
  description = "The Tags for the Azure Image"
  type    = map(string)
  default = {
    HPC        = "TrinityX"
    module     = "image",
    sub-module = "vhd"
  }
}

variable "azure_image_zone_resilient" {
  description = "The zone resiliency for Azure Image"
  type        = bool
  default     = true
}

variable "azure_image_hyper_v_generation" {
  description = "The HyperV Generation Type for Azure Image"
  type        = string
  default     = "V2"
}

variable "azure_image_os_type" {
  description = "The operating system type for Azure Image"
  type        = string
  default     = "Linux"
}

variable "azure_image_os_state" {
  description = "The operating system state for Azure Image"
  type        = string
  default     = "Generalized"
}

variable "azure_image_cachinge" {
  description = "The caching mode for Azure Image"
  type        = string
  default     = "ReadWrite"
}
# Azure Image
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Compute Gallery
variable "azure_compute_gallery" {
  description = "The Account Name for Azure Compute Gallery"
  type        = string
  default     = "TrinityXGallery"
}

variable "azure_compute_gallery_tags" {
  description = "The Tags for the Azure Compute Gallery"
  type    = map(string)
  default = {
    HPC        = "TrinityX"
    module     = "image",
    sub-module = "gallery"
  }
}

variable "azure_compute_gallery_description" {
  description = "The Account Name for Azure Compute Gallery"
  type        = string
  default     = "This is TrinityX Image Gallery. Here you can attach your own OS Images and share depends on your need."
}

variable "azure_compute_gallery_sharing" {
  description = "The Account Name for Azure Storage Account"
  type        = string
  default     = "Private"
}
# Azure Compute Gallery
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Compute Gallery Image
variable "azure_shared_image" {
  description = "The Name for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "TrinityX-Compute"
}

variable "azure_shared_image_tags" {
  description = "The Tags for the Shared Image within a Shared Image Gallery"
  type    = map(string)
  default = {
    HPC        = "TrinityX"
    module     = "image",
    sub-module = "gallery shared"
  }
}

variable "azure_shared_image_os_type" {
  description = "The operating system type for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "Linux"
}

variable "azure_shared_image_trusted_launch" {
  description = "The Trusted Launch for Shared Image within a Shared Image Gallery"
  type        = bool
  default     = true
}

variable "azure_shared_image_hyper_v_generation" {
  description = "The HyperV Generation forShared Image within a Shared Image Gallery"
  type        = string
  default     = "V2"
}

variable "azure_shared_accelerated_network" {
  description = "The Accelerated Network for Shared Image within a Shared Image Gallery"
  type        = bool
  default     = true
}

variable "azure_shared_architecture" {
  description = "The Architecture for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "x64"
}

variable "azure_shared_image_publisher" {
  description = "The Publisher for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "TrinityX"
}

variable "azure_shared_image_offer" {
  description = "The Offers for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "HPC"
}

variable "azure_shared_image_sku" {
  description = "The SKU for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "iPXE-GRUB"
}
# Azure Compute Gallery Image
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# Azure Compute Gallery Image Version
variable "azure_shared_image_version" {
  description = "The Version for Shared Image within a Shared Image Gallery"
  type        = string
  default     = "0.0.1"
}

variable "azure_shared_image_version_tags" {
  description = "The Tags for the Version of a Shared Image within a Shared Image Gallery"
  type        = map(string)
  default     = {
    HPC        = "TrinityX"
    module     = "image",
    sub-module = "gallery version"
  }
}

variable "azure_shared_image_version_replication_mode" {
  description = "The Replication Mode for Version of a Shared Image within a Shared Image Gallery"
  type        = string
  default     = "Full"
}

variable "azure_shared_image_version_regional_replica_count" {
  description = "The Account Name for Version of a Shared Image within a Shared Image Gallery"
  type        = number
  default     = 1
}

variable "azure_shared_image_version_latest" {
  description = "Exclude from Latest for Version of a Shared Image within a Shared Image Gallery"
  type        = bool
  default     = false
}

variable "azure_shared_image_version_storage_account_type" {
  description = "The Account Name for Version of a Shared Image within a Shared Image Gallery"
  type        = string
  default     = "Standard_ZRS"
}
# Azure Compute Gallery Image Version
# ------------------------------------------------------------------------------ #
