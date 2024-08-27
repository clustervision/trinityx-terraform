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
# File: aws/modules/vpn/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-06
# Description: Terraform module for creating VPN connection in AWS including
#              customer gateway, vpn gateway, vpn gateway attachment to VPC,
#              site-to-site vpn tunnel, and connection routes.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This module expects certain variables to be passed in for proper configuration.
# - Ensure that the parent module provides the required variables.
# - The module includes best practices for network security and scalability.
# - All variables will be passed by the Root(parent) module.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Get Public IP Address
# This data block will get the public IP Address for the running machine and will
# use for the VPN Configuration.
# ------------------------------------------------------------------------------
data "http" "ipinfo" {
  url = "https://ipinfo.io/json"
}

# ------------------------------------------------------------------------------
# Customer Gateway
# This block will create a customer gatwway for on-premises connection.
# ------------------------------------------------------------------------------
resource "aws_customer_gateway" "trinityx_vsphere" {
  bgp_asn    = var.aws_customer_gateway_bgp_asn
  ip_address = var.aws_customer_gateway_ip_address != "" ? var.aws_customer_gateway_ip_address : jsondecode(data.http.ipinfo.response_body).ip
  type       = var.aws_customer_gateway_type

  tags = {
    Name = var.aws_customer_gateway_name
  }
}

# ------------------------------------------------------------------------------
# Virtual Private Gateway
# This blovck will create a virtual private gateway for VPN connection.
# ------------------------------------------------------------------------------
resource "aws_vpn_gateway" "trinityx_vpg" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.aws_vpn_gateway_name
  }
}

# ------------------------------------------------------------------------------
# VPN Gateway Attachment
# This block will attach the VPN gateway to the VPC.
# ------------------------------------------------------------------------------
resource "aws_vpn_gateway_attachment" "trinityx_vpg_attachment" {
  vpc_id          = var.vpc_id
  vpn_gateway_id  = aws_vpn_gateway.trinityx_vpg.id
}

# ------------------------------------------------------------------------------
# Route for the VPN connection
# This block will create a route in the specified route table to route traffic
# destined for the VPN Route network through the Virtual Private Gateway.
# ------------------------------------------------------------------------------
resource "aws_route" "vpn_route" {
  route_table_id         = var.route_table_id
  destination_cidr_block = var.aws_vpn_local_ipv4_network_cidr
  gateway_id             = aws_vpn_gateway.trinityx_vpg.id 
}

# ------------------------------------------------------------------------------
# Site-to-Site VPN Connection
# This block will create a Site-to-Site VPN Connection.
# ------------------------------------------------------------------------------
resource "aws_vpn_connection" "trinityx_vpn" {
  customer_gateway_id = aws_customer_gateway.trinityx_vsphere.id
  vpn_gateway_id      = aws_vpn_gateway.trinityx_vpg.id
  type                = var.aws_vpn_connection_type

  static_routes_only = var.aws_vpn_static_routes_only

  local_ipv4_network_cidr = var.aws_vpn_local_ipv4_network_cidr
  remote_ipv4_network_cidr = var.aws_vpn_remote_ipv4_network_cidr

  tags = {
    Name = var.aws_vpn_name
  }
}

# ------------------------------------------------------------------------------
# VPN Connection Route
# This block will attach the VPN connection route
# ------------------------------------------------------------------------------
resource "aws_vpn_connection_route" "trinityx_vpn_route" {
  vpn_connection_id = aws_vpn_connection.trinityx_vpn.id
  destination_cidr_block = var.aws_vpn_connection_route_cidr_block
}

