# Recipes

**Outcome: five small jobs done the
Perl way, each one a pattern from the
earlier chapters wearing work clothes.
All run against the lab's fixtures;
the counts are the ones the
transcripts verified.**

## Count anything in a file

The chapter 5 shape, generalised —
swap the pattern and the noun:

```bash
perl -ne '$c++ if /method=POST/; END { print "$c posts\n" }' weblog.log
```

Seven POST lines — the fixture holds
four POST `/login` and three POST
`/checkout` lines, and transcript t09
runs this recipe and the column total
below. The pattern is the recipe; the
pattern-match is the variable part.

## Change many files, keep the parachute

```bash
perl -i.bak -pe 's/user=anon/user=guest/g' *.log
```

Chapter 5's in-place edit across every
log in the folder, each original kept
as `.bak`. Delete the suffix
(`-i` alone) only when a backup exists
somewhere else. Verify with a count
before and after — `grep -c` on both
strings, as t02 does — because a
substitution that matched nothing also
reports success.

## Total a column of numbers

```bash
perl -lane '$t += $F[3]; END { print $t }' numbers.txt
```

`-a` splits, the END block reports.
For the stock file, the same idea with
a comma split is chapter 9's program;
the one-liner version, honest for
simple files:

```bash
perl -F, -lane 'next if $. == 1; $t += $F[3]; END { print "$t units" }' inventory.csv
```

prints `2915 units` — awk's figure
from t01, by a fourth road.

## Deduplicate lines, keep the order

```bash
perl -ne 'print unless $seen{$_}++' messy.txt
```

The hash remembers every line; `print
unless` lets only first appearances
through. Four ideas from this guide in
nine words: `$_`, a hash as a set, a
statement modifier, and post-increment
returning the *old* value — zero, and
therefore false, exactly once per line.

## Ask a file a structured question

When the question is "give me the
errors, as data", graduate the
one-liner to the module — the script
is three lines because chapter 6 did
the work:

```perl
use LogParse qw(parse_line is_error);
while ( my $line = <> ) {
    my $rec = parse_line($line) or next;
    print "$rec->{ts} $rec->{path}\n" if is_error($rec);
}
```

That is the real recipe underneath the
other four: build the parser once,
test it (chapter 11), and thereafter
new questions about the same file are
minutes, not afternoons.
