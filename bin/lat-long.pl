#!/usr/bin/env perl

use strict;
use warnings;
use IO::Socket;
use Time::HiRes qw( sleep );
use JSON;
use Math::Round;

$|++;

my $SLEEP = 0.0005;

my $gpsd_socket = new IO::Socket::INET (
    PeerAddr => 'localhost',
    PeerPort => '2947',
    Proto => 'tcp',
    Blocking => 0
    ) or die "Could not create socket: $!\n";
    
banner();
watch();

sleep $SLEEP;
$gpsd_socket->print("?POLL;");
sleep $SLEEP;

poll();

exit;

sub banner {
    my $banner = <$gpsd_socket>;
    # {"class":"VERSION","release":"3.7","rev":"3.7","proto_major":3,"proto_minor":7}
    my $hashref  = decode_json $banner;
    my @keys = keys %{$hashref};
    my @values = values %{$hashref};
    my $release = $hashref->{release};
    print "DEBUG: sub banner: $release\n";
}

sub watch {
    sleep $SLEEP;
    print "\n\nsub watch\n--------------------\n";
    $gpsd_socket->print('?WATCH={"enable":true,"json":true}');
    sleep $SLEEP;
    my $devices_json = <$gpsd_socket>;
    print "DEBUG: sub watch: devices_json => $devices_json\n";
    # return unless defined($devices_json);
    my $devices_hashref = decode_json($devices_json);
    my @keys = keys %{$devices_hashref};
    my @values = values %{$devices_hashref};
    my $watch_json = <$gpsd_socket>;
}

sub poll {
    print "\n\nsub poll\n------------------\n";
    my $count = 1;
    my $poll_json = <$gpsd_socket>;

    # return unless defined($poll_json);
    my $hashref  = decode_json $poll_json;
    print "DEBUG: sub poll: hashref => $hashref\n";
    # my $tpv_hashref = ${$hashref->{tpv}}[0];
    print "DEBUG: sub poll: hashref => $$hashref{'class'}\n";
    my $class = $$hashref{'class'};
    if ($class eq 'POLL') {
        print "POLL\n";
        my $tpv_hashref = ${$hashref->{tpv}}[0];
        my ($lat, $lon, $time, $track, $tag, $mode, $speed) = ( $tpv_hashref->{lat}, $tpv_hashref->{lon}, $tpv_hashref->{time}, $tpv_hashref->{track}, $tpv_hashref->{tag}, $tpv_hashref->{mode}, $tpv_hashref->{speed} );
        print "LAT $lat, LONG $lon\n";
    }

    # TDW

    if ($class eq 'TPV') {
        print "TPV\n";
        my ($lat, $lon, $time, $track, $tag, $mode, $speed) = ( $hashref->{lat}, $hashref->{lon}, $hashref->{time}, $hashref->{track}, $hashref->{tag}, $hashref->{mode}, $hashref->{speed} );
        print "$time,",  nearest(.00001, $lat), ",", nearest(.00001, $lon), "\n";
        print "[$time][$track][$speed][$tag][$mode]\n";
    }
    
}

while(1)
{
    #    sleep(1);
    #    print("?POLL;\n");
    $gpsd_socket->print("?POLL;");
    while(<$gpsd_socket>)
    {
        print;
    }
}

close($gpsd_socket);
# 34.08244,-117.72159
# tag, class, climb, speed, device, track, alt, mode
# epx, ept, epv, eps, epy
