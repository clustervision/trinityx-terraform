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
# File: aws/modules/storage/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-08
# Description: Terraform module for creating S3 Bucket in AWS including
#              bucket versioning, server side encryption, and public access.
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
# S3 Bucket
# This block will create the S3 Bucket.
# ------------------------------------------------------------------------------
resource "aws_s3_bucket" "trinityx_bucket" {
  bucket_prefix = var.aws_s3_bucket_prefix
  force_destroy = var.aws_s3_force_destroy

  tags = {
    Name        = var.aws_s3_bucket_name_tag
    Environment = var.aws_s3_bucket_env
  }
}

# ------------------------------------------------------------------------------
# S3 Bucket - Versioning
# This block will setup the versioning for the S3 Bucket.
# ------------------------------------------------------------------------------
resource "aws_s3_bucket_versioning" "trinityx_versioning" {
  bucket = aws_s3_bucket.trinityx_bucket.id

  versioning_configuration {
    status = var.aws_s3_bucket_versioning
  }
}

# ------------------------------------------------------------------------------
# S3 Bucket - Encryption
# This block will setup the server side encryption for the S3 Bucket.
# ------------------------------------------------------------------------------
resource "aws_s3_bucket_server_side_encryption_configuration" "trinityx_encryption" {
  bucket = aws_s3_bucket.trinityx_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.aws_s3_bucket_enc_algorithm
    }
    bucket_key_enabled = var.aws_s3_bucket_key
  }
}

# ------------------------------------------------------------------------------
# S3 Bucket - Access
# This block will setup the public access for the S3 Bucket.
# ------------------------------------------------------------------------------
resource "aws_s3_bucket_public_access_block" "trinityx_public_access_block" {
  bucket                  = aws_s3_bucket.trinityx_bucket.id
  block_public_acls       = var.aws_s3_block_public_acls
  block_public_policy     = var.aws_s3_block_public_policy
  ignore_public_acls      = var.aws_s3_ignore_public_acls
  restrict_public_buckets = var.aws_s3_restrict_public_buckets
}

