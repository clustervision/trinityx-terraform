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
    
  }))
  default = [
    {
      direction   = "ingress"
      from_port   = 500
      to_port     = 500
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      direction   = "ingress"
      from_port   = 4500
      to_port     = 4500
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      direction   = "egress"
      from_port   = 500
      to_port     = 500
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      direction   = "egress"
      from_port   = 4500
      to_port     = 4500
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      direction   = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      direction   = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      direction   = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      direction   = "ingress"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      direction   = "ingress"
      from_port   = 7050
      to_port     = 7050
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      direction   = "ingress"
      from_port   = 7051
      to_port     = 7051
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
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

