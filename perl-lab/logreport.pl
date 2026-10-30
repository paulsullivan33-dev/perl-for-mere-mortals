#!/usr/bin/env perl
# logreport.pl — summarise the lab's key=value web log.
#
#   perl logreport.pl [--top N] FILE...
#
# Prints totals by level and status, the N busiest paths, the
# average response time, and the server-error count. Parsing
# lives in LogParse.pm, next to this script.

use strict;
use warnings;
use FindBin qw($Bin);
use lib $Bin;
use Getopt::Long qw(GetOptions);
use LogParse qw(parse_line is_error);

my $top = 3;
GetOptions( 'top=i' => \$top )
    or die "Usage: $0 [--top N] FILE...\n";
die "Usage: $0 [--top N] FILE...\n" unless @ARGV;

my ( %by_level, %by_status, %by_path );
my ( $lines, $parsed, $ms_total, $errors ) = ( 0, 0, 0, 0 );

for my $file (@ARGV) {
    open my $fh, '<', $file or die "Cannot open $file: $!\n";
    while ( my $line = <$fh> ) {
        $lines++;
        my $rec = parse_line($line) or next;
        $parsed++;
        $by_level{ $rec->{level} }++;
        $by_status{ $rec->{status} }++;
        $by_path{ $rec->{path} }++;
        $ms_total += $rec->{ms};
        $errors++ if is_error($rec);
    }
    close $fh;
}

print "Log report for: @ARGV\n";
printf "Lines read: %d\n", $lines;
printf "Parsed:     %d\n", $parsed;
printf "Unparsed:   %d\n", $lines - $parsed;

print "By level:\n";
printf "  %-8s %d\n", $_, $by_level{$_} for sort keys %by_level;

print "By status:\n";
printf "  %-8s %d\n", $_, $by_status{$_} for sort keys %by_status;

print "Top $top paths:\n";
my @paths = sort { $by_path{$b} <=> $by_path{$a} or $a cmp $b }
    keys %by_path;
 splice @paths, $top if @paths > $top;
printf "  %-18s %d\n", $_, $by_path{$_} for @paths;

printf "Average response time: %.1f ms\n",
    $parsed ? $ms_total / $parsed : 0;
printf "Server errors (status >= 500): %d\n", $errors;
