#!/bin/bash

# This script helps export the firefox profile file to a mounted drive,
# so i can import it to another computer.
# It is recommended to run it as a bash alias, and as part of a group 
# with granted priviledges to mount external drives without password.

#important parameters
mozilla_profile=~/.mozilla/firefox/profiles.ini
mount_dir=usb_mount
internal_backup_folder=firefox_profile

mount_profile() {
    profile_path=$1 # path of the profile in the computer
    mount_dir=$2 # mount directory for external drive
    internal_backup_folder=$3 # directory the profile will be saved to inside the mount file
    storage_unit=$4 # the storage unit of the target drive
    mkdir $mount_dir
    sudo mount $storage_unit $mount_dir
    echo "Drive $storage_unit was mounted to $mount_dir"
    cd $mount_dir
    mkdir $internal_backup_folder
    cd ..
    cp $profile_path ./$mount_dir/$internal_backup_folder
    echo "The firefox profile $profile_path was succesfully copied to $mount_dir/$internal_backup_folder"
    sudo umount $storage_unit
    rm -r $mount_dir
    echo "The mounted drive $storage_unit has been succesfully unmounted."
}


if [ $# = 0 ];then
	echo "No arguments were specified\nFormat ./emport_firefox_config.sh <HARD_DRIVE_NAME>"
    exit 0
else
    hard_drive=$1
fi

query=$(df -h)

if echo "$query" | grep -q $hard_drive ;then
    storage_unit=$(df -h | grep $hard_drive | tr -s " " | cut -d " " -f1)
    echo "Hard drive $hard_drive was found. Mounting directory on $storage_unit."
    mount_profile $mozilla_profile $mount_dir $internal_backup_folder $storage_unit
else
    echo "The specified hard drive was not found in the file system." 
    exit 0
fi