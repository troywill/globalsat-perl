#!/bin/sh

SUDO="sudo"
DEVICE="/dev/ttyUSB0"
$SUDO gpsd -n $DEVICE
