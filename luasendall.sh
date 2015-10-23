#!/bin/bash

# PORT=/dev/tty.SLAB_USBtoUART

PORT=/dev/cu.SLAB_USBtoUART22
LUATOOL=$HOME/201508/ESP8266/ESP8266-NodeMCU/luatool/luatool.py

DIR=$1

for file in $DIR/*.lua
do
	echo "sending: "$file
	$LUATOOL --port $PORT --src $file --dest $file # --verbose
	sleep 1
done
