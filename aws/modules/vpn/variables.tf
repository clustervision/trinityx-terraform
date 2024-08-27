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
# File: aws/modules/vpn/variables.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-06
# Description: Terraform Variables file for the VPN module for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - Define all the input variables required by the vpn module.
# - Update the default values as needed to match the target environment.
# - Ensure sensitive variables are handled securely.
# ------------------------------------------------------------------------------

variable "vpc_id" {
  description = "The AWS VPC ID."
  type        = string
  default     = ""
}

variable "route_table_id" {
  description = "The AWS Route Table ID of the VPC."
  type        = string
  default     = ""
}

variable "aws_customer_gateway_name" {
  description = "The AWS customer gateway name."
  type        = string
  default     = ""
}

variable "aws_customer_gateway_bgp_asn" {
  description = "The AWS customer gateway Border Gateway Protocol Autonomous System Numbe ."
  type        = number
  default     = 65000
}

variable "aws_customer_gateway_ip_address" {
  description = "The AWS customer gateway internet-routable IP."
  type        = string
  default     = ""
}

variable "aws_customer_gateway_type" {
  description = "The AWS customer gateway type."
  type        = string
  default     = ""
}

variable "aws_vpn_gateway_name" {
  description = "The AWS VPN gateway name."
  type        = string
  default     = ""
}

variable "aws_vpn_name" {
  description = "The AWS VPN name."
  type        = string
  default     = ""
}

variable "aws_vpn_connection_type" {
  description = "The AWS VPN connection type name."
  type        = string
  default     = ""
}

variable "aws_vpn_static_routes_only" {
  description = "The AWS VPN static route only flag."
  type        = bool
  default     = true
}

variable "aws_vpn_local_ipv4_network_cidr" {
  description = "The AWS VPN local IPv4 CIDR."
  type        = string
  default     = ""
}

variable "aws_vpn_remote_ipv4_network_cidr" {
  description = "The AWS VPN remote IPv4 CIDR."
  type        = string
  default     = ""
}

variable "aws_vpn_connection_route_cidr_block" {
  description = "The AWS VPN connection route destination CIDR block."
  type        = string
  default     = ""
}




