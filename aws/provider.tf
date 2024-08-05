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
# File: aws/provider.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-05
# Description: Cloud Provider file for the main Terraform configuration for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This file has provider & credentials information.
# ------------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region      = var.aws_region
  access_key  = var.access_key
  secret_key  = var.secret_key
}

# ------------------------------------------------------------------------------
# Make Sure these commands will executed before Installation
# dnf install chrony
# systemctl start chronyd
# systemctl enable chronyd
# systemctl status chronyd
# chronyc makestep
# chronyc tracking

