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

