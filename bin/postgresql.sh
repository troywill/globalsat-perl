#!/bin/sh

dbname=gps_development
username=
table=locations
psql $dbname $username <<EOF
SELECT * FROM $table
EOF
