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
# File: aws/modules/network/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-06
# Description: Terraform module for creating VPC in AWS, including the Public
#              Subnet, Internet Gateway, Route Table, Route Table Association,
#              Network ACL, Network ACL Association, and Security Group with
#              inbound and outbound rules.
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
# VPC
# This block will create the VPC for the TrinityX.
# ------------------------------------------------------------------------------
resource "aws_vpc" "trinityx" {
  cidr_block       = var.aws_vpc_cidr_block
  instance_tenancy = var.aws_vpc_instance_tenancy

  tags = {
    Name = var.aws_vpc_name
  }

  enable_dns_support   = var.aws_vpc_enable_dns_support
  enable_dns_hostnames = var.aws_vpc_enable_dns_hostnames
}

# ------------------------------------------------------------------------------
# Public Subnet
# This block will create the public subnet on the VPC for TrinityX.
# ------------------------------------------------------------------------------
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.trinityx.id
  cidr_block        = var.aws_vpc_subnet_cidr_block
  availability_zone = var.aws_availability_zone

  tags = {
    Name = var.aws_vpc_subnet_name
  }
}

# ------------------------------------------------------------------------------
# Internet Gateway
# This block will create the internet gateway on the VPC for TrinityX.
# ------------------------------------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.trinityx.id

  tags = {
    Name = var.aws_vpc_internet_gateway_name
  }
}

# ------------------------------------------------------------------------------
# Route Table
# This block will create the route table for public subnet for TrinityX VPC.
# ------------------------------------------------------------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.trinityx.id

  route {
    cidr_block = var.aws_route_table_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.aws_route_table_name
  }
}

# ------------------------------------------------------------------------------
# Route Table Association
# This block will associate route table to the public subnet for TrinityX VPC.
# ------------------------------------------------------------------------------
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# ------------------------------------------------------------------------------
# Network ACL
# This block will create network access control list for the TrinityX VPC.
# ------------------------------------------------------------------------------
resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.trinityx.id

  dynamic "egress" {
    for_each = [for rule in var.aws_network_acl_rules : rule if rule.direction == "egress"]
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  dynamic "ingress" {
    for_each = [for rule in var.aws_network_acl_rules : rule if rule.direction == "ingress"]
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  tags = {
    Name = var.aws_network_acl_name
  }
}

# ------------------------------------------------------------------------------
# Network ACL Association
# This block will associate network access control list with public subnet for TrinityX VPC.
# ------------------------------------------------------------------------------
resource "aws_network_acl_association" "public_nacl_assoc" {
  subnet_id     = aws_subnet.public_subnet.id
  network_acl_id = aws_network_acl.public_nacl.id
}

# ------------------------------------------------------------------------------
# Security Group
# This block will create security group and with inbound and outbound rules for the TrinityX VPC.
# ------------------------------------------------------------------------------
resource "aws_security_group" "vpn_sg" {
  vpc_id = aws_vpc.trinityx.id
  dynamic "egress" {
    for_each = [for rule in var.aws_security_group_rules : rule if rule.direction == "egress"]
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }

  dynamic "ingress" {
    for_each = [for rule in var.aws_security_group_rules : rule if rule.direction == "ingress"]
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  tags = {
    Name = var.aws_security_group_name
  }
}






