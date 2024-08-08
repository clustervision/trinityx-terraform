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
# File: aws/modules/storage/variables.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-08
# Description: Terraform Variables file for the Storage module for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - Define all the input variables required by the storage module.
# - Update the default values as needed to match the target environment.
# - Ensure sensitive variables are handled securely.
# ------------------------------------------------------------------------------

variable "aws_s3_bucket_prefix" {
  description = "The name prefix for the AWS S3 bucket."
  type        = string
  default     = ""
}

variable "aws_s3_force_destroy" {
  description = "The AWS S3 bucket force destroy."
  type        = bool
  default     = false
}

variable "aws_s3_bucket_name_tag" {
  description = "The AWS S3 bucket name tag."
  type        = string
  default     = ""
}

variable "aws_s3_bucket_env" {
  description = "TheAWS S3 bucket environment."
  type        = string
  default     = ""
}

variable "aws_s3_bucket_versioning" {
  description = "The AWS S3 bucket Versioning."
  type        = string
  default     = ""
}

variable "aws_s3_bucket_enc_algorithm" {
  description = "The AWS S3 bucket encryption algorithm."
  type        = string
  default     = ""
}

variable "aws_s3_bucket_key" {
  description = "The AWS S3 bucket ey enablement."
  type        = bool
  default     = false
}

variable "aws_s3_block_public_acls" {
  description = "The AWS S3 bucket block public ACL."
  type        = bool
  default     = false
}

variable "aws_s3_block_public_policy" {
  description = "The AWS S3 bucket bloc public policy."
  type        = bool
  default     = false
}

variable "aws_s3_ignore_public_acls" {
  description = "The AWS S3 bucket ignore public ACL."
  type        = bool
  default     = false
}

variable "aws_s3_restrict_public_buckets" {
  description = "The AWS S3 bucket restrict public buckets."
  type        = bool
  default     = false
}
