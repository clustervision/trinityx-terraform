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
# File: aws/modules/image/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-08
# Description: Terraform module for creating AMI in AWS including upload the VHD
#              to the S3 Bucket, define the IAM role with the trust relationship,
#              policies attachment of AmazonEC2FullAccess, AmazonEC2RoleforSSM,
#              AmazonS3FullAccess, AmazonS3ReadOnlyAccess, import the VHD image
#              as an AMI, status check for AMI process, return the AMI ID, and
#              remove the logs.
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
# Upload S3 Object
# This block will upload the VHD to the S3 Bucket.
# ------------------------------------------------------------------------------
resource "aws_s3_object" "compute_image" {
  bucket = var.bucket_name
  key    = var.aws_s3_object_key_path
  source = var.aws_s3_object_source
  content_type = var.aws_s3_object_content_type
  server_side_encryption = var.aws_s3_object_encryption
}

# ------------------------------------------------------------------------------
# IAM Role
# This block will define the IAM role with the trust relationship.
# ------------------------------------------------------------------------------
resource "aws_iam_role" "vmimport" {
  name = var.aws_iam_role_name

  assume_role_policy = jsonencode({
    "Version": var.aws_iam_role_policy_version,
    "Statement": [
      {
        "Effect": var.aws_iam_role_policy_effect,
        "Principal": {
          "Service": var.aws_iam_role_policy_service
        },
        "Action": var.aws_iam_role_policy_action,
        "Condition": {
          "StringEquals": {
            "sts:ExternalId": "vmimport" # predefined value required by AWS
          }
        }
      }
    ]
  })
}

# ------------------------------------------------------------------------------
# IAM Role policy AmazonEC2FullAccess
# This block will attach AmazonEC2FullAccess policy to the role.
# ------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "ec2_full_access" {
  role       = aws_iam_role.vmimport.name
  policy_arn = var.aws_iam_role_policy_ec2_access
}

# ------------------------------------------------------------------------------
# IAM Role policy AmazonEC2RoleforSSM
# This block will attach AmazonEC2RoleforSSM policy to the role.
# ------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "ec2_role_for_ssm" {
  role       = aws_iam_role.vmimport.name
  policy_arn = var.aws_iam_role_policy_ec2_role
}

# ------------------------------------------------------------------------------
# IAM Role policy AmazonS3FullAccess
# This block will attach AmazonS3FullAccess policy to the role.
# ------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.vmimport.name
  policy_arn = var.aws_iam_role_policy_s3_access
}

# ------------------------------------------------------------------------------
# IAM Role policy AmazonS3ReadOnlyAccess
# This block will attach AmazonS3ReadOnlyAccess policy to the role.
# ------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "s3_read_only_access" {
  role       = aws_iam_role.vmimport.name
  policy_arn = var.aws_iam_role_policy_s3_read
}

# ------------------------------------------------------------------------------
# Import Image
# This block will import the VHD image as an AMI.
# ------------------------------------------------------------------------------
resource "null_resource" "import_image" {
  provisioner "local-exec" {
    command = <<-EOT
      mkdir -p /tmp/.trinityx
      aws ec2 import-image \
        --license-type ${var.aws_image_license_type} \
        --disk-containers Format=${var.aws_image_container_format},Url=S3://${var.bucket_name}/${aws_s3_object.compute_image.key},Description=${var.aws_image_containe_desc} \
        --boot-mode ${var.aws_image_boot_mode} \
        --description ${var.aws_image_description} \
        --platform ${var.aws_image_platform} \
        --role-name ${var.aws_image_role} 2>&1 | tee /tmp/.trinityx/import_task_output.txt | jq -r '.ImportTaskId' > /tmp/.trinityx/import_task_id.txt
    EOT

    environment = {
      AWS_REGION            = var.aws_region
      AWS_ACCESS_KEY_ID     = var.access_key
      AWS_SECRET_ACCESS_KEY = var.secret_key
    }
  }

  depends_on = [
    aws_s3_object.compute_image,
    aws_iam_role.vmimport,
    aws_iam_role_policy_attachment.ec2_full_access,
    aws_iam_role_policy_attachment.ec2_role_for_ssm,
    aws_iam_role_policy_attachment.s3_full_access,
    aws_iam_role_policy_attachment.s3_read_only_access
  ]
}

# ------------------------------------------------------------------------------
# Import Image Status
# This block will check the status of import image process, in-short AMI
# creation status.
# ------------------------------------------------------------------------------
resource "null_resource" "import_image_status" {
  provisioner "local-exec" {
    command = <<-EOT
      task_id=$(cat /tmp/.trinityx/import_task_id.txt)
      status=""
      while [ "$status" != "completed" ] && [ "$status" != "deleted" ]; do
        aws ec2 describe-import-image-tasks --import-task-ids $${task_id} > /tmp/.trinityx/import_task_result.txt
        status=$(jq -r '.ImportImageTasks[0].Status' /tmp/.trinityx/import_task_result.txt)
        status_message=$(jq -r '.ImportImageTasks[0].StatusMessage' /tmp/.trinityx/import_task_result.txt)
        progress=$(jq -r '.ImportImageTasks[0].Progress' /tmp/.trinityx/import_task_result.txt)
        echo "Task ID:        $${task_id}"
        echo "Current Status: $${status}"
        if [ "$status_message" != "null" ]; then
          echo "Status Message: $${status_message}"
        fi
        if [ "$progress" != "null" ]; then
          echo "Progress:       $${progress}%"
        fi
        if [ "$status" == "deleted" ]; then
          echo "Import task failed: $${status_message}"
          break
        fi
        if [ "$status" != "completed" ]; then
          echo "Waiting for the import task to complete..."
          for i in {1..10}; do if [ $i -eq 10 ]; then break; fi; echo "Checking status again in $((10 - i)) seconds..."; sleep 1; done
      fi
      done
      if [ "$status" == "completed" ]; then
        aws ec2 describe-import-image-tasks --import-task-ids $${task_id} --output table
        ami_id=$(jq -r '.ImportImageTasks[0].ImageId' /tmp/.trinityx/import_task_result.txt)
        snapshot_id=$(jq -r '.ImportImageTasks[0].SnapshotDetails[0].SnapshotId' /tmp/.trinityx/import_task_result.txt)
        s3_url=$(jq -r '.ImportImageTasks[0].SnapshotDetails[0].Url' /tmp/.trinityx/import_task_result.txt)
        aws ec2 create-tags --resources $${ami_id} --tags Key=Name,Value=${var.aws_image_description}
        echo $${ami_id} > /tmp/.trinityx/ami_id.txt
        echo "AMI ID: $${ami_id}"
        echo "Snapshot ID: $${snapshot_id}"
        echo "S3 URL: $${s3_url}"
        echo "Import task completed successfully, and AMI ID: $${ami_id}."
      fi
    EOT

    environment = {
      AWS_REGION            = var.aws_region
      AWS_ACCESS_KEY_ID     = var.access_key
      AWS_SECRET_ACCESS_KEY = var.secret_key
    }
  }

  depends_on = [
    aws_s3_object.compute_image,
    null_resource.import_image
  ]
}

# ------------------------------------------------------------------------------
# AMI ID
# This block will return the AMI ID to the Output
# ------------------------------------------------------------------------------
data "local_file" "ami_id" {
  filename = "/tmp/.trinityx/ami_id.txt"

  depends_on = [
    aws_s3_object.compute_image,
    null_resource.import_image,
    null_resource.import_image_status
  ]
}

# ------------------------------------------------------------------------------
# Remove Log
# This block will remove the status log messages from the tmp directory.
# ------------------------------------------------------------------------------
# resource "null_resource" "remove_status_log" {
#   provisioner "local-exec" {
#     command = "rm -rf /tmp/.trinityx"
#   }

#   depends_on = [
#     aws_s3_object.compute_image,
#     null_resource.import_image,
#     null_resource.import_image_status
#   ]
# }




