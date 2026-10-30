#!/usr/bin/env perl
# inventory.pl — summarise the lab's stock CSV with core Perl.
#
#   perl inventory.pl inventory.csv
#
# Prints the file's MD5 checksum (Digest::MD5), totals per
# warehouse, and the whole summary as JSON (JSON::PP). The CSV
# is simple — no quoted fields — so a plain split is honest
# here; chapter 9 says where that stops being true.

use strict;
use warnings;
use JSON::PP ();
use Digest::MD5 ();

my ($file) = @ARGV;
die "Usage: $0 FILE\n" unless defined $file;

my $ctx = Digest::MD5->new;
open my $bin, '<:raw', $file or die "Cannot open $file: $!\n";
$ctx->addfile($bin);
close $bin;
my $md5 = $ctx->hexdigest;

open my $fh, '<', $file or die "Cannot open $file: $!\n";
my $header = <$fh>;
my ( %qty_by_wh, %value_by_wh );
my $rows = 0;
while ( my $line = <$fh> ) {
    chomp $line;
    next unless length $line;
    my ( $sku, $item, $wh, $qty, $price ) = split /,/, $line;
    $rows++;
    $qty_by_wh{$wh}   += $qty;
    $value_by_wh{$wh} += $qty * $price;
}
close $fh;

my %summary = (
    file       => $file,
    md5        => $md5,
    rows       => $rows,
    total_qty  => 0,
    total_value => 0,
    warehouses => {},
);
for my $wh ( sort keys %qty_by_wh ) {
    $summary{warehouses}{$wh} = {
        qty   => $qty_by_wh{$wh},
        value => 0 + sprintf( '%.2f', $value_by_wh{$wh} ),
    };
    $summary{total_qty}   += $qty_by_wh{$wh};
    $summary{total_value} += $value_by_wh{$wh};
}
$summary{total_value} = 0 + sprintf( '%.2f', $summary{total_value} );

my $json = JSON::PP->new->canonical->pretty;
print $json->encode( \%summary );
