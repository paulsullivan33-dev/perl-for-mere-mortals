package LogParse;
# LogParse — parse one line of the lab's key=value web log.
#
# A line looks like:
#   2026-03-14T07:58:03Z host=web-01 level=INFO method=GET \
#       path=/index.html status=200 ms=38 user=anon
#
# parse_line() returns a hash reference of the fields, or undef
# when the line does not match. The pattern uses named captures,
# so the fields arrive in the %+ hash and are copied out whole.

use strict;
use warnings;
use Exporter 'import';

our @EXPORT_OK = qw(parse_line is_error);

sub parse_line {
    my ($line) = @_;
    return unless defined $line;

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
        return { %+ };
    }
    return;
}

sub is_error {
    my ($record) = @_;
    return $record && $record->{status} >= 500;
}

1;
