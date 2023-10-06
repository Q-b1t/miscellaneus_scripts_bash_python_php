#!/bin/bash

echo "Shodan Host Searcher"

if [ -f hosts.txt ]; then
	if [ ! -d shodan_search_output ]; then
		echo "Creating output directory."
		mkdir shodan_search_output
	fi
	while read ip; do
		echo "[*] Searching for information on $ip."
		shodan host $ip > shodan_search_output/"$ip".txt
	done < hosts.txt

else
	echo "hosts.txt does not exist in this directory."
fi