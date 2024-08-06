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
# Description: Main Terraform configuration file for setting up AWS resources,
#              including every single resource needed for TrinityX.
# Version: 1.0.0
# Status: Development
# License: GPL
# ------------------------------------------------------------------------------
# Notes:
# - This configuration sets up the core infrastructure for the TrinityX.
# - Ensure that the variables are correctly set in the variables.tf file.
# - This file should be reviewed and updated regularly to reflect any changes.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Fetch the first availability zone
# This block will retrive the first availability zone for TrinityX Installation.
# ------------------------------------------------------------------------------
data "aws_availability_zones" "available" {}

# ------------------------------------------------------------------------------
# Network Module
# This module sets up the network infrastructure, including VPC, public subnet,
# internet gateway, routing table, network access control list and security group.
# ------------------------------------------------------------------------------
# module "network" {
#   count                 = var.aws_network ? 1 : 0
#   source                = "./modules/network"
#   aws_availability_zone = data.aws_availability_zones.available.names[0]

#   aws_vpc_name                    = var.aws_vpc_name
#   aws_vpc_cidr_block              = var.aws_vpc_cidr_block
#   aws_vpc_instance_tenancy        = var.aws_vpc_instance_tenancy
#   aws_vpc_enable_dns_support      = var.aws_vpc_enable_dns_support
#   aws_vpc_enable_dns_hostnames    = var.aws_vpc_enable_dns_hostnames

#   aws_vpc_subnet_name             = var.aws_vpc_subnet_name
#   aws_vpc_subnet_cidr_block       = var.aws_vpc_subnet_cidr_block
#   aws_vpc_internet_gateway_name   = var.aws_vpc_internet_gateway_name

#   aws_route_table_cidr_block  = var.aws_route_table_cidr_block
#   aws_route_table_name        = var.aws_route_table_name

#   aws_network_acl_name  = var.aws_network_acl_name
#   aws_network_acl_rules = var.aws_network_acl_rules

#   aws_security_group_name   = var.aws_security_group_name
#   aws_security_group_rules  = var.aws_security_group_rules
# }


# ------------------------------------------------------------------------------
# VPN Module
# This module sets up the VPN for on premises infrastructure inlcuding customer
# gateway, vpn gateway, vpn gateway attachment to VPC, site-to-site vpn tunnel,
# and connection routes.
# ------------------------------------------------------------------------------
# module "vpn" {
#   count   = var.aws_vpn ? 1 : 0
#   source  = "./modules/vpn"
#   vpc_id  = module.network[0].vpc_id
  
#   aws_customer_gateway_name       = var.aws_customer_gateway_name
#   aws_customer_gateway_bgp_asn    = var.aws_customer_gateway_bgp_asn
#   aws_customer_gateway_ip_address = var.aws_customer_gateway_ip_address
#   aws_customer_gateway_type       = var.aws_customer_gateway_type

#   aws_vpn_gateway_name  = var.aws_vpn_gateway_name

#   aws_vpn_name                      = var.aws_vpn_name
#   aws_vpn_connection_type           = var.aws_vpn_connection_type
#   aws_vpn_static_routes_only        = var.aws_vpn_static_routes_only
#   aws_vpn_local_ipv4_network_cidr   = var.aws_vpn_local_ipv4_network_cidr
#   aws_vpn_remote_ipv4_network_cidr  = var.aws_vpn_remote_ipv4_network_cidr

#   aws_vpn_connection_route_cidr_block = var.aws_vpn_connection_route_cidr_block
# }


###########----------------------------------------------------------------------------------------------------------------------------------
### aws_storage solution which will create a S3 bucket with versioning and blocked public access & upload the VHD to there


# variable "aws_s3_bucket_prefix" {
#   description = "The name prefix for the AWS S3 bucket."
#   type        = string
#   default     = "trinityx"
# }

# resource "aws_s3_bucket" "trinityx_bucket" {
#   bucket_prefix = var.aws_s3_bucket_prefix
#   force_destroy = true 

#   tags = {
#     Name        = "TrinityX Bucket"
#     Environment = "Dev"
#   }
# }

# resource "aws_s3_bucket_versioning" "trinityx_versioning" {
#   bucket = aws_s3_bucket.trinityx_bucket.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "trinityx_encryption" {
#   bucket = aws_s3_bucket.trinityx_bucket.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#     bucket_key_enabled = true
#   }
# }

# resource "aws_s3_bucket_public_access_block" "trinityx_public_access_block" {
#   bucket                  = aws_s3_bucket.trinityx_bucket.id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_object" "compute_image" {
#   bucket = aws_s3_bucket.trinityx_bucket.bucket
#   key    = "images/compute.img"  # Key (path) in the bucket where the file will be stored
#   source = "/trinity/images/compute.img"  # Local path to the file

#   # Optionally specify content type
#   content_type = "application/octet-stream"

#   # To enable server-side encryption with AWS S3 managed keys (SSE-S3)
#   server_side_encryption = "AES256"
# }

# output "object_url" {
#   value = "s3://${aws_s3_bucket.trinityx_bucket.bucket}/${aws_s3_object.compute_image.key}"
# }

# output "bucket_name" {
#   value = aws_s3_bucket.trinityx_bucket.bucket
# }

# output "bucket_arn" {
#   value = aws_s3_bucket.trinityx_bucket.arn
# }


# # bucket_arn = "arn:aws:s3:::trinityx20240806123217760800000001"
# # bucket_name = "trinityx20240806123217760800000001"
# # object_url = "s3://trinityx20240806123217760800000001/images/compute.img"


###########----------------------------------------------------------------------------------------------------------------------------------
### aws_image solution which will create a S3 bucket with versioning and blocked public access & upload the VHD to there

# Define the IAM role with the trust relationship
resource "aws_iam_role" "vmimport" {
  name = "vmimport2"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "vmie.amazonaws.com"
        },
        "Action": "sts:AssumeRole",
        "Condition": {
          "StringEquals": {
            "sts:ExternalId": "vmimport"
          }
        }
      }
    ]
  })
}

# Attach AmazonEC2FullAccess policy to the role
resource "aws_iam_role_policy_attachment" "ec2_full_access" {
  role       = aws_iam_role.vmimport.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# Attach AmazonEC2RoleforSSM policy to the role
resource "aws_iam_role_policy_attachment" "ec2_role_for_ssm" {
  role       = aws_iam_role.vmimport.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

# Attach AmazonS3FullAccess policy to the role
resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.vmimport.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Attach AmazonS3ReadOnlyAccess policy to the role
resource "aws_iam_role_policy_attachment" "s3_read_only_access" {
  role       = aws_iam_role.vmimport.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "null_resource" "import_image" {
  provisioner "local-exec" {
    command = "python3 ../scripts/import_image.py ${var.aws_region} ${var.access_key} ${var.secret_key}"
  }

  depends_on = [
    aws_iam_role.vmimport,
    aws_iam_role_policy_attachment.ec2_full_access,
    aws_iam_role_policy_attachment.ec2_role_for_ssm,
    aws_iam_role_policy_attachment.s3_full_access,
    aws_iam_role_policy_attachment.s3_read_only_access
  ]
}

resource "null_resource" "import_image_status" {
  provisioner "local-exec" {
    command = <<EOT
      python3 import_image.py ${var.aws_region} ${var.access_key} ${var.secret_key}
    EOT
    environment = {
      AWS_REGION = var.aws_region
      AWS_ACCESS_KEY_ID = var.access_key
      AWS_SECRET_ACCESS_KEY = var.secret_key
    }
  }

  depends_on = [
    null_resource.import_image
  ]
}


# aws ec2 import-image --license-type BYOL --disk-containers Format=vhd,Url=S3://trinityx-poc/trinity.vhd,Description=Rocky9 --boot-mode uefi --description "TrinityX-Compute" --platform Linux --role-name vmimport
# ```
# output=$(aws ec2 import-image --license-type BYOL --disk-containers Format=vhd,Url=S3://trinityx-poc/trinity.vhd,Description=Rocky9 --boot-mode uefi --description "TrinityX-Compute" --platform Linux --role-name vmimport)
# echo $output

# # Extract the ImportTaskId from the output
# import_task_id=$(echo $output | jq -r '.ImportTaskId')
# echo $import_task_id

# # Check if the ImportTaskId was successfully extracted
# if [ -z "$import_task_id" ]; then
#     echo "Failed to extract ImportTaskId."
#     exit 1
# fi

# # Loop to describe the import image tasks
# for i in {1..1000}; do
#     echo ""
#     echo "++++++++++++++++++++++++++++++++++++++++++++                    $i              +++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
#     echo ""
#     aws ec2 describe-import-image-tasks --import-task-ids $import_task_id --output table
#     echo ""
#     echo ""
#     sleep 10
# done

# ```
