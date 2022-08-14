#!/bin/bash

# This is usefull to scan the home network, get the ip addresses of the active devices connected to the network, and export them in a text file to an external hard drive. 
# Pass the drive's name as argument when running the script



if [ $# = 0 ];then
	echo "No external hard drive was specified"
    exit 0
else
    external_drive=$1
fi


partition=$(df -h | grep $external_drive | tr -s " " | cut -d " " -f 1)


if [ ${#partition} -gt 0 ];then
    mount_directory="mount_$external_drive"
    mount_subdirectory="network_scan_output"
    data_export_ip="local_ip_adresses.txt"
    data_export_mac_address="local_mac_adresses.txt"
    echo "Partition $partition found to be associated with $external_drive"

else 
    echo "No partition associated with $external_drive found."
    exit 0
fi



mkdir $mount_directory

sudo mount $partition $mount_directory

echo "External drive $external_drive mounted at $mount_directory. The device was mounted succesfully"

echo "Scanning for local network ip addresses"

sudo arp-scan --plain  --localnet | grep -E '([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})|([0-9a-fA-F]{4}\\.[0-9a-fA-F]{4}\\.[0-9a-fA-F]{4})$' | tr -s " " | cut -f 1 >> $data_export_ip

echo "Found the following addresses in the local network:"

cat $data_export_ip

sudo arp-scan --plain  --localnet | grep -E '([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})|([0-9a-fA-F]{4}\\.[0-9a-fA-F]{4}\\.[0-9a-fA-F]{4})$' | tr -s " " | cut -f 2 >> $data_export_mac_address

echo "Found the following mac addresses in the local network:"

cat $data_export_mac_address

[ ! -d "$mount_directory/$mount_subdirectory" ] && rm -r $mount_directory/$mount_subdirectory

mkdir -p $mount_directory/$mount_subdirectory

mv $data_export_ip $data_export_mac_address $mount_directory/$mount_subdirectory

echo "$data_export_ip exported to $mount_directory/$mount_subdirectory"

echo "unmounting"

sudo umount $partition

rm -r $mount_directory

echo "Output trasmition completr $external_drive succesfully unmounted"



