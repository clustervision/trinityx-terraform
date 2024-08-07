#!/bin/bash

# Run the import image command and capture the output
output=$(aws ec2 import-image --license-type BYOL --disk-containers Format=vhd,Url=S3://trinityx-poc/trinity.vhd,Description=Rocky9 --boot-mode uefi --description 'TrinityX-Compute' --platform Linux --role-name vmimport)

# Extract the import task ID from the output
task_id=$(echo "$output" | jq -r '.ImportTaskId')

# Save the task ID to a file
echo "$task_id" > /tmp/import_task_id.txt


output=$(aws ec2 import-image --license-type BYOL --disk-containers Format=vhd,Url=S3://trinityx-poc/trinity.vhd,Description=Rocky9 --boot-mode uefi --description "TrinityX-Compute" --platform Linux --role-name vmimport)
echo $output

# Extract the ImportTaskId from the output
import_task_id=$(echo $output | jq -r '.ImportTaskId')
echo $import_task_id

# Check if the ImportTaskId was successfully extracted
if [ -z "$import_task_id" ]; then
    echo "Failed to extract ImportTaskId."
    exit 1
fi

# Loop to describe the import image tasks
for i in {1..1000}; do
    echo ""
    echo "++++++++++++++++++++++++++++++++++++++++++++                    $i              +++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo ""
    aws ec2 describe-import-image-tasks --import-task-ids $import_task_id --output table
    echo ""
    echo ""
    sleep 10
done