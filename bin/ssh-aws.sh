#!/usr/bin/bash

host="54.215.211.54"
ssh $host
exit
my $password = "globalsat";

$dbh = DBI->connect("dbi:Pg:dbname=$dbname;host=$host", $user, $password);
print "connected\n";

# for some advanced uses you may need PostgreSQL type values:
use DBD::Pg qw(:pg_types);

chomp(my $globalsat_data = `./lat-long.pl`);
my ($time, $lat, $lon, $speed, $track) = split( ',', $globalsat_data);
print $time, "\n";
my $statement = "INSERT INTO locations (time,lat,lon) VALUES ('$time',$lat,$lon)";
print $statement, "\n";
$dbh->do($statement);
