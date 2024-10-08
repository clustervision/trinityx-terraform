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
# File: aws/modules/node/outputs.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-09
# Description: Terraform node Module Outputs file, will be output some of
#              important information, will be used further.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This output file outputs the node related information.
# ------------------------------------------------------------------------------

output "node_id" {
  description = "The ID of the Node"
  value       = { for k, v in aws_instance.node : k => v.id }
}

output "node_ip" {
  description = "The IP of the Node"
  value       = { for k, v in aws_instance.node : k => v.private_ip }
}

output "node_interface_id" {
  description = "The Interface ID for the Node"
  value       = { for k, v in aws_instance.node : k => v.primary_network_interface_id }
}

output "node_ami_id" {
  description = "The AMI ID."
  value       = data.aws_ami.node_ami.id
}

output "account_id" {
  description = "The Account ID of the Current User."
  value = data.aws_caller_identity.current.account_id
}

output "node_mac_address" {
  description = "The MAC address of the EC2 instance"
  value       = { for k, v in data.aws_network_interface.node_mac : k => v.mac_address }
}







