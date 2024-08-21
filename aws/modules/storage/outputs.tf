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
# File: aws/modules/storage/outputs.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-08
# Description: Terraform storage Module Outputs file, will be output some of
#              important information, will be used further.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This output file outputs the storage(S3) related information.
# ------------------------------------------------------------------------------

output "bucket_name" {
  value       = aws_s3_bucket.trinityx_bucket.bucket
  description = "The AWS S3 Bucket Name for the TrinityX."
}

output "bucket_arn" {
  value       = aws_s3_bucket.trinityx_bucket.arn
  description = "The AWS S3 Bucket ARN for the TrinityX."
}







