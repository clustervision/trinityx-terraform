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
# Description: Variables file for the main Terraform configuration for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - Define all the input variables required by the main configuration and modules.
# - Update the default values as needed to match the target environment.
# - Ensure sensitive variables are handled securely.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ #
# AWS Cloud Modules

variable "aws_vpn" {
  description = "The AWS VPN."
  type        = bool
  default     = false
}

variable "aws_ami" {
  description = "The AWS OS Image (VHD)."
  type        = bool
  default     = false
}

variable "aws_controller" {
  description = "The AWS Controller."
  type        = bool
  default     = false
}

variable "aws_node" {
  description = "The AWS Node"
  type        = bool
  default     = false
}

# AWS Cloud Modules
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# AWS Cloud Credentials
variable "aws_region" {
  description = "The AWS Region for the Installation"
  type        = string
  default     = "eu-central-1"

  validation {
    condition     = length(var.aws_region) >= 9
    error_message = "The AWS Region must be a valid Region."
  }
}

variable "access_key" {
  description = "The AWS Access Key"
  type        = string
  default     = ""

  validation {
    condition     = length(var.access_key) == 20
    error_message = "The AWS Access Key must be a valid Access Key"
  }
}

variable "secret_key" {
  description = "The AWS Secret Key"
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = length(var.secret_key) == 40
    error_message = "The AWS Secret Key must be a valid Secret Key"
  }
}

# AWS Cloud Credentials
# ------------------------------------------------------------------------------ #

