#!/bin/bash

set -o verbose
set -o nounset
sudo gpsctl -n -s 4800 -t "SiRF binary" /dev/ttyUSB0
