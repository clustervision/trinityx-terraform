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
# File: aws/modules/vpn/outputs.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-06
# Description: Terraform VPN Module Outputs file, will be output some of
#              important information, will be used further.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This output file outputs the vpn related information.
# ------------------------------------------------------------------------------

output "ipinfo" {
  value       = jsondecode(data.http.ipinfo.response_body).ip
  description = "The Public IP Address for the installation Machine."
}

output "customer_gateway_id" {
  value       = aws_customer_gateway.trinityx_vsphere.id
  description = "The ID of the customer gateway created in VPN Module"
}

output "vpn_gateway_id" {
  value       = aws_vpn_gateway.trinityx_vpg.id
  description = "The ID of the VPN gateway ID created in VPN Module"
}

output "vpn_connection_id" {
  value       = aws_vpn_connection.trinityx_vpn.id
  description = "The ID of the VPN connection ID created in VPN Module"
}

output "vpn_tunnel1_ip" {
  value       = aws_vpn_connection.trinityx_vpn.tunnel1_address
  description = "The VPN Tunnel1 IP Address"
}

output "vpn_tunnel1_preshared_key" {
  value       = nonsensitive(aws_vpn_connection.trinityx_vpn.tunnel1_preshared_key)
  description = "The VPN Tunnel1 Preshared Key"
}

output "vpn_tunnel2_ip" {
  value       = aws_vpn_connection.trinityx_vpn.tunnel2_address
  description = "The VPN Tunnel2 IP Address"
}

output "vpn_tunnel2_preshared_key" {
  value       = nonsensitive(aws_vpn_connection.trinityx_vpn.tunnel2_preshared_key)
  description = "The VPN Tunnel2 Preshared Key"
}

output "vpn_connection_configuration_detail" {
  value       = nonsensitive(aws_vpn_connection.trinityx_vpn.customer_gateway_configuration)
  description = "The VPN configuration details in XML"
}


