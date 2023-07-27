#!/bin/bash

# check for the input file
if [ $# = 0 ]; then
	echo "[-] No file was specified."
	exit 0

else
	target_file=$1
fi


# check for the tables directory to export the table
table_dir="tables"

if [ ! -d $table_dir ]; then
	echo "[*] Creating $table_dir."
	mkdir $table_dir
else
	rm -r $table_dir/*
fi

echo "[*] Processing file $target_file."

for i in $(mdb-tables $target_file); do
	mdb-export $target_file $i > $table_dir/$i;
	echo "[+] Exporting $i into $table_dir/$i."
done

