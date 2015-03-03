#!/bin/bash

set -o nounset
SUDO="sudo"
DEVICE="/dev/ttyUSB0"
DEBUG_LEVEL=2
OUTSIDE_WORLD="-G"
#OUTSIDE_WORLD=""
$SUDO gpsd -D $DEBUG_LEVEL $OUTSIDE_WORLD -N -n $DEVICE
