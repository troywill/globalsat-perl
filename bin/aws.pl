#!/usr/bin/env perl

my $dbname = "gps_development";
$dbname = "postgres";
my $host = "54.215.211.54";
my $user = "ec2-user";
my $password = "globalsat";

$dbh = DBI->connect("dbi:Pg:dbname=$dbname;host=$host", $user, $password);

# for some advanced uses you may need PostgreSQL type values:
use DBD::Pg qw(:pg_types);

chomp(my $globalsat_data = `./lat-long.pl`);
my ($time, $lat, $lon, $speed, $track) = split( ',', $globalsat_data);
print $time, "\n";
my $statement = "INSERT INTO locations (time,lat,lon) VALUES ('$time',$lat,$lon)";
print $statement, "\n";
$dbh->do($statement);
