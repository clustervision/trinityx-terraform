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


# # ------------------------------------------------------------------------------
# # VPN Module
# # This module sets up the VPN for on premises infrastructure, inlcuding, virtual
# # network - gateway subnet, local network gateway, virtual network gateway with
# # public IP.
# # ------------------------------------------------------------------------------
# module "vpn" {
#   count                 = var.aws_vpn ? 1 : 0
#   source                = "./modules/vpn"
#   azure_resource_group  = azurerm_resource_group.rg
#   subnet_id             = module.network[0].subnet_id
#   azure_virtual_network = var.azure_virtual_network

#   azure_virtual_network_gateway_subnet = var.azure_virtual_network_gateway_subnet

#   azure_local_network_gateway                     = var.azure_local_network_gateway
#   azure_local_network_gateway_tags                = var.azure_local_network_gateway_tags
#   azure_local_network_gateway_ip_address          = var.azure_local_network_gateway_ip_address
#   azure_local_network_gateway_address_space       = var.azure_local_network_gateway_address_space
#   azure_local_network_gateway_bgp_asn             = var.azure_local_network_gateway_bgp_asn
#   azure_local_network_gateway_bgp_peering_address = var.azure_local_network_gateway_bgp_peering_address
#   azure_local_network_gateway_bgp_peer_weight     = var.azure_local_network_gateway_bgp_peer_weight

#   azure_vpn_public_ip                   = var.azure_vpn_public_ip
#   azure_vpn_public_ip_tags              = var.azure_vpn_public_ip_tags
#   azure_vpn_public_ip_allocation_method = var.azure_vpn_public_ip_allocation_method
#   azure_vpn_public_ip_sku               = var.azure_vpn_public_ip_sku
#   azure_vpn_public_ip_zones             = var.azure_vpn_public_ip_zones

#   azure_virtual_network_gateway                = var.azure_virtual_network_gateway
#   azure_virtual_network_gateway_tags           = var.azure_virtual_network_gateway_tags
#   azure_virtual_network_gateway_type           = var.azure_virtual_network_gateway_type
#   azure_virtual_network_gateway_vpn_type       = var.azure_virtual_network_gateway_vpn_type
#   azure_virtual_network_gateway_sku            = var.azure_virtual_network_gateway_sku
#   azure_virtual_network_gateway_generation     = var.azure_virtual_network_gateway_generation
#   azure_virtual_network_gateway_bgp_nat        = var.azure_virtual_network_gateway_bgp_nat
#   azure_virtual_network_gateway_active_active  = var.azure_virtual_network_gateway_active_active
#   azure_virtual_network_gateway_bgp            = var.azure_virtual_network_gateway_bgp
  
#   azure_virtual_network_gateway_address_space       = var.azure_virtual_network_gateway_address_space
#   azure_virtual_network_gateway_ip_config_name      = var.azure_virtual_network_gateway_ip_config_name
#   azure_virtual_network_gateway_private_allocation  = var.azure_virtual_network_gateway_private_allocation

#   azure_virtual_network_gateway_connection            = var.azure_virtual_network_gateway_connection
#   azure_virtual_network_gateway_connection_tags       = var.azure_virtual_network_gateway_connection_tags
#   azure_virtual_network_gateway_connection_type       = var.azure_virtual_network_gateway_connection_type
#   azure_virtual_network_gateway_connection_mode       = var.azure_virtual_network_gateway_connection_mode
#   azure_virtual_network_gateway_connection_shared_key = var.azure_virtual_network_gateway_connection_shared_key
# }





# # ------------------------------------------------------------------------------
# # Network Detail
# # This block will get all the network details for TrinityX.
# # ------------------------------------------------------------------------------
# # Fetch the first availability zone
# # data "aws_availability_zones" "available" {}

# # VPC Creation
# # resource "aws_vpc" "trinityx" {
# #   cidr_block       = "10.1.0.0/16"
# #   instance_tenancy = "default"

# #   tags = {
# #     Name = "TrinityX-Terraform-VPC"
# #   }

# #   enable_dns_support   = true
# #   enable_dns_hostnames = true
# # }

# # Public Subnet Creation
# # resource "aws_subnet" "public_subnet" {
# #   vpc_id            = aws_vpc.trinityx.id
# #   cidr_block        = "10.1.0.0/16"
# #   availability_zone = data.aws_availability_zones.available.names[0]

# #   tags = {
# #     Name = "TrinityX-Terraform-Public-Subnet"
# #   }
# # }

# # Internet Gateway Creation
# # resource "aws_internet_gateway" "igw" {
# #   vpc_id = aws_vpc.trinityx.id

# #   tags = {
# #     Name = "TrinityX-Terraform-Internet-Gateway"
# #   }
# # }

# # # Route Table for Public Subnet
# # resource "aws_route_table" "public_rt" {
# #   vpc_id = aws_vpc.trinityx.id

# #   route {
# #     cidr_block = "0.0.0.0/0"
# #     gateway_id = aws_internet_gateway.igw.id
# #   }

# #   tags = {
# #     Name = "TrinityX-Terraform-Public-Route-Table"
# #   }
# # }

# # # Route Table Association
# # resource "aws_route_table_association" "public_rt_assoc" {
# #   subnet_id      = aws_subnet.public_subnet.id
# #   route_table_id = aws_route_table.public_rt.id
# # }

# # # Network ACL
# # resource "aws_network_acl" "public_nacl" {
# #   vpc_id = aws_vpc.trinityx.id

# #   egress {
# #     protocol   = "udp"
# #     rule_no    = 100
# #     action     = "allow"
# #     cidr_block = "0.0.0.0/0"
# #     from_port  = 500
# #     to_port    = 500
# #   }

# #   egress {
# #     protocol   = "udp"
# #     rule_no    = 110
# #     action     = "allow"
# #     cidr_block = "0.0.0.0/0"
# #     from_port  = 4500
# #     to_port    = 4500
# #   }

# #   ingress {
# #     protocol   = "udp"
# #     rule_no    = 100
# #     action     = "allow"
# #     cidr_block = "0.0.0.0/0"
# #     from_port  = 500
# #     to_port    = 500
# #   }

# #   ingress {
# #     protocol   = "udp"
# #     rule_no    = 110
# #     action     = "allow"
# #     cidr_block = "0.0.0.0/0"
# #     from_port  = 4500
# #     to_port    = 4500
# #   }

# #   tags = {
# #     Name = "TrinityX-Terraform-Public-NACL"
# #   }
# # }

# # # Associate Network ACL with the Public Subnet
# # resource "aws_network_acl_association" "public_nacl_assoc" {
# #   subnet_id     = aws_subnet.public_subnet.id
# #   network_acl_id = aws_network_acl.public_nacl.id
# # }

# # # Security Group
# # resource "aws_security_group" "vpn_sg" {
# #   vpc_id = aws_vpc.trinityx.id

# #   ingress {
# #     from_port   = 500
# #     to_port     = 500
# #     protocol    = "udp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   ingress {
# #     from_port   = 4500
# #     to_port     = 4500
# #     protocol    = "udp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   egress {
# #     from_port   = 500
# #     to_port     = 500
# #     protocol    = "udp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   egress {
# #     from_port   = 4500
# #     to_port     = 4500
# #     protocol    = "udp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   ingress {
# #     from_port   = 22
# #     to_port     = 22
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   ingress {
# #     from_port   = 80
# #     to_port     = 80
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   ingress {
# #     from_port   = 443
# #     to_port     = 443
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   ingress {
# #     from_port   = 8080
# #     to_port     = 8080
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   ingress {
# #     from_port   = 7050
# #     to_port     = 7050
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   ingress {
# #     from_port   = 7051
# #     to_port     = 7051
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   tags = {
# #     Name = "TrinityX-Terraform-VPN-SG"
# #   }
# # }

# # Customer Gateway
# resource "aws_customer_gateway" "trinityx_vsphere" {
#   bgp_asn    = 65000
#   ip_address = "45.138.39.108"
#   type       = "ipsec.1"

#   tags = {
#     Name = "TrinityX-Terraform-VSphere"
#   }
# }

# # Virtual Private Gateway
# resource "aws_vpn_gateway" "trinityx_vpg" {
#   vpc_id = aws_vpc.trinityx.id

#   tags = {
#     Name = "TinityX-Terraform-VPG"
#   }
# }

# # VPN Gateway Attachment
# resource "aws_vpn_gateway_attachment" "trinityx_vpg_attachment" {
#   vpc_id          = aws_vpc.trinityx.id
#   vpn_gateway_id  = aws_vpn_gateway.trinityx_vpg.id
# }

# # Site-to-Site VPN Connection
# resource "aws_vpn_connection" "trinityx_vpn" {
#   customer_gateway_id = aws_customer_gateway.trinityx_vsphere.id
#   vpn_gateway_id      = aws_vpn_gateway.trinityx_vpg.id
#   type                = "ipsec.1"

#   static_routes_only = true

#   local_ipv4_network_cidr = "10.141.0.0/16"
#   remote_ipv4_network_cidr = "10.1.0.0/16"

#   # routes {
#   #   destination_cidr_block = "10.141.0.0/16"
#   # }

#   tags = {
#     Name = "TrinityX-Terraform-VPN"
#   }
# }

# # VPN Connection Route
# resource "aws_vpn_connection_route" "trinityx_vpn_route" {
#   vpn_connection_id = aws_vpn_connection.trinityx_vpn.id
#   destination_cidr_block = "10.141.0.0/16"
# }

# # Output VPN Configuration
# output "vpn_connection_configuration" {
#   value = aws_vpn_connection.trinityx_vpn.tunnel1_address
# }

# # Output VPC and Subnet Information
# # output "vpc_id" {
# #   value = aws_vpc.trinityx.id
# # }

# # output "public_subnet_id" {
# #   value = aws_subnet.public_subnet.id
# # }

# # output "internet_gateway_id" {
# #   value = aws_internet_gateway.igw.id
# # }

# # output "route_table_id" {
# #   value = aws_route_table.public_rt.id
# # }

# # output "vpn_sg_id" {
# #   value = aws_security_group.vpn_sg.id
# # }

# output "customer_gateway_id" {
#   value = aws_customer_gateway.trinityx_vsphere.id
# }

# output "vpn_gateway_id" {
#   value = aws_vpn_gateway.trinityx_vpg.id
# }

# output "vpn_connection_id" {
#   value = aws_vpn_connection.trinityx_vpn.id
# }

# # Outputs:

# # vpc_id = "vpc-03bd263c332830ac9"
# # internet_gateway_id = "igw-0fe2bae6007f9640f"
# # public_subnet_id = "subnet-0f14028d7e568ecdb"
# # route_table_id = "rtb-07a1c01b3c141656f"


# # customer_gateway_id = "cgw-019001a0f47b4f0c6"
# # vpn_connection_configuration = "3.65.136.182"
# # vpn_connection_id = "vpn-0efb940a168490052"
# # vpn_gateway_id = "vgw-0c965e0314361d420"
# # vpn_sg_id = "sg-09807799c0ceddb6d"