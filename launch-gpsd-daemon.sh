#!/bin/sh

SUDO="sudo"
DEVICE="/dev/ttyUSB0"
DEVICE="/dev/ttyUSB1"
$SUDO gpsd -n $DEVICE
