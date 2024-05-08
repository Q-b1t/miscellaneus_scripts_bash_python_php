#!/bin/bash


if [ $# = 0 ];then
	echo "[-] No domain specified \n[~] Usage: ./subdomain_recon.sh <domain>"
    exit 0
else
	domain=$1
fi

# set up colors
RED="\033[1;31m"
RESET="\033[0M"

# set up variables for each of the output directories
subdomain_path=$domain/subdomains
screenshot_path=$domain/screenshots
scan_path=$domain/scans


# create pertinent directories should they not exist
if [ ! -d "$domain" ]; then
	mkdir -p $domain
	echo "[+] Creating $domain"
fi

if [ ! -d "$subdomain_path" ]; then
	mkdir -p $subdomain_path
	echo "[+] Creating $subdomain_path"
fi

if [ ! -d "$screenshot_path" ]; then
	mkdir -p $screenshot_path
	echo "[+] Creating $screenshot_path"
fi

if [ ! -d "$scan_path" ]; then
	mkdir -p $scan_path
	echo "[+] Creating $scan_path"
fi

echo -e "[+] Launching subfinder ..."
subfinder -d $domain > $subdomain_path/found.txt

echo -e "[+] Launching assetfinder ..."
assetfinder $domain | grep $domain  > $subdomain_path/found.txt


echo "[+] Finding alive subdomains ..."
cat $subdomain_path/found.txt | grep $domain | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///' | tee -a $subdomain_path/alive.txt 

echo "[+] Taking screenshots from subdomains ..."
gowitness file -f $subdomain_path/alive.txt -P $screenshot_path/ --no-http


echo "[+] nmap scan"
nmap -iL $subdomain_path/alive.txt -T4 	-p-

