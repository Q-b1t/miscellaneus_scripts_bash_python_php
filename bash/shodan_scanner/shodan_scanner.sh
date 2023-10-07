#!/bin/bash

echo "Shodan Scanner"

if [ -f hosts.txt ]; then
	if [ ! -d shodan_scan_output ]; then
		echo "Creating output directory."
		mkdir shodan_scan_output
	fi
	while read ip; do
		echo "[*] Scanning $ip."
		shodan scan submit $ip > shodan_scan_output/"$ip".txt
	done < hosts.txt

else
	echo "hosts.txt does not exist in this directory."
fi
