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
# File: azure/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-05-31
# Description: Main Terraform configuration file for setting up Azure resources,
#              including every single resource needed for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This configuration sets up the core infrastructure for the TrinityX.
# - Ensure that the variables are correctly set in the variables.tf file.
# - This file should be reviewed and updated regularly to reflect any changes.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Resource Group Definition
# This resource group will be used to contain all related Azure resources for TrinityX.
# ------------------------------------------------------------------------------
resource "azurerm_resource_group" "rg" {
  name     = var.azure_resource_group
  location = var.azure_location
  tags = var.azure_resource_group_tag

}

# ------------------------------------------------------------------------------
# Network Module
# This module sets up the network infrastructure, including virtual networks and network security group.
# ------------------------------------------------------------------------------
module "network" {
  count                 = var.azure_network ? 1 : 0
  source                = "./modules/network"
  azure_resource_group  = azurerm_resource_group.rg

  azure_nsg                = var.azure_nsg
  azure_nsg_tags           = var.azure_nsg_tags
  azure_nsg_security_rules = var.azure_nsg_security_rules

  azure_virtual_network               = var.azure_virtual_network
  azure_virtual_network_tags          = var.azure_virtual_network_tags
  azure_virtual_network_address_space = var.azure_virtual_network_address_space
  azure_virtual_network_encryption    = var.azure_virtual_network_encryption
  azure_virtual_network_subnets       = var.azure_virtual_network_subnets
}


# ------------------------------------------------------------------------------
# VPN Module
# This module sets up the VPN for on premises infrastructure, inlcuding, virtual
# network - gateway subnet, local network gateway, virtual network gateway with
# public IP.
# ------------------------------------------------------------------------------
module "vpn" {
  count                 = var.azure_vpn ? 1 : 0
  source                = "./modules/vpn"
  azure_resource_group  = azurerm_resource_group.rg
  subnet_id             = module.network[0].subnet_id
  azure_virtual_network = var.azure_virtual_network

  azure_virtual_network_gateway_subnet = var.azure_virtual_network_gateway_subnet

  azure_local_network_gateway                     = var.azure_local_network_gateway
  azure_local_network_gateway_tags                = var.azure_local_network_gateway_tags
  azure_local_network_gateway_ip_address          = var.azure_local_network_gateway_ip_address
  azure_local_network_gateway_address_space       = var.azure_local_network_gateway_address_space
  azure_local_network_gateway_bgp_asn             = var.azure_local_network_gateway_bgp_asn
  azure_local_network_gateway_bgp_peering_address = var.azure_local_network_gateway_bgp_peering_address
  azure_local_network_gateway_bgp_peer_weight     = var.azure_local_network_gateway_bgp_peer_weight

  azure_vpn_public_ip                   = var.azure_vpn_public_ip
  azure_vpn_public_ip_tags              = var.azure_vpn_public_ip_tags
  azure_vpn_public_ip_allocation_method = var.azure_vpn_public_ip_allocation_method
  azure_vpn_public_ip_sku               = var.azure_vpn_public_ip_sku
  azure_vpn_public_ip_zones             = var.azure_vpn_public_ip_zones

  azure_virtual_network_gateway                = var.azure_virtual_network_gateway
  azure_virtual_network_gateway_tags           = var.azure_virtual_network_gateway_tags
  azure_virtual_network_gateway_type           = var.azure_virtual_network_gateway_type
  azure_virtual_network_gateway_vpn_type       = var.azure_virtual_network_gateway_vpn_type
  azure_virtual_network_gateway_sku            = var.azure_virtual_network_gateway_sku
  azure_virtual_network_gateway_generation     = var.azure_virtual_network_gateway_generation
  azure_virtual_network_gateway_bgp_nat        = var.azure_virtual_network_gateway_bgp_nat
  azure_virtual_network_gateway_active_active  = var.azure_virtual_network_gateway_active_active
  azure_virtual_network_gateway_bgp            = var.azure_virtual_network_gateway_bgp
  
  azure_virtual_network_gateway_address_space       = var.azure_virtual_network_gateway_address_space
  azure_virtual_network_gateway_ip_config_name      = var.azure_virtual_network_gateway_ip_config_name
  azure_virtual_network_gateway_private_allocation  = var.azure_virtual_network_gateway_private_allocation

  azure_virtual_network_gateway_connection            = var.azure_virtual_network_gateway_connection
  azure_virtual_network_gateway_connection_tags       = var.azure_virtual_network_gateway_connection_tags
  azure_virtual_network_gateway_connection_type       = var.azure_virtual_network_gateway_connection_type
  azure_virtual_network_gateway_connection_mode       = var.azure_virtual_network_gateway_connection_mode
  azure_virtual_network_gateway_connection_shared_key = var.azure_virtual_network_gateway_connection_shared_key
}


# ------------------------------------------------------------------------------
# Storage Module
# This module sets up the Storage Account, Container, and Upload the VHD.
# ------------------------------------------------------------------------------
module "storage" {
  count                 = var.azure_storage ? 1 : 0
  source                = "./modules/storage"
  azure_resource_group  = azurerm_resource_group.rg
 
  azure_storage_account              = var.azure_storage_account
  azure_storage_account_tag          = var.azure_storage_account_tag
  azure_storage_account_kind         = var.azure_storage_account_kind
  azure_storage_account_tier         = var.azure_storage_account_tier
  azure_storage_replication_type     = var.azure_storage_replication_type
  azure_storage_access_tier          = var.azure_storage_access_tier
  azure_storage_min_tls              = var.azure_storage_min_tls
  azure_storage_https_traffic        = var.azure_storage_https_traffic
  azure_storage_access_key           = var.azure_storage_access_key
  azure_storage_public_network       = var.azure_storage_public_network
  azure_storage_oauth                = var.azure_storage_oauth
  azure_storage_hns                  = var.azure_storage_hns
  azure_storage_nfsv3                = var.azure_storage_nfsv3
  azure_storage_blob_versioning      = var.azure_storage_blob_versioning
  azure_storage_blob_change_feed     = var.azure_storage_blob_change_feed
  azure_storage_retain_deleted_blobs = var.azure_storage_retain_deleted_blobs

  azure_storage_container             = var.azure_storage_container
  azure_storage_container_access_type = var.azure_storage_container_access_type

  azure_vhd             = var.azure_vhd
  azure_vhd_type        = var.azure_vhd_type
  azure_vhd_file_path   = var.azure_vhd_file_path
  azure_vhd_access_tier = var.azure_vhd_access_tier
}

# ------------------------------------------------------------------------------
# Image Module
# This module sets up the Image and Shared Image Gallery, and versioning of the Image.
# ------------------------------------------------------------------------------
module "image" {
  count                 = var.azure_images ? 1 : 0
  source                = "./modules/image"
  azure_resource_group  = azurerm_resource_group.rg
  storage_id            = module.storage[0].storage_id
  vhd_url               = module.storage[0].vhd_url

  azure_image                     = var.azure_image
  azure_image_tags                = var.azure_image_tags
  azure_image_zone_resilient      = var.azure_image_zone_resilient
  azure_image_hyper_v_generation  = var.azure_image_hyper_v_generation
  azure_image_os_type             = var.azure_image_os_type
  azure_image_os_state            = var.azure_image_os_state
  azure_image_cachinge            = var.azure_image_cachinge

  azure_compute_gallery             = var.azure_compute_gallery
  azure_compute_gallery_tags        = var.azure_compute_gallery_tags
  azure_compute_gallery_description = var.azure_compute_gallery_description
  azure_compute_gallery_sharing     = var.azure_compute_gallery_sharing

  azure_shared_image                    = var.azure_shared_image
  azure_shared_image_tags               = var.azure_shared_image_tags
  azure_shared_image_os_type            = var.azure_shared_image_os_type
  azure_shared_image_hyper_v_generation = var.azure_shared_image_hyper_v_generation
  azure_shared_image_trusted_launch     = var.azure_shared_image_trusted_launch
  azure_shared_accelerated_network      = var.azure_shared_accelerated_network
  azure_shared_architecture             = var.azure_shared_architecture
  azure_shared_image_publisher          = var.azure_shared_image_publisher
  azure_shared_image_offer              = var.azure_shared_image_offer
  azure_shared_image_sku                = var.azure_shared_image_sku

  azure_shared_image_version                        = var.azure_shared_image_version
  azure_shared_image_version_tags                   = var.azure_shared_image_version_tags
  azure_shared_image_version_replication_mode       = var.azure_shared_image_version_replication_mode
  azure_shared_image_version_regional_replica_count = var.azure_shared_image_version_regional_replica_count
  azure_shared_image_version_latest                 = var.azure_shared_image_version_latest
  azure_shared_image_version_storage_account_type   = var.azure_shared_image_version_storage_account_type
}

# ------------------------------------------------------------------------------
# Controller Module
# This module sets up the TrinityX Controller to the Azure Cloud.
# ------------------------------------------------------------------------------
module "controller" {
  count                 = var.azure_controller ? 1 : 0
  source                = "./modules/controller"
  azure_resource_group  = azurerm_resource_group.rg
  subnet_id             = module.network[0].subnet_id
  storage_name          = module.storage[0].storage_name

  azure_trinityx_ssh_key_algorithm  = var.azure_trinityx_ssh_key_algorithm
  azure_trinityx_ssh_key_rsa_bits   = var.azure_trinityx_ssh_key_rsa_bits
  azure_trinityx_ssh_key_name       = var.azure_trinityx_ssh_key_name
  azure_trinityx_ssh_key_tags       = var.azure_trinityx_ssh_key_tags

  azure_controller_ssh_public_key_access        = var.azure_controller_ssh_public_key_access
  azure_controller_controller_public_ip         = var.azure_controller_controller_public_ip
  azure_controller_public_ip_tags               = var.azure_controller_public_ip_tags
  azure_controller_public_ip_allocation_method  = var.azure_controller_public_ip_allocation_method
  azure_controller_public_ip_sku                = var.azure_controller_public_ip_sku
  azure_controller_public_ip_zones              = var.azure_controller_public_ip_zones

  azure_controller_network_interface              = var.azure_controller_network_interface
  azure_controller_network_interface_tags         = var.azure_controller_network_interface_tags
  azure_vm_network_ip_name                        = var.azure_vm_network_ip_name
  azure_controller_network_private_ip_allocation  = var.azure_controller_network_private_ip_allocation
  azure_controller_private_ip_address             = var.azure_controller_private_ip_address
  azure_controller_private_ip_address_version     = var.azure_controller_private_ip_address_version

  azure_controller_name                         = var.azure_controller_name
  azure_controller_size                         = var.azure_controller_size
  azure_controller_delete_os_disk               = var.azure_controller_delete_os_disk
  azure_controller_delete_data_disk             = var.azure_controller_delete_data_disk
  azure_controller_image_publisher              = var.azure_controller_image_publisher
  azure_controller_image_offer                  = var.azure_controller_image_offer
  azure_controller_image_sku                    = var.azure_controller_image_sku
  azure_controller_image_version                = var.azure_controller_image_version
  azure_controller_image_marketplace_agreement  = var.azure_controller_image_marketplace_agreement
  azure_controller_os_caching                   = var.azure_controller_os_caching
  azure_controller_os_create                    = var.azure_controller_os_create
  azure_controller_os_disk_type                 = var.azure_controller_os_disk_type
  azure_controller_os_plan                      = var.azure_controller_os_plan
  azure_controller_os_plan_publisher            = var.azure_controller_os_plan_publisher
  azure_controller_os_plan_product              = var.azure_controller_os_plan_product
  azure_controller_os_username                  = var.azure_controller_os_username
  azure_controller_os_password                  = var.azure_controller_os_password
  azure_controller_disable_auth                 = var.azure_controller_disable_auth
}

# ------------------------------------------------------------------------------
# Node(s) Calculation
# This block will expand the node hostlist and prepare a node list for Node Module.
# ------------------------------------------------------------------------------
locals {
  count     = var.azure_node ? 1 : 0
  hostnames = [
    for i in var.azure_hostlist != "" ? range(tonumber(regex("\\[(\\d+)-(\\d+)\\]", var.azure_hostlist)[0]), tonumber(regex("\\[(\\d+)-(\\d+)\\]", var.azure_hostlist)[1]) + 1) : [] : format(
      "%s%03d%s",
      regex("^(.*?)\\[", var.azure_hostlist)[0],
      i,
      regex("\\](.*?)$", var.azure_hostlist)[0]
    )
  ]
}

resource "null_resource" "controller_dependency" {
  count = var.azure_controller && var.azure_node ? 1 : 0
  depends_on = [module.controller]
}

# ------------------------------------------------------------------------------
# Node Module
# This module sets up the TrinityX Nodes for the Controller to the Azure Cloud.
# ------------------------------------------------------------------------------
module "node" {
  count                 = var.azure_node ? 1 : 0
  source                = "./modules/node"
  hostnames             = local.hostnames
  azure_resource_group  = azurerm_resource_group.rg

  subnet_id             = var.subnet_id != "" ? var.subnet_id : module.network[0].subnet_id
  image_id              = var.image_id != "" ? var.image_id : module.image[0].image_id
  storage_name          = var.storage_name != "" ? var.storage_name : module.storage[0].storage_name

  azure_vm_network_ip_name                  = var.azure_vm_network_ip_name
  azure_node_network_private_ip_allocation  = var.azure_node_network_private_ip_allocation
  azure_node_size                           = var.azure_node_size
  azure_node_delete_os_disk                 = var.azure_node_delete_os_disk
  azure_node_delete_data_disk               = var.azure_node_delete_data_disk
  azure_node_os_caching                     = var.azure_node_os_caching
  azure_node_os_create                      = var.azure_node_os_create
  azure_node_os_disk_type                   = var.azure_node_os_disk_type
  azure_node_os_username                    = var.azure_node_os_username
  azure_node_os_password                    = var.azure_node_os_password
  azure_node_disable_auth                   = var.azure_node_disable_auth

  depends_on =  [null_resource.controller_dependency]

}
