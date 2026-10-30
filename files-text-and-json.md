# Files, Text and JSON

**Outcome: a second real program —
`inventory.pl` — that reads a stock
list, checksums it, and emits a JSON
summary, every figure of which was
recomputed independently in transcript
t05.**

The log analyser's input was uniform
lines. Real files are messier, and this
chapter's fixture is the everyday case:
a CSV of stock for an invented parts
shop — 12 rows of SKU, item, warehouse,
quantity, unit price.

## Reading rows

With no quoted fields anywhere in the
file, one line is one record and
`split` is an honest tool:

```perl
my ( $sku, $item, $wh, $qty, $price ) = split /,/, $line;
```

The list assignment names all five
fields at once — chapter 7's list
context earning its keep. Totals
accumulate in two hashes, by warehouse,
exactly as the log counts did.

Be clear about where this stops being
true, because the boundary is the
lesson: the day an item is named
`gear, brass` the file needs real CSV
quoting, `split` silently produces six
fields for five columns, and every
total downstream is wrong without a
single error message. That is not a
hypothetical — it is why chapter 10
installs a real CSV parser from CPAN
and re-does these very totals with it.
Rule of thumb: `split` for formats
*you* generate and control; a parser
for formats that arrive from the world.

## Checksums with Digest::MD5

```perl
my $ctx = Digest::MD5->new;
open my $bin, '<:raw', $file or die "Cannot open $file: $!\n";
$ctx->addfile($bin);
my $md5 = $ctx->hexdigest;
```

`Digest::MD5` is core. `addfile` feeds
it the file in chunks — the `:raw`
layer matters, because a checksum is
over bytes, and text mode's newline
translation on some systems would
quietly change what is being summed.
The proof is external: `md5sum
inventory.csv` printed
`d5209f33cf8fc480839d592099c92188`, and
the Perl program's JSON carries the
identical string (transcript t05).

## JSON with JSON::PP

```perl
my $json = JSON::PP->new->canonical->pretty;
print $json->encode( \%summary );
```

JSON::PP is core, pure Perl, and —
the point — a faithful two-way door:
anything it encodes, it (or anything
else) can decode. `canonical` sorts the
keys so output is stable enough to diff
and to test; `pretty` indents it for
human eyes. The program's output:

```json
{
   "file" : "inventory.csv",
   "md5" : "d5209f33cf8fc480839d592099c92188",
   "rows" : 12,
   "total_qty" : 2915,
   "total_value" : 4312.6,
   "warehouses" : {
      "north" : { "qty" : 1678, "value" : 2435.8 },
      "south" : { "qty" : 1237, "value" : 1876.8 }
   }
}
```

(shown compacted; the transcript has
the full pretty form). awk recomputed
every figure from the same CSV —
2,915 units, $4,312.60 in total, 1,678
units north and 1,237 south — and
agreed. One presentational honesty:
money sums are rounded with
`sprintf '%.2f'` before encoding,
because binary floating point will
otherwise hand you 4312.599999999999
somewhere down the line; the chapter
says so rather than hoping nobody
notices.

## The pattern to keep

Read with a checked open; parse with
the simplest tool the format honestly
allows; verify one figure by an
independent route; emit in a format
other programs can read. That is most
of practical Perl in one sentence, and
it is the shape of both programs this
guide has built.
