#!/bin/bash

set -o nounset
set -o verbose
SUDO="sudo"
DEVICE="/dev/ttyUSB0"
$SUDO gpsd -n $DEVICE
