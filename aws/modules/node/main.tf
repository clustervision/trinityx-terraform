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
# File: aws/modules/node/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-09
# Description: Terraform module for creating EC2 Instances for nodes in AWS.
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
# AWS Node
# This block will collect the Account ID for the Next query.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}

# ------------------------------------------------------------------------------
# Get AMI
# This block will fetch the latest uploaded AMI ID by Terraform.
# ------------------------------------------------------------------------------
data "aws_ami" "node_ami" {
  most_recent = true

  owners = [data.aws_caller_identity.current.account_id]
}

# ------------------------------------------------------------------------------
# AWS Node
# This block will create EC2 Instances for the TrinityX nodes, depending on the
# provided hostlist.
# ------------------------------------------------------------------------------
resource "aws_instance" "node" {
  for_each      = toset(var.hostnames)
  ami           = data.aws_ami.node_ami.id
  instance_type = var.aws_node_instance_type
  subnet_id     = var.public_subnet_id

  associate_public_ip_address = var.aws_node_automatic_public_ip
  vpc_security_group_ids      = [var.sg_id]

  root_block_device {
    volume_size = var.aws_node_root_device_size
    volume_type = var.aws_node_root_device_type
  }

  tags = {
    Name = each.key
  }
}
