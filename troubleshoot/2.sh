
SUDO="sudo"
DEVICE="/dev/ttyUSB0"
$SUDO gpsd $DEVICE -b -n
sleep 2
$SUDO gpscat $DEVICE
