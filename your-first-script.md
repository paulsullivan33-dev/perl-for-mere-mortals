# Your First Script

**Outcome: a log analyser you would
actually keep — `logreport.pl` — written
the disciplined way, taking an option
and a filename, parsing through a
module of its own, and producing a
report whose every number matches an
independent awk count (transcript
t03).**

Chapter 5's counting one-liner answers
a question once. This chapter builds
the grown-up form: a file, with the
guardrails on, that you run every week.

## The shape of a Perl script

```perl
#!/usr/bin/env perl
use strict;
use warnings;
```

Line one tells the shell how to run the
file. Lines two and three are the
contract from chapter 1: undeclared
variables are compile errors, and
suspicious values speak up. Then the
program. Everything in this chapter —
and everything you write after it —
starts exactly like this.

## Reading a file properly

```perl
open my $fh, '<', $file or die "Cannot open $file: $!\n";
while ( my $line = <$fh> ) {
    ...
}
close $fh;
```

Three habits are packed into these
lines. The filehandle is a variable
(`$fh`), not a bareword. The open names
its mode (`<` for reading) as a separate
argument, so a filename can never be
mistaken for a command. And the open is
checked with `or die`, where `$!` is
Perl's variable holding the operating
system's own error text — when the file
is missing, the program says `Cannot
open /nonexistent.log: No such file or
directory` and exits non-zero, instead
of silently reporting on nothing
(transcript t08 shows exactly that).

`while ( my $line = <$fh> )` reads a
line at a time: the file is never
loaded whole, so the same code works on
a 36-line lab log and a 36-million-line
real one.

## Options with Getopt::Long

```perl
use Getopt::Long qw(GetOptions);
my $top = 3;
GetOptions( 'top=i' => \$top )
    or die "Usage: $0 [--top N] FILE...\n";
```

Getopt::Long is core (chapter 2). The
`'top=i'` spec reads "an option called
--top that takes an integer"; the
`\` hands it a reference — an address
to write the value into — so `$top`
holds 3 unless the user says `--top 5`.
Transcript t03 runs the report both
ways. Whatever does not fit the spec
is an error with the usage line, not a
surprise later.

## The parser becomes a module

Parsing one line — the regular
expression of chapter 8 — is a separate
concern from reporting, so it lives in
its own file, `LogParse.pm`, and the
script loads it:

```perl
use FindBin qw($Bin);
use lib $Bin;
use LogParse qw(parse_line is_error);
```

FindBin finds the script's own folder;
`use lib` adds it to the search path;
the `use` line imports the two functions
by name. Each parsed line comes back as
a **hash reference** — `$rec->{level}`,
`$rec->{status}` — and the report loop
is then nothing but counting:

```perl
$by_level{ $rec->{level} }++;
$by_status{ $rec->{status} }++;
$by_path{ $rec->{path} }++;
$ms_total += $rec->{ms};
$errors++ if is_error($rec);
```

Chapter 11 tests `LogParse` on its own,
without the script — that is the
dividend the split pays.

## The report, checked

```text
$ perl logreport.pl weblog.log
Log report for: weblog.log
Lines read: 36
Parsed:     36
Unparsed:   0
By level:
  ERROR    5
  INFO     24
  WARN     7
By status:
  200      24
  301      2
  404      5
  500      5
Top 3 paths:
  /index.html        6
  /products          5
  /api/status        4
Average response time: 114.3 ms
Server errors (status >= 500): 5
```

Every figure in that block also appears
in transcript t01 or t03 computed by
awk, grep or `wc` from the same file:
36 lines, the same level and status
tallies, the same top paths (awk finds
`/login` tied with `/api/status` at 4;
the script breaks ties alphabetically,
so `--top 5` in t03 shows both), and
the same 114.3 ms average from awk's
own sum of 4,114 ms. Two implementations
agreeing is the strongest check this
guide knows how to make.

`perl -c logreport.pl` deserves a
mention before you run anything new:
it compiles the file and reports
`logreport.pl syntax OK` — or, as
chapter 15 shows, the exact line where
a typo lives, found before a single
statement executed.
