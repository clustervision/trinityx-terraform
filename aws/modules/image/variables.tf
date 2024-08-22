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
# File: aws/modules/image/variables.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-08
# Description: Terraform Variables file for the image module for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - Define all the input variables required by the image module.
# - Update the default values as needed to match the target environment.
# - Ensure sensitive variables are handled securely.
# ------------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS Region for the Installation"
  type        = string
  default     = ""
}

variable "access_key" {
  description = "The AWS Access Key"
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "The AWS Secret Key"
  type        = string
  default     = ""
}

variable "bucket_name" {
  description = "The AWS S3 Bucket name."
  type        = string
  default     = ""
}

variable "aws_s3_object_key_path" {
  description = "The AWS S3 Object key(remote path)."
  type        = string
  default     = ""
}

variable "aws_s3_object_source" {
  description = "The AWS S3 Object Source(local path)."
  type        = string
  default     = ""
}

variable "aws_s3_object_content_type" {
  description = "The AWS S3 Object content type."
  type        = string
  default     = ""
}

variable "aws_s3_object_encryption" {
  description = "The AWS S3 Object encryption."
  type        = string
  default     = ""
}

variable "aws_iam_role_name" {
  description = "The AWS IAM role name."
  type        = string
  default     = ""
}

variable "aws_iam_role_policy_version" {
  description = "The AWS IAM role policy version."
  type        = string
  default     = ""
}

variable "aws_iam_role_policy_effect" {
  description = "The AWS IAM role policy effect."
  type        = string
  default     = ""
}

variable "aws_iam_role_policy_service" {
  description = "The AWS IAM role policy service."
  type        = string
  default     = ""
}

variable "aws_iam_role_policy_action" {
  description = "The AWS IAM role policy action."
  type        = string
  default     = ""
}

variable "aws_iam_role_policy_ec2_access" {
  description = "The AWS IAM role policy EC2 Access."
  type        = string
  default     = ""
}

variable "aws_iam_role_policy_ec2_role" {
  description = "The AWS IAM role policy EC2 Role for SSM."
  type        = string
  default     = ""
}

variable "aws_iam_role_policy_s3_access" {
  description = "The AWS IAM role policy S3 Access."
  type        = string
  default     = ""
}

variable "aws_iam_role_policy_s3_read" {
  description = "The AWS IAM role policy S3 read-only access."
  type        = string
  default     = ""
}

variable "aws_image_license_type" {
  description = "The AWS AMI image license type."
  type        = string
  default     = ""
}

variable "aws_image_boot_mode" {
  description = "The AWS AMI image boot mode."
  type        = string
  default     = ""
}

variable "aws_image_description" {
  description = "The AWS AMI image description."
  type        = string
  default     = ""
}

variable "aws_image_platform" {
  description = "The AWS AMI image platform."
  type        = string
  default     = ""
}

variable "aws_image_role" {
  description = "The AWS AMI image role for import."
  type        = string
  default     = ""
}

variable "aws_image_container_format" {
  description = "The AWS AMI image container format."
  type        = string
  default     = ""
}

variable "aws_image_container_desc" {
  description = "The AWS AMI image container description."
  type        = string
  default     = ""
}


