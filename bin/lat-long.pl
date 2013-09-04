#!/usr/bin/env perl

use strict;
use warnings;
use IO::Socket;
use Time::HiRes qw( sleep );
use JSON;
use Math::Round;

$|++;

my $gpsd_socket = new IO::Socket::INET (
    PeerAddr => 'localhost',
    PeerPort => '2947',
    Proto => 'tcp',
    Blocking => 0
    ) or die "Could not create socket: $!\n";

banner();
watch();
$gpsd_socket->print("?POLL;");
poll();

exit;

sub watch {
    $gpsd_socket->print('?WATCH={"enable":true,"json":true}');
    my $devices_json = <$gpsd_socket>;
    return unless defined($devices_json);
    my $devices_hashref = decode_json($devices_json);
    my @keys = keys %{$devices_hashref};
    my @values = values %{$devices_hashref};
    my $watch_json = <$gpsd_socket>;
}

sub banner {
    my $banner = <$gpsd_socket>;
    # {"class":"VERSION","release":"3.7","rev":"3.7","proto_major":3,"proto_minor":7}
    my $hashref  = decode_json $banner;
    my @keys = keys %{$hashref};
    my @values = values %{$hashref};
    my $release = $hashref->{release};
}

sub poll {
    my $count = 1;
    my $poll_json = <$gpsd_socket>;
    return unless defined($poll_json);
    my $hashref  = decode_json $poll_json;
    my $tpv_hashref = ${$hashref->{tpv}}[0];
    my ($lat, $lon, $time, $track, $tag, $mode, $speed) = ( $tpv_hashref->{lat}, $tpv_hashref->{lon}, $tpv_hashref->{time}, $tpv_hashref->{track}, $tpv_hashref->{tag}, $tpv_hashref->{mode}, $tpv_hashref->{speed} );
    
    print nearest(.00001, $lat), ",", nearest(.00001, $lon), "\n";
    print "[$time][$track][$speed][$tag][$mode]\n";
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