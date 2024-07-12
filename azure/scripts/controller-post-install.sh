
#!/bin/bash

echo "+--------------------------------------------------------------------------+"
echo "Resizing the Root Partition"

DISK="/dev/sda"
PARTITION="/dev/sda6"
VG_NAME="rocky"
LV_NAME="/dev/mapper/rocky-root"
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
