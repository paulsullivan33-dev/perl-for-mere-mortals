#!/usr/bin/env perl
# csv_pp.pl — the inventory totals again, this time parsed by
# Text::CSV_PP, the pure-Perl CSV module installed from CPAN
# into the lab's local library (see transcript t07).
#
#   perl -I../local/lib/perl5 csv_pp.pl inventory.csv

use strict;
use warnings;
use Text::CSV_PP ();

my ($file) = @ARGV;
die "Usage: $0 FILE\n" unless defined $file;

my $csv = Text::CSV_PP->new( { binary => 1 } );
open my $fh, '<', $file or die "Cannot open $file: $!\n";
$csv->column_names( $csv->getline($fh) );   # header row

my %qty_by_wh;
my $rows = 0;
while ( my $row = $csv->getline_hr($fh) ) {
    $rows++;
    $qty_by_wh{ $row->{warehouse} } += $row->{qty};
}
close $fh;

printf "Text::CSV_PP %s parsed %d rows\n",
    Text::CSV_PP->VERSION, $rows;
printf "  %-8s %d\n", $_, $qty_by_wh{$_} for sort keys %qty_by_wh;
