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
# File: aws/modules/controller/variables.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-09
# Description: Terraform Variables file for the controller module for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - Define all the input variables required by the controller module.
# - Update the default values as needed to match the target environment.
# - Ensure sensitive variables are handled securely.
# ------------------------------------------------------------------------------

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

variable "aws_controller_ami_latest" {
  description = "The AWS AMI most recent flag."
  type        = bool
  default     = false
}

variable "aws_controller_ami_filter_by" {
  description = "The AWS AMI filter by."
  type        = string
  default     = ""
}

variable "aws_controller_ami_filter_values" {
  description = "The AWS AMI filter values."
  type        = string
  default     = ""
}

variable "aws_controller_ami_owners" {
  description = "The AWS AMI owners."
  type        = list(string)
  default     = []
}

variable "aws_controller_instance_type" {
  description = "The AWS controller instance type."
  type        = string
  default     = ""
}

variable "aws_controller_automatic_public_ip" {
  description = "The AWS controller automatic association of public IP."
  type        = bool
  default     = false
}

variable "aws_controller_root_device_size" {
  description = "The AWS controller root block device size in GB."
  type        = number
  default     = 0
}

variable "aws_controller_root_device_type" {
  description = "The AWS controller root block device type(HDD, SSD, or Magnetic)."
  type        = string
  default     = ""
}

variable "aws_controller_name" {
  description = "The AWS controller name tag."
  type        = string
  default     = ""
}

variable "aws_controller_eip_domain" {
  description = "The AWS controller elastic IP domain."
  type        = string
  default     = ""
}

variable "aws_controller_ip" {
  description = "The AWS controller IP address."
  type        = string
  default     = ""
}

variable "aws_controller_ssh_public_key" {
  description = "The public SSH key for AWS controller."
  type        = string
  default     = ""
}

variable "aws_controller_os_username" {
  description = "The AWS controller username."
  type        = string
  default     = ""
}

variable "aws_controller_os_password" {
  description = "The AWS controller password."
  type        = string
  default     = ""
}









