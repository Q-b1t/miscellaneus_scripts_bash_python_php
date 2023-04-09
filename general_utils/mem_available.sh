#!/bin/bash

if [ $# = 0 ];then
	echo "Arguments were specified"
    exit 0
else
    hard_drive=$1
fi

total_memory=$(df -h | grep -E "$hard_drive" | tr -s ' ' | cut -d ' ' -f2)
remaining_memory=$(df -h | grep -E "$hard_drive" | tr -s ' ' | cut -d ' ' -f4)

echo "$remaining_memory are currently available."
echo "Total Memory: $total_memory" 

