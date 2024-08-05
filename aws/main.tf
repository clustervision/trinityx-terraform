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
# Network Detail
# This block will get all the network details for TrinityX.
# ------------------------------------------------------------------------------
# Data source to get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Output the default VPC details
output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "default_vpc_cidr_block" {
  value = data.aws_vpc.default.cidr_block
}

output "default_vpc_tags" {
  value = data.aws_vpc.default.tags
}

output "default_vpc_dhcp_options_id" {
  value = data.aws_vpc.default.dhcp_options_id
}

output "default_vpc_dhcp_options_all" {
  value = data.aws_vpc.default
}

