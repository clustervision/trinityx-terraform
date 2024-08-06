#!/usr/bin/env python3
# -*- coding: utf-8 -*-

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


"""
AWS Import Image Python script for Terraform.
"""
__author__      = "Sumit Sharma"
__copyright__   = "Copyright 2024, TrinityX [Terraform]"
__license__     = "GPL"
__version__     = "2.0"
__maintainer__  = "Sumit Sharma"
__email__       = "sumit.sharma@clustervision.com"
__status__      = "Development"

import argparse
import boto3

def import_image(description, license_type, disk_containers, boot_mode, role_name, region_name, access_key, secret_key):
    client = boto3.client(
        'ec2',
        region_name=region_name,
        aws_access_key_id=access_key,
        aws_secret_access_key=secret_key
    )

    # Start the import image task
    response = client.import_image(
        Description=description,
        LicenseType=license_type,
        Platform='Linux',
        BootMode=boot_mode,
        DiskContainers=[
            {
                'Description': disk_containers['Description'],
                'Format': disk_containers['Format'],
                'UserBucket': {
                    'S3Bucket': disk_containers['S3Bucket'],
                    'S3Key': disk_containers['S3Key']
                }
            }
        ],
        RoleName=role_name
    )

    import_task_id = response['ImportTaskId']
    print(f"Import task started with ID: {import_task_id}")

    # Poll for task status
    while True:
        result = client.describe_import_image_tasks(
            ImportTaskIds=[import_task_id]
        )
        status = result['ImportImageTasks'][0]['Status']
        print(f"Current status: {status}")

        if status in ['completed', 'failed']:
            if status == 'completed':
                print("Import image task completed successfully.")
            else:
                print("Import image task failed.")
            break
        
        # Wait before polling again
        time.sleep(60)

    print(response)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Import an EC2 image.')
    parser.add_argument('aws_region', help='AWS region')
    parser.add_argument('access_key', help='AWS access key')
    parser.add_argument('secret_key', help='AWS secret key')
    
    args = parser.parse_args()

    description = "TrinityX-Compute"
    license_type = "BYOL"
    boot_mode = "uefi"
    role_name = "vmimport"
    region_name = args.aws_region

    disk_containers = {
        'Description': 'Rocky9',
        'Format': 'vhd',
        'S3Bucket': 'trinityx-poc',
        'S3Key': 'trinity.vhd'
    }

    import_image(description, license_type, disk_containers, boot_mode, role_name, region_name, args.access_key, args.secret_key)
