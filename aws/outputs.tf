# # ------------------------------------------------------------------------------
# # This code is part of the TrinityX software suite
# # Copyright (C) 2023  ClusterVision Solutions b.v.
# #
# # This program is free software: you can redistribute it and/or modify
# # it under the terms of the GNU General Public License as published by
# # the Free Software Foundation, either version 3 of the License, or
# # (at your option) any later version.
# #
# # This program is distributed in the hope that it will be useful,
# # but WITHOUT ANY WARRANTY; without even the implied warranty of
# # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# # GNU General Public License for more details.
# #
# # You should have received a copy of the GNU General Public License
# # along with this program.  If not, see <https://www.gnu.org/licenses/>
# # ------------------------------------------------------------------------------

# # ------------------------------------------------------------------------------
# # File: aws/outputs.tf
# # Author: Sumit Sharma
# # E-Mail: sumit.sharma@clustervision.com
# # Date: 2024-08-05
# # Description: Main output file for the AWS Terraform configuration for TrinityX.
# # Version: 1.0.0
# # Status: Development
# # License: GPL
# # ------------------------------------------------------------------------------
# # Notes:
# # - This file has all the output blocks.
# # - Can add/remove the output block, if you are using it seprately.
# # ------------------------------------------------------------------------------

# # ------------------------------------------------------------------------------
# # Output from Network Module
# output "vpc_id" {
#   value = var.aws_network ? module.network[0].vpc_id : null
#   description = "The ID of the VPC created in the network module"
# }

# output "public_subnet_id" {
#   value = var.aws_network ? module.network[0].public_subnet_id : null
#   description = "The ID of the public subnet created in the network module"
# }

# output "internet_gateway_id" {
#   value = var.aws_network ? module.network[0].internet_gateway_id : null
#   description = "The ID of the internet gateway created in the network module"
# }

# output "route_table_id" {
#   value = var.aws_network ? module.network[0].route_table_id : null
#   description = "The ID of the routing table created in the network module"
# }

# output "sg_id" {
#   value = var.aws_network ? module.network[0].sg_id : null
#   description = "The ID of the security group created in the network module"
# }
# # Output from Network Module
# # ------------------------------------------------------------------------------

# # ------------------------------------------------------------------------------
# # Output from VPN Module
# output "ipinfo" {
#   value       = var.aws_vpn ? module.vpn[0].ipinfo : null
#   description = "The Public IP Address for the installation Machine."
# }

# output "customer_gateway_id" {
#   value       = var.aws_vpn ? module.vpn[0].customer_gateway_id : null
#   description = "The ID of the customer gateway created in VPN Module"
# }

# output "vpn_gateway_id" {
#   value       = var.aws_vpn ? module.vpn[0].vpn_gateway_id : null
#   description = "The ID of the VPN gateway ID created in VPN Module"
# }

# output "vpn_connection_id" {
#   value       = var.aws_vpn ? module.vpn[0].vpn_connection_id : null
#   description = "The ID of the VPN connection ID created in VPN Module"
# }

# output "vpn_tunnel1_ip" {
#   value       = var.aws_vpn ? module.vpn[0].vpn_tunnel1_ip : null
#   description = "The VPN Tunnel1 IP Address"
# }

# output "vpn_tunnel1_preshared_key" {
#   value       = var.aws_vpn ? module.vpn[0].vpn_tunnel1_preshared_key : null
#   description = "The VPN Tunnel1 Preshared Key"
# }

# output "vpn_tunnel2_ip" {
#   value       = var.aws_vpn ? module.vpn[0].vpn_tunnel2_ip : null
#   description = "The VPN Tunnel2 IP Address"
# }

# output "vpn_tunnel2_preshared_key" {
#   value       = var.aws_vpn ? module.vpn[0].vpn_tunnel2_preshared_key : null
#   description = "The VPN Tunnel2 Preshared Key"
# }

# output "vpn_connection_configuration_detail" {
#   value       = var.aws_vpn ? module.vpn[0].vpn_connection_configuration_detail : null
#   description = "The VPN configuration details"
# }
# # Output from VPN Module
# # ------------------------------------------------------------------------------
