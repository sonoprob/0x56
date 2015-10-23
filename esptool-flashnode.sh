#!/bin/bash

# PORT=/dev/tty.SLAB_USBtoUART
PORT=/dev/cu.SLAB_USBtoUART22

ESPDIR=$ESP
FIRMWAREDIR=$ESPDIR/scripts/firmware

BINARY="nodemcu-dev096-11-modules-2015-08-25-18-41-49-integer.bin" # works
# node file gpio wifi net pwm tmr ws2812
BINARY="nodemcu-master-8-modules-2015-09-28-23-02-34-integer.bin"

cd $ESPDIR/scripts
./init.sh
./esptool.py --port $PORT write_flash 0x00000 $FIRMWAREDIR/$BINARY -fs 32m -fm dio -ff 40m
