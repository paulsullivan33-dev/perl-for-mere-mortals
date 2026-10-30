#!/usr/bin/env perl
# t/logparse.t — tests for LogParse.pm, run with prove.
use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/..";
use Test::More;
use LogParse qw(parse_line is_error);

my $good = '2026-03-14T08:57:11Z host=web-01 level=ERROR '
    . 'method=POST path=/checkout status=500 ms=812 user=marta';

my $rec = parse_line($good);
ok( $rec, 'a well-formed line parses' );
is( $rec->{ts},     '2026-03-14T08:57:11Z', 'timestamp captured' );
is( $rec->{host},   'web-01',               'host captured' );
is( $rec->{level},  'ERROR',                'level captured' );
is( $rec->{method}, 'POST',                 'method captured' );
is( $rec->{path},   '/checkout',            'path captured' );
is( $rec->{status}, '500',                  'status captured' );
is( $rec->{ms},     '812',                  'ms captured' );
is( $rec->{user},   'marta',                'user captured' );

is( parse_line('this is not a log line'), undef,
    'a junk line returns undef' );
is( parse_line(undef), undef, 'undef in, undef out' );
is( parse_line(''),    undef, 'an empty line returns undef' );

ok( is_error($rec), 'status 500 is an error' );
ok( !is_error( parse_line(
        '2026-03-14T08:00:00Z host=web-02 level=WARN method=GET '
        . 'path=/favicon.ico status=404 ms=3 user=anon') ),
    'status 404 is not an error' );
ok( !is_error(undef), 'undef is not an error' );

# The fixture as a whole: every line parses, and the counts
# match the ground truth established with awk in t01.
my $log = "$Bin/../weblog.log";
open my $fh, '<', $log or die "Cannot open $log: $!";
my ( $total, %levels );
while ( my $line = <$fh> ) {
    my $r = parse_line($line) or next;
    $total++;
    $levels{ $r->{level} }++;
}
close $fh;
is( $total,          36, 'all 36 fixture lines parse' );
is( $levels{INFO},   24, 'fixture has 24 INFO lines' );
is( $levels{WARN},    7, 'fixture has 7 WARN lines' );
is( $levels{ERROR},   5, 'fixture has 5 ERROR lines' );

done_testing();
