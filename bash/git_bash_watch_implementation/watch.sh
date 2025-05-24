#!/bin/bash
ARGS="${@}"
clear;
while(true); do
  clear
  OUTPUT=`$ARGS`
  echo -e "${OUTPUT[@]}"
  sleep 1
done
