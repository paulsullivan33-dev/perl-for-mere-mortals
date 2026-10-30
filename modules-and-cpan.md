# Modules and CPAN

**Outcome: you know how to find out
whether a module is core, how a script
takes options cleanly, and how to
install one CPAN module into a local
library and use it — all demonstrated
in transcripts t03 and t07.**

## Core first

Before anything is installed, ask the
interpreter what it already has:

```bash
perl -MJSON::PP -e 'print "have it\n"'
```

If the module loads, silence (or your
print) is the answer; if it does not,
you get chapter 15's `Can't locate`
message, which is itself the signal to
look further. Chapter 9's program —
JSON, checksums, file handling — needed
nothing beyond core. A surprising
amount of practical Perl is like that:
the core library is large because it
was curated over thirty years of
exactly these jobs.

## Options are a module too

Chapter 6's Getopt::Long deserves a
second look as the representative core
module: a declarative spec
(`'top=i'`), values delivered into your
variables by reference, errors handled
with your usage text. The alternative
— reading `@ARGV` by hand — reinvents
this badly in every script that tries.
The core is full of such settled
answers: `File::Copy` and
`File::Find` for file work, `Text::Wrap`
for paragraphs, `Time::Piece` for dates,
`List::Util` for the list operations
other languages build in (it is core
since 5.8, and `sum`, `max`, `uniq`
live there).

## CPAN, installed locally

When the core runs out, CPAN is the
archive — and the lab's demonstration
is deliberately the trickiest honest
case: a *format parser*, Text::CSV,
whose pure-Perl half (Text::CSV_PP)
can read files whose fields quote
their commas, the exact failure
chapter 9 predicted for `split`.

The installer is **cpanm**: one
self-contained script (the lab's fetch
was 303,013 bytes) from
`https://cpanmin.us`, run with `-L` to
name a *local library* — a folder that
belongs to the project:

```bash
curl -sL https://cpanmin.us -o cpanm
chmod +x cpanm
./cpanm -L ../local Text::CSV
```

Transcript t07 keeps the run: it
fetched Text-CSV 2.06 from CPAN,
configured, built, *tested* it (CPAN
installers run the distribution's own
test suite as part of installing — a
custom worth stealing), and reported
`Successfully installed Text-CSV-2.06`.

Using it is one flag and a different
parser:

```bash
perl -I../local/lib/perl5 csv_pp.pl inventory.csv
```

```text
Text::CSV_PP 2.06 parsed 12 rows
  north    1678
  south    1237
```

`-I` adds the local library to `@INC`,
the list of places Perl searches — the
same search list the `Can't locate`
error prints when it fails. The totals
match awk's, again, by a third road:
`split` said 1678 and 1237, the real
parser says 1678 and 1237, and now
quoted commas would not move them.

Why local and not system-wide? The
system Perl belongs to the system;
distributions get grumpy when its
library changes under them, and a
project that carries its dependencies
in a folder can be moved, copied, and
rebuilt as one thing. Where several
projects share a machine, **local::lib**
(the module behind cpanm's `-L`) is the
standard mechanism; perlbrew
(chapter 3) is the same instinct for
the interpreter itself.

## A word on choosing modules

CPAN holds 200,000 distributions of
wildly varying age. The working checks
are dull and reliable: does its
documentation open with a synopsis you
can run; is the latest release recent,
or old-but-finished (plenty of Perl
modules are simply *done*); does it
ship tests, and did they just pass on
your machine during install. A module
that passes those three is a safer bet
than a famous name that fails them.
