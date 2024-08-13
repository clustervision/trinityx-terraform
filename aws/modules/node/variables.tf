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
# File: aws/modules/node/variables.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-09
# Description: Terraform Variables file for the node module for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - Define all the input variables required by the node module.
# - Update the default values as needed to match the target environment.
# - Ensure sensitive variables are handled securely.
# ------------------------------------------------------------------------------

variable "hostnames" {
  description = "The ID of the subnet to place the VM in"
  type        = list
  default     = []
}

variable "vpc_id" {
  description = "The AWS VPC ID."
  type        = string
  default     = ""
}

variable "public_subnet_id" {
  description = "The AWS Public Subnet ID for the VPC."
  type        = string
  default     = ""
}

variable "sg_id" {
  description = "The AWS Security Group ID of the VPC."
  type        = string
  default     = ""
}

variable "aws_node_instance_type" {
  description = "The AWS Node instance type."
  type        = string
  default     = ""
}

variable "aws_node_automatic_public_ip" {
  description = "The AWS node automatic association of public IP."
  type        = bool
  default     = false
}

variable "aws_node_root_device_size" {
  description = "The AWS node root block device size in GB."
  type        = number
  default     = 0
}

variable "aws_node_root_device_type" {
  description = "The AWS node root block device type(HDD, SSD, or Magnetic)."
  type        = string
  default     = ""
}








