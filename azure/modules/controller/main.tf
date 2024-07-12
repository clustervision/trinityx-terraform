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
# File: azure/modules/controller/main.tf
# Author: Sumit Sharma
# E-Mail: sumit.sharma@clustervision.com
# Date: 2024-06-03
# Description: Terraform module for creating Controller network Interface in Azure,
#              And The TrinityX Controller on Azure Cloud.
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
# Marketplace Image Agreement
# This block will accept the Agreement for Azure Marketplace for Controller OS.
# ------------------------------------------------------------------------------
# resource "azurerm_marketplace_agreement" "controller_agr" {
#   publisher = var.azure_controller_os_plan_publisher
#   offer     = var.azure_controller_os_plan_product
#   plan      = var.azure_controller_os_plan
# }

# ------------------------------------------------------------------------------
# SSH Key Generate
# This block will create SSH Key for Authenticate to Controller.
# ------------------------------------------------------------------------------
# resource "tls_private_key" "trinityx" {
#   algorithm = var.azure_trinityx_ssh_key_algorithm
#   rsa_bits  = var.azure_trinityx_ssh_key_rsa_bits
# }

# ------------------------------------------------------------------------------
# SSH Key Store
# This block will store SSH Key in Azure SSH key to AuthenticateController.
# ------------------------------------------------------------------------------
# resource "azurerm_ssh_public_key" "trinityx_key" {
#   name                = var.azure_trinityx_ssh_key_name
#   resource_group_name = var.azure_resource_group.name
#   location            = var.azure_resource_group.location
#   public_key          = tls_private_key.trinityx.public_key_openssh
#   tags                = var.azure_trinityx_ssh_key_tags

# }

# ------------------------------------------------------------------------------
# Virtual Private Network Gateway Public IP Definition
# This block will be used to get an public IP addresss for VPN.
# ------------------------------------------------------------------------------
resource "azurerm_public_ip" "controller_public_ip" {
  name                = var.azure_controller_controller_public_ip
  resource_group_name = var.azure_resource_group.name
  location            = var.azure_resource_group.location
  allocation_method   = var.azure_controller_public_ip_allocation_method
  sku                 = var.azure_controller_public_ip_sku
  zones               = var.azure_controller_public_ip_zones
  tags                = var.azure_controller_public_ip_tags
}

# ------------------------------------------------------------------------------
# Controller Network Interface Definition
# This block will create network interface for the TrinityX Controller.
# ------------------------------------------------------------------------------
resource "azurerm_network_interface" "controller_nic" {
  name                = var.azure_controller_network_interface
  resource_group_name = var.azure_resource_group.name
  location            = var.azure_resource_group.location

  ip_configuration {
    name                          = var.azure_vm_network_ip_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.azure_controller_network_private_ip_allocation
    private_ip_address            = var.azure_controller_private_ip_address
    private_ip_address_version    = var.azure_controller_private_ip_address_version
    public_ip_address_id          = azurerm_public_ip.controller_public_ip.id
  }

}

# ------------------------------------------------------------------------------
# Controller Definition
# This block will create TrinityX Controller in Azure Cloud.
# ------------------------------------------------------------------------------
resource "azurerm_virtual_machine" "controller" {
  name                              = var.azure_controller_name
  resource_group_name               = var.azure_resource_group.name
  location                          = var.azure_resource_group.location
  network_interface_ids             = [azurerm_network_interface.controller_nic.id]
  vm_size                           = var.azure_controller_size
  delete_os_disk_on_termination     = var.azure_controller_delete_os_disk
  delete_data_disks_on_termination  = var.azure_controller_delete_data_disk

  storage_image_reference {
    publisher = var.azure_controller_image_publisher
    offer     = var.azure_controller_image_offer
    sku       = var.azure_controller_image_sku
    version   = var.azure_controller_image_version
  }

  storage_os_disk {
    name              = "${var.azure_controller_name}-osdisk"
    caching           = var.azure_controller_os_caching
    create_option     = var.azure_controller_os_create
    managed_disk_type = var.azure_controller_os_disk_type
    disk_size_gb      = 64
  }

  plan {
    name      = var.azure_controller_os_plan
    publisher = var.azure_controller_os_plan_publisher
    product   = var.azure_controller_os_plan_product
  }


  os_profile {
    computer_name  = var.azure_controller_name
    admin_username = var.azure_controller_os_username
    admin_password = var.azure_controller_os_password
  }
  
  os_profile_linux_config {
    disable_password_authentication = var.azure_controller_disable_auth
    # ssh_keys {
    #   key_data  = tls_private_key.trinityx.public_key_openssh
    #   path      = "/home/${var.azure_controller_os_username}/.ssh/authorized_keys"
    # }
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = "https://${var.storage_name}.blob.core.windows.net/"
  }

  provisioner "file" {
    source      = "scripts/controller-post-install.sh"
    destination = "/home/${var.azure_controller_os_username}/controller-post-install.sh"

    connection {
      type        = "ssh"
      user        = var.azure_controller_os_username
      password    = var.azure_controller_os_password
      host        = azurerm_public_ip.controller_public_ip.ip_address
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /home/${var.azure_controller_os_username}/.ssh",
      "sudo mkdir -p /root/.ssh",
      "sudo touch /home/${var.azure_controller_os_username}/.ssh/authorized_keys",
      "sudo touch /root/.ssh/authorized_keys",
      "sudo echo '${var.azure_controller_ssh_public_key_access}' >> /home/${var.azure_controller_os_username}/.ssh/authorized_keys",
      "sudo echo '${var.azure_controller_ssh_public_key_access}' | sudo tee -a /root/.ssh/authorized_keys",
      "sudo chmod 700 /home/${var.azure_controller_os_username}/.ssh",
      "sudo chmod 700 /root/.ssh",
      "sudo chmod 600 /home/${var.azure_controller_os_username}/.ssh/authorized_keys",
      "sudo chmod 600 /root/.ssh/authorized_keys",
      "chmod +x /home/${var.azure_controller_os_username}/controller-post-install.sh",
      "sudo sh /home/${var.azure_controller_os_username}/controller-post-install.sh > /home/${var.azure_controller_os_username}/script_output.log 2>&1"
    ]

    connection {
      type     = "ssh"
      user     = var.azure_controller_os_username
      password = var.azure_controller_os_password
      host     = azurerm_public_ip.controller_public_ip.ip_address
    }
  }

  # provisioner "file" {
  #   source      = "scripts/controller-post-install.sh"
  #   destination = "/home/${var.azure_controller_os_username}/controller-post-install.sh"

  #   connection {
  #     type        = "ssh"
  #     user        = var.azure_controller_os_username
  #     password    = var.azure_controller_os_password
  #     host        = azurerm_public_ip.controller_public_ip.ip_address
  #   }
  # }

  #  provisioner "remote-exec" {
  #   connection {
  #     type        = "ssh"
  #     user        = var.azure_controller_os_username
  #     password    = var.azure_controller_os_password
  #     host        = azurerm_public_ip.controller_public_ip.ip_address
  #   }

  #   inline = [
  #     "chmod +x /home/${var.azure_controller_os_username}/controller-post-install.sh",
  #     "sudo sh /home/${var.azure_controller_os_username}/controller-post-install.sh > /home/${var.azure_controller_os_username}/script_output.log 2>&1",
  #     "sudo grep 'Generated password for user admin:' /home/${var.azure_controller_os_username}/script_output.log | awk '{print $6}' > /home/${var.azure_controller_os_username}/admin_password.txt",
  #     "sudo luna node rename node001 azvm001",
  #     "sudo luna node rename node002 azvm002",
  #     "sudo luna node rename node003 azvm003",
  #     "sudo luna node rename node004 azvm004",
  #     # "sudo luna group change compute -qko 'rootdelay=300 console=ttyS0 earlyprintk=ttyS0 no_timer_check net.ifnames=0'",
  #     "sudo luna osimage change compute -qo 'rootdelay=300 console=ttyS0 earlyprintk=ttyS0 no_timer_check net.ifnames=0'",
  #     "sudo luna group change compute -qpart /tmp/partscript.txt -qpost /tmp/postscript.txt"
  #   ]
  # }

  # provisioner "local-exec" {
  #   command = <<EOT
  #   sshpass -p '${var.azure_controller_os_password}' ssh ${var.azure_controller_os_username}@${azurerm_public_ip.controller_public_ip.ip_address} -o StrictHostKeyChecking=no "cat /home/${var.azure_controller_os_username}/admin_password.txt"
  #   EOT
  # }

}

# ------------------------------------------------------------------------------
# Setup TrinityX Definition
# This block will setup TrinityX in Azure Controller Cloud.
# ------------------------------------------------------------------------------
# resource "null_resource" "wait_for_post_install" {
#   depends_on = [azurerm_virtual_machine.controller]

#   provisioner "local-exec" {
#     command = <<EOT
#     ssh ${var.azure_controller_os_username}@${azurerm_public_ip.controller_public_ip.ip_address} -o StrictHostKeyChecking=no << EOF
#     while pgrep -f controller-post-install.sh > /dev/null; do sleep 5; done
#     EOF
#     EOT
#   }
# }

