#!/bin/bash 
set -e

if [ $# = 0 ];then
	echo "No browser nor target specify. Using firefox connecting to google.com"
	browser="firefox"
	target="google.com"
else
	browser=$1
	target=$2
fi

service_status=$(sudo service tor status | grep Active: | tr -s " " | cut -d " " -f3)

echo "tor is currencty $service_status"

if [ "$service_status" = "inactive" ];then
	echo "Initializing..."
	sudo service tor start 
	echo "TOR SERVICE IS UP"
fi

proxychains4 $browser $target
