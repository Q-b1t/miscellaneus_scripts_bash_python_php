#!/bin/bash

if [ "$1" == "" ]

then
echo "Hai dimmenticato l' ip address"
echo "Sintassi -> ./ipSweep.sh xx.xx.xx"

else 
for ip in `seq 1 254`; do
ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
done 
fi
