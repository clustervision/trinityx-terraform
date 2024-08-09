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
# File: aws/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-05
# Description: Main Terraform configuration file for setting up AWS resources,
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
# Fetch the first availability zone
# This block will retrive the first availability zone for TrinityX Installation.
# ------------------------------------------------------------------------------
data "aws_availability_zones" "available" {}

# ------------------------------------------------------------------------------
# Network Module
# This module sets up the network infrastructure, including VPC, public subnet,
# internet gateway, routing table, network access control list and security group.
# ------------------------------------------------------------------------------
module "network" {
  count                 = var.aws_network ? 1 : 0
  source                = "./modules/network"
  aws_availability_zone = data.aws_availability_zones.available.names[0]

  aws_vpc_name                    = var.aws_vpc_name
  aws_vpc_cidr_block              = var.aws_vpc_cidr_block
  aws_vpc_instance_tenancy        = var.aws_vpc_instance_tenancy
  aws_vpc_enable_dns_support      = var.aws_vpc_enable_dns_support
  aws_vpc_enable_dns_hostnames    = var.aws_vpc_enable_dns_hostnames

  aws_vpc_subnet_name             = var.aws_vpc_subnet_name
  aws_vpc_subnet_cidr_block       = var.aws_vpc_subnet_cidr_block
  aws_vpc_internet_gateway_name   = var.aws_vpc_internet_gateway_name

  aws_route_table_cidr_block  = var.aws_route_table_cidr_block
  aws_route_table_name        = var.aws_route_table_name

  aws_network_acl_name  = var.aws_network_acl_name
  aws_network_acl_rules = var.aws_network_acl_rules

  aws_security_group_name   = var.aws_security_group_name
  aws_security_group_rules  = var.aws_security_group_rules
}


# ------------------------------------------------------------------------------
# VPN Module
# This module sets up the VPN for on premises infrastructure inlcuding customer
# gateway, vpn gateway, vpn gateway attachment to VPC, site-to-site vpn tunnel,
# and connection routes.
# ------------------------------------------------------------------------------
module "vpn" {
  count   = var.aws_vpn ? 1 : 0
  source  = "./modules/vpn"
  vpc_id  = module.network[0].vpc_id
  
  aws_customer_gateway_name       = var.aws_customer_gateway_name
  aws_customer_gateway_bgp_asn    = var.aws_customer_gateway_bgp_asn
  aws_customer_gateway_ip_address = var.aws_customer_gateway_ip_address
  aws_customer_gateway_type       = var.aws_customer_gateway_type

  aws_vpn_gateway_name  = var.aws_vpn_gateway_name

  aws_vpn_name                      = var.aws_vpn_name
  aws_vpn_connection_type           = var.aws_vpn_connection_type
  aws_vpn_static_routes_only        = var.aws_vpn_static_routes_only
  aws_vpn_local_ipv4_network_cidr   = var.aws_vpn_local_ipv4_network_cidr
  aws_vpn_remote_ipv4_network_cidr  = var.aws_vpn_remote_ipv4_network_cidr

  aws_vpn_connection_route_cidr_block = var.aws_vpn_connection_route_cidr_block
}


# ------------------------------------------------------------------------------
# Storage Module
# This module sets up the AWS storage S3
# ------------------------------------------------------------------------------
module "storage" {
  count   = var.aws_storage ? 1 : 0
  source  = "./modules/storage"
  
  aws_s3_bucket_prefix            = var.aws_s3_bucket_prefix
  aws_s3_force_destroy            = var.aws_s3_force_destroy
  aws_s3_bucket_name_tag          = var.aws_s3_bucket_name_tag
  aws_s3_bucket_env               = var.aws_s3_bucket_env
  aws_s3_bucket_versioning        = var.aws_s3_bucket_versioning
  aws_s3_bucket_enc_algorithm     = var.aws_s3_bucket_enc_algorithm
  aws_s3_bucket_key               = var.aws_s3_bucket_key
  aws_s3_block_public_acls        = var.aws_s3_block_public_acls
  aws_s3_block_public_policy      = var.aws_s3_block_public_policy
  aws_s3_ignore_public_acls       = var.aws_s3_ignore_public_acls
  aws_s3_restrict_public_buckets  = var.aws_s3_restrict_public_buckets
}

# ------------------------------------------------------------------------------
# Image Module
# This module will create a AMI on the AWS storage S3
# ------------------------------------------------------------------------------
module "image" {
  count       = var.aws_image ? 1 : 0
  source      = "./modules/image"
  bucket_name = module.storage[0].bucket_name

  aws_region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  
  aws_s3_object_key_path      = var.aws_s3_object_key_path
  aws_s3_object_source        = var.aws_s3_object_source
  aws_s3_object_content_type  = var.aws_s3_object_content_type
  aws_s3_object_encryption    = var.aws_s3_object_encryption

  aws_iam_role_name           = var.aws_iam_role_name
  aws_iam_role_policy_version = var.aws_iam_role_policy_version
  aws_iam_role_policy_effect  = var.aws_iam_role_policy_effect
  aws_iam_role_policy_service = var.aws_iam_role_policy_service
  aws_iam_role_policy_action  = var.aws_iam_role_policy_action

  aws_iam_role_policy_ec2_access  = var.aws_iam_role_policy_ec2_access
  aws_iam_role_policy_ec2_role    = var.aws_iam_role_policy_ec2_role
  aws_iam_role_policy_s3_access   = var.aws_iam_role_policy_s3_access
  aws_iam_role_policy_s3_read     = var.aws_iam_role_policy_s3_read

  aws_image_license_type      = var.aws_image_license_type
  aws_image_boot_mode         = var.aws_image_boot_mode
  aws_image_description       = var.aws_image_description
  aws_image_platform          = var.aws_image_platform
  aws_image_role              = var.aws_image_role
  aws_image_container_format  = var.aws_image_container_format
  aws_image_containe_desc     = var.aws_image_containe_desc
}

# ------------------------------------------------------------------------------
# Controller Module
# This module will create and set up the TrinityX Controller on the AWS.
# ------------------------------------------------------------------------------
module "controller" {
  count             = var.aws_controller ? 1 : 0
  source            = "./modules/controller"
  vpc_id            = module.network[0].vpc_id
  public_subnet_id  = module.network[0].public_subnet_id
  sg_id             = module.network[0].sg_id

  aws_controller_ami_latest         = var.aws_controller_ami_latest
  aws_controller_ami_filter_by      = var.aws_controller_ami_filter_by
  aws_controller_ami_filter_values  = var.aws_controller_ami_filter_values
  aws_controller_ami_owners         = var.aws_controller_ami_owners

  aws_controller_instance_type        = var.aws_controller_instance_type
  aws_controller_automatic_public_ip  = var.aws_controller_automatic_public_ip
  aws_controller_root_device_size     = var.aws_controller_root_device_size
  aws_controller_root_device_type     = var.aws_controller_root_device_type
  aws_controller_name                 = var.aws_controller_name
  aws_controller_ip                   = var.aws_controller_ip
  aws_controller_eip_domain           = var.aws_controller_eip_domain
  aws_controller_ssh_public_key       = var.aws_controller_ssh_public_key
  aws_controller_os_username          = var.aws_controller_os_username
  aws_controller_os_password          = var.aws_controller_os_password

}

# ------------------------------------------------------------------------------
# Node(s) Calculation
# This block will expand the node hostlist and prepare a node list for Node Module.
# ------------------------------------------------------------------------------
locals {
  count     = var.aws_node ? 1 : 0
  hostnames = [
    for i in var.aws_hostlist != "" ? range(tonumber(regex("\\[(\\d+)-(\\d+)\\]", var.aws_hostlist)[0]), tonumber(regex("\\[(\\d+)-(\\d+)\\]", var.aws_hostlist)[1]) + 1) : [] : format(
      "%s%03d%s",
      regex("^(.*?)\\[", var.aws_hostlist)[0],
      i,
      regex("\\](.*?)$", var.aws_hostlist)[0]
    )
  ]
}

resource "null_resource" "controller_dependency" {
  count = var.aws_controller && var.aws_node ? 1 : 0
  depends_on = [module.controller]
}

# ------------------------------------------------------------------------------
# Node Module
# This module will create and set up the TrinityX Nodes on the AWS.
# ------------------------------------------------------------------------------
module "node" {
  count     = var.aws_node ? 1 : 0
  source    = "./modules/node"
  hostnames = local.hostnames

  ami_id            = module.image[0].ami_id
  vpc_id            = module.network[0].vpc_id
  public_subnet_id  = module.network[0].public_subnet_id
  sg_id             = module.network[0].sg_id

  aws_node_instance_type        = var.aws_node_instance_type
  aws_node_automatic_public_ip  = var.aws_node_automatic_public_ip
  aws_node_root_device_size     = var.aws_node_root_device_size
  aws_node_root_device_type     = var.aws_node_root_device_type

  depends_on =  [null_resource.controller_dependency]
}
