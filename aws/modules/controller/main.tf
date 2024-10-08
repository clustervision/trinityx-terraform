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
# File: aws/modules/controller/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-08-09
# Description: Terraform module for creating EC2 Instance for TrinityX controller
#              in AWS including fetch the latest AMI ID, get the elastic IP,
#              create the Network interface, attach the Elastic IP to the Network
#              Interface, and create the EC2 Instance for the controller.
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
# Get AMI
# This block will fetch the latest AMI ID depending on the requirements.
# ------------------------------------------------------------------------------
data "aws_ami" "controller_ami_id" {
  most_recent = var.aws_controller_ami_latest

  filter {
    name   = var.aws_controller_ami_filter_by
    values = [var.aws_controller_ami_filter_values]
  }

  owners = var.aws_controller_ami_owners
}

# ------------------------------------------------------------------------------
# AWS Controller Elastic IP
# This block will get the Elastic IP for the AWS Controller.
# ------------------------------------------------------------------------------
resource "aws_eip" "trinityx_eip" {
  domain   = var.aws_controller_eip_domain

  tags = {
    Name = "${var.aws_controller_name}-eip"
  }

}

# ------------------------------------------------------------------------------
# AWS Controller Network Interface
# This block will create the network interface for the AWS Controller.
# ------------------------------------------------------------------------------
resource "aws_network_interface" "trinityx_nic" {
  subnet_id   = var.public_subnet_id
  private_ips = [var.aws_controller_ip]
  security_groups = [var.sg_id]

  tags = {
    Name = "${var.aws_controller_name}-nic"
  }

}

# ------------------------------------------------------------------------------
# Attach Elastic IP
# This block will attach the Elastic IP to the Network Interface of AWS Controller.
# ------------------------------------------------------------------------------
resource "aws_eip_association" "trinityx_eip_association" {
  allocation_id        = aws_eip.trinityx_eip.id
  network_interface_id = aws_network_interface.trinityx_nic.id
}

# ------------------------------------------------------------------------------
# AWS Controller
# This block will create the AWS EC2 Instance for TrinityX Controller and do
# some initial setups.
# ------------------------------------------------------------------------------
resource "aws_instance" "controller" {
  ami           = data.aws_ami.controller_ami_id.id
  instance_type = var.aws_controller_instance_type

  network_interface {
    device_index          = 0
    network_interface_id  = aws_network_interface.trinityx_nic.id
  }

  root_block_device {
    volume_size = var.aws_controller_root_device_size
    volume_type = var.aws_controller_root_device_type
  }

  user_data = <<-EOF
  #!/bin/bash

  # Set root password
  echo "root:${var.aws_controller_os_password}" | chpasswd

  # Enable root login via SSH
  sed -i 's/^#PermitRootLogin[[:space:]]\+.*/PermitRootLogin yes/' /etc/ssh/sshd_config

  # Add public SSH key to root authorized_keys
  echo "${var.aws_controller_ssh_public_key} TrinityX" >> /root/.ssh/authorized_keys

  if [[ "${var.aws_controller_os_username}" != "" && "${var.aws_controller_os_username}" != "root" ]]; then

    # Create the ${var.aws_controller_os_username} user with a home directory
    useradd -m -s /bin/bash ${var.aws_controller_os_username}

    # Set the password for the ${var.aws_controller_os_username} user
    echo "${var.aws_controller_os_username}:${var.aws_controller_os_password}" | chpasswd

    # Enable SSH access for the ${var.aws_controller_os_username} user
    mkdir -p /home/${var.aws_controller_os_username}/.ssh
    chmod 700 /home/${var.aws_controller_os_username}/.ssh
    touch /home/${var.aws_controller_os_username}/.ssh/authorized_keys
    chmod 600 /home/${var.aws_controller_os_username}/.ssh/authorized_keys
    chown -R ${var.aws_controller_os_username}:${var.aws_controller_os_username} /home/${var.aws_controller_os_username}/.ssh

    # Add public SSH key to your user authorized_keys
    echo "${var.aws_controller_ssh_public_key} TrinityX" >> /home/${var.aws_controller_os_username}/.ssh/authorized_keys

    # Grant sudo privileges to ${var.aws_controller_os_username} without a password
    echo "${var.aws_controller_os_username} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
  
  fi

  sed -i 's/^PasswordAuthentication no$/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/50-cloud-init.conf
  systemctl restart sshd

  echo "+--------------------------------------------------------------------------+"
  echo "Resizing the Root Partition"

  DISK="/dev/nvme0n1"
  PARTITION="/dev/nvme0n1p5"
  VG_NAME="rocky"
  LV_NAME="/dev/mapper/rocky-lvroot"
  FILESYSTEM="xfs"

  if [ "$EUID" -ne 0 ]; then
      echo "Please run as root"
      exit 1
  fi

  echo -e "n\n\n\n\n\nt\n\n8e\nw" | fdisk $DISK
  partprobe $DISK
  pvcreate $PARTITION
  vgextend $VG_NAME $PARTITION
  lvextend -l +100%FREE $LV_NAME
  if [ "$FILESYSTEM" == "xfs" ]; then
      xfs_growfs /
  elif [ "$FILESYSTEM" == "ext4" ]; then
      resize2fs $LV_NAME
  else
      echo "Unsupported filesystem type. Please use xfs or ext4."
      exit 1
  fi
  echo "Root partition successfully resized."
  echo "+--------------------------------------------------------------------------+"
  
  echo "+--------------------------------------------------------------------------+"
  echo "Updating the package manager."
  yum makecache
  yum update -y
  echo "Package manager updated."
  echo "+--------------------------------------------------------------------------+"

  EOF

  tags = {
    Name = var.aws_controller_name
  }

  depends_on = [aws_eip_association.trinityx_eip_association]
}



