#!/usr/bin/env perl
# parse_demo.pl — show named captures at work on one log line,
# then print the captured record as JSON with JSON::PP.

use strict;
use warnings;
use JSON::PP ();

my $line = '2026-03-14T08:57:11Z host=web-01 level=ERROR '
    . 'method=POST path=/checkout status=500 ms=812 user=marta';

if ( $line =~ /\A
        (?<ts>\S+) \s+
        host=(?<host>\S+) \s+
        level=(?<level>\S+) \s+
        method=(?<method>\S+) \s+
        path=(?<path>\S+) \s+
        status=(?<status>[0-9]{3}) \s+
        ms=(?<ms>[0-9]+) \s+
        user=(?<user>\S+)
        \s* \z/x ) {
    print "Matched. The named captures in %+:\n";
    printf "  %-8s %s\n", $_, $+{$_} for sort keys %+;
    my $json = JSON::PP->new->canonical->pretty;
    print "As JSON:\n", $json->encode( { %+ } );
}
else {
    print "No match.\n";
}

my $junk = 'this is not a log line at all';
if ( $junk =~ /status=(?<status>[0-9]{3})/ ) {
    print "Unexpected match: $+{status}\n";
}
else {
    print "The junk line matched nothing, as it should.\n";
}
