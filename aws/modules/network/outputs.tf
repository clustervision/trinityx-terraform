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
# File: aws/modules/network/outputs.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-06
# Description: Terraform Network Module Outputs file, will be output some of
#              important information, will be used further.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This output file outputs the network related information.
# ------------------------------------------------------------------------------

output "vpc_id" {
  value = aws_vpc.trinityx.id
  description = "The ID of the VPC created in the network module"
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
  description = "The ID of the public subnet created in the network module"
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
  description = "The ID of the internet gateway created in the network module"
}

output "route_table_id" {
  value = aws_route_table.public_rt.id
  description = "The ID of the routing table created in the network module"
}

output "sg_id" {
  value = aws_security_group.vpn_sg.id
  description = "The ID of the security group created in the network module"
}


