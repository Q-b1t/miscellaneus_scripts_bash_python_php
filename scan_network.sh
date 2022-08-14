#!/bin/bash

# This is usefull to scan the home network, get the ip addresses of the active devices connected to the network, and export them in a text file to an external hard drive. 
# Pass the drive's name as argument when running the script

external_drive=$1

partition=$(df -h | grep $external_drive | tr -s " " | cut -d " " -f 1)

echo $partition

mount_directory="mount_$external_drive"

mount_subdirectory="network_scan_output"

data_export="local_networks.txt"

echo "Partition $partition found to be associated with $external_drive"

mkdir $mount_directory

sudo mount $partition $mount_directory

echo "External drive $external_drive mounted at $mount_directory. The device was mounted succesfully"

echo "Scanning for local network ip addresses"

sudo arp-scan --plain  --localnet | grep -E '([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})|([0-9a-fA-F]{4}\\.[0-9a-fA-F]{4}\\.[0-9a-fA-F]{4})$' | tr -s " " | cut -f 1 >> $data_export

mkdir -p $mount_directory/$mount_subdirectory

mv $data_export $mount_directory/$mount_subdirectory

echo "$data_export exported to $mount_directory/$mount_subdirectory"

echo "unmounting"

sudo umount $partition

rm -r $mount_directory

echo "Output trasmition completr $external_drive succesfully unmounted"



