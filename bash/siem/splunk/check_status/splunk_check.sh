#!/bin/bash

# the idea is to add an alias in .bashrc to have quick way of verifying whether splunk us running or not

splunk_dir=/opt/splunk # the installation path goes here

if  [ -d $splunk_dir  ]; then
	echo "[+] $splunk_dir found"
	sudo /opt/splunk/bin/splunk status
else
	echo "[-] splunk is not installed in the specified location"

fi
