#!/bin/bash

set -o nounset
SUDO="sudo"
DEVICE="/dev/ttyUSB0"
DEBUG_LEVEL=3
$SUDO gpsd -D $DEBUG_LEVEL -N -n $DEVICE
