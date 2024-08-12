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
variable "aws_network" {
  description = "The AWS Network(VPC)."
  type        = bool
  default     = false
}

variable "aws_vpn" {
  description = "The AWS VPN."
  type        = bool
  default     = false
}

variable "aws_storage" {
  description = "The AWS Storage S3."
  type        = bool
  default     = false
}

variable "aws_image" {
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
  # sensitive   = true
  default     = ""

  validation {
    condition     = length(var.secret_key) == 40
    error_message = "The AWS Secret Key must be a valid Secret Key"
  }
}

# AWS Cloud Credentials
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# AWS VPC
variable "aws_vpc_name" {
  description = "The AWS Network(VPC)."
  type        = string
  default     = ""
}

variable "aws_vpc_cidr_block" {
  description = "The AWS VPN."
  type        = string
  default     = ""
}

variable "aws_vpc_instance_tenancy" {
  description = "The AWS OS Image (VHD)."
  type        = string
  default     = ""
}

variable "aws_vpc_enable_dns_support" {
  description = "The AWS Controller."
  type        = bool
  default     = false
}

variable "aws_vpc_enable_dns_hostnames" {
  description = "The AWS Node"
  type        = bool
  default     = false
}

variable "aws_vpc_subnet_name" {
  description = "The AWS VPC Subnet Name."
  type        = string
  default     = ""
}

variable "aws_vpc_subnet_cidr_block" {
  description = "The AWS VPC Subnet CIDR Block."
  type        = string
  default     = ""
}

variable "aws_vpc_internet_gateway_name" {
  description = "The AWS VPC Internet Gateway Name."
  type        = string
  default     = ""
}

variable "aws_route_table_cidr_block" {
  description = "The AWS Route Table CIDR Block."
  type        = string
  default     = ""
}

variable "aws_route_table_name" {
  description = "The AWS Route Table Name."
  type        = string
  default     = ""
}

variable "aws_network_acl_name" {
  description = "The AWS Network Access Control List Name."
  type        = string
  default     = ""
}

variable "aws_network_acl_rules" {
  description = "List of ports to allow"
  type = list(object({
    direction   = string
    protocol    = string
    rule_no     = number
    action      = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
  default = [
    {
      direction  = "egress"
      protocol   = "udp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 500
      to_port    = 500
    },
    {
      direction  = "egress"
      protocol   = "udp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 4500
      to_port    = 4500
    },
    {
      direction  = "ingress"
      protocol   = "udp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 500
      to_port    = 500
    },
    {
      direction  = "ingress"
      protocol   = "udp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 4500
      to_port    = 4500
    }
  ]
}

variable "aws_security_group_name" {
  description = "The AWS security group name."
  type        = string
  default     = ""
}

variable "aws_security_group_rules" {
  description = "List of ports to allow"
  type = list(object({
    direction   = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
    
  }))
  default = [
    {
      direction   = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    },
    {
      direction   = "ingress"
      from_port   = 500
      to_port     = 500
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow inbound VPN traffic"
    },
    {
      direction   = "ingress"
      from_port   = 4500
      to_port     = 4500
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow inbound VPN traffic"
    },
    {
      direction   = "egress"
      from_port   = 500
      to_port     = 500
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow outbound VPN traffic"
    },
    {
      direction   = "egress"
      from_port   = 4500
      to_port     = 4500
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow outbound VPN traffic"
    },
    {
      direction   = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH"
    },
    {
      direction   = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP"
    },
    {
      direction   = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS"
    },
    {
      direction   = "ingress"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow OOD 8080"
    },
    {
      direction   = "ingress"
      from_port   = 7050
      to_port     = 7050
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow TrinityX 7050"
    },
    {
      direction   = "ingress"
      from_port   = 7051
      to_port     = 7051
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow TrinityX 7051"
    }
  ]
}
# AWS VPC
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# AWS VPN
variable "aws_customer_gateway_name" {
  description = "The AWS customer gateway name."
  type        = string
  default     = ""
}

variable "aws_customer_gateway_bgp_asn" {
  description = "The AWS customer gateway Border Gateway Protocol Autonomous System Numbe ."
  type        = number
  default     = 65000
}

variable "aws_customer_gateway_ip_address" {
  description = "The AWS customer gateway internet-routable IP."
  type        = string
  default     = ""
}

variable "aws_customer_gateway_type" {
  description = "The AWS customer gateway type."
  type        = string
  default     = ""
}

variable "aws_vpn_gateway_name" {
  description = "The AWS VPN gateway name."
  type        = string
  default     = ""
}

variable "aws_vpn_name" {
  description = "The AWS VPN name."
  type        = string
  default     = ""
}

variable "aws_vpn_connection_type" {
  description = "The AWS VPN connection type name."
  type        = string
  default     = ""
}

variable "aws_vpn_static_routes_only" {
  description = "The AWS VPN static route only flag."
  type        = bool
  default     = true
}

variable "aws_vpn_local_ipv4_network_cidr" {
  description = "The AWS VPN local IPv4 CIDR."
  type        = string
  default     = ""
}

variable "aws_vpn_remote_ipv4_network_cidr" {
  description = "The AWS VPN remote IPv4 CIDR."
  type        = string
  default     = ""
}

variable "aws_vpn_connection_route_cidr_block" {
  description = "The AWS VPN connection route destination CIDR block."
  type        = string
  default     = ""
}

# AWS VPN
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# AWS S3
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
# AWS S3
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# AWS Image
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

variable "aws_image_containe_desc" {
  description = "The AWS AMI image container description."
  type        = string
  default     = ""
}
# AWS Image
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# AWS Controller
# ------------------------------------------------------------------------------ #
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

variable "aws_controller_ip" {
  description = "The AWS controller IP address."
  type        = string
  default     = ""
}

variable "aws_controller_eip_domain" {
  description = "The AWS controller elastic IP domain."
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

# ------------------------------------------------------------------------------ #
# AWS Node
variable "aws_hostlist" {
  description = "List of AWS nodes in the format aws[001-004]"
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
# ------------------------------------------------------------------------------ #

# ------------------------------------------------------------------------------ #
# AWS Import Variables
variable "ami_id" {
  description = "The AWS AMI ID from the Import."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The AWS VPC ID from the Import."
  type        = string
  default     = ""
}

variable "public_subnet_id" {
  description = "The AWS Public Subnet ID from the Import."
  type        = string
  default     = ""
}

variable "sg_id" {
  description = "The AWS Security Group ID from the Import."
  type        = string
  default     = ""
}

# AWS Import Variables
# ------------------------------------------------------------------------------ #
