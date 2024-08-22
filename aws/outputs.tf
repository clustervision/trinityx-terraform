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
# File: aws/outputs.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-05
# Description: Main output file for the AWS Terraform configuration for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This file has all the output blocks.
# - Can add/remove the output block, if you are using it seprately.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Output from Network Module
output "vpc_id" {
  value = var.aws_network ? module.network[0].vpc_id : null
  description = "The ID of the VPC created in the network module"
}

output "public_subnet_id" {
  value = var.aws_network ? module.network[0].public_subnet_id : null
  description = "The ID of the public subnet created in the network module"
}

output "internet_gateway_id" {
  value = var.aws_network ? module.network[0].internet_gateway_id : null
  description = "The ID of the internet gateway created in the network module"
}

output "route_table_id" {
  value = var.aws_network ? module.network[0].route_table_id : null
  description = "The ID of the routing table created in the network module"
}

output "sg_id" {
  value = var.aws_network ? module.network[0].sg_id : null
  description = "The ID of the security group created in the network module"
}
# Output from Network Module
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Output from VPN Module
output "ipinfo" {
  value       = var.aws_vpn ? module.vpn[0].ipinfo : null
  description = "The Public IP Address for the installation Machine."
}

output "customer_gateway_id" {
  value       = var.aws_vpn ? module.vpn[0].customer_gateway_id : null
  description = "The ID of the customer gateway created in VPN Module"
}

output "vpn_gateway_id" {
  value       = var.aws_vpn ? module.vpn[0].vpn_gateway_id : null
  description = "The ID of the VPN gateway ID created in VPN Module"
}

output "vpn_connection_id" {
  value       = var.aws_vpn ? module.vpn[0].vpn_connection_id : null
  description = "The ID of the VPN connection ID created in VPN Module"
}

output "vpn_tunnel1_ip" {
  value       = var.aws_vpn ? module.vpn[0].vpn_tunnel1_ip : null
  description = "The VPN Tunnel1 IP Address"
}

output "vpn_tunnel1_preshared_key" {
  value       = var.aws_vpn ? module.vpn[0].vpn_tunnel1_preshared_key : null
  description = "The VPN Tunnel1 Preshared Key"
}

output "vpn_tunnel2_ip" {
  value       = var.aws_vpn ? module.vpn[0].vpn_tunnel2_ip : null
  description = "The VPN Tunnel2 IP Address"
}

output "vpn_tunnel2_preshared_key" {
  value       = var.aws_vpn ? module.vpn[0].vpn_tunnel2_preshared_key : null
  description = "The VPN Tunnel2 Preshared Key"
}

output "vpn_connection_configuration_detail" {
  value       = var.aws_vpn ? module.vpn[0].vpn_connection_configuration_detail : null
  description = "The VPN configuration details"
}
# Output from VPN Module
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Output from Storage Module
output "bucket_name" {
  value       = var.aws_storage ? module.storage[0].bucket_name : null
  description = "The AWS S3 Bucket Name for the TrinityX."
}

output "bucket_arn" {
  value       = var.aws_storage ? module.storage[0].bucket_arn : null
  description = "The AWS S3 Bucket ARN for the TrinityX."
}

# Output from Storage Module
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Output from Image Module
output "object_url" {
  value       = var.aws_images ? module.image[0].object_url : null
  description = "The S3 URL for the VHD."
}

output "ami_id" {
  value       = var.aws_images ? module.image[0].ami_id : null
  description = "The AMI ID."
}
# Output from Image Module
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Output from Controller Module
output "aws_controller_ami_id" {
  description = "The AWS Controller AMI ID"
  value       = var.aws_controller ? module.controller[0].aws_controller_ami_id : null
}

output "controller_id" {
  description = "The AWS controller EC2 instance ID"
  value       = var.aws_controller ? module.controller[0].controller_id : null
}

output "controller_public_ip" {
  description = "The AWS controller public IP address"
  value       = var.aws_controller ? module.controller[0].controller_public_ip : null
}
# Output from Controller Module
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Output from Node Module
output "account_id" {
  description = "The Account ID of the Current User."
  value = var.aws_node ? module.node[0].account_id : null
}

output "node_ami_id" {
  description = "The AMI ID."
  value       = var.aws_node ? module.node[0].node_ami_id : null
}

output "node_id" {
  description = "The ID of the Node"
  value       = var.aws_node ? module.node[0].node_id : null
}

output "node_ip" {
  description = "The IP of the Node"
  value       = var.aws_node ? module.node[0].node_ip : null
}

output "node_interface_id" {
  description = "The Interface ID for the Node"
  value = var.aws_node ? module.node[0].node_interface_id : null
}

output "node_mac_address" {
  description = "The MAC address of the EC2 instance"
  value = var.aws_node ? module.node[0].node_mac_address : null
}
# Output from Controller Module
# ------------------------------------------------------------------------------







