#!/bin/sh

SUDO="sudo"
DEVICE="/dev/ttyUSB0"
$SUDO killall gpsd
$SUDO gpsd -n $DEVICE
