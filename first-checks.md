# First Checks

**Outcome: four small commands run and
understood — the version banner, a
perldoc function lookup, an FAQ search,
and a one-liner — so every later
chapter's tools are proven before they
are needed. All four are in transcript
t00 and t02.**

## The version, and why it matters

```bash
perl --version
```

```text
This is perl 5, version 38, subversion 2 (v5.38.2) built for x86_64-linux-gnu-thread-multi
```

Perl feature-gates by version: named
captures arrived in 5.10, for example,
and this guide uses nothing newer than
that, so any Perl from the last decade
runs the whole book. The version line
is also the first thing to quote when
asking for help — "it doesn't work" is
a mystery; "on 5.38.2 the test fails
at line 12" is a bug report.

## Look a function up

Perl has around 400 built-in functions,
and nobody memorises them. perldoc is
the reference, installed with the
language (chapter 3's caveat about the
separate docs package applies):

```bash
perldoc -f split
```

prints split's full entry — its three
forms, what it returns in each context,
and the edge cases. The habit to build
is: guess, then look it up, then write
the line. The lookup takes five seconds
and the entry is written by the people
who maintain the function.

## Ask the FAQ

```bash
perldoc -q sort
```

searches the Perl FAQ by keyword and
found, for *sort*, the entry "How do I
sort an array by (anything)?" — with
the working answer, including the
warning that default sort is string
comparison and would order 1, 10, 2.
The FAQ (perldoc perlfaq) is nine
documents of exactly these questions,
and `-q` is the way in.

## The first one-liner

```bash
perl -e 'print "Perl says hello\n"'
```

```text
Perl says hello
```

`-e` says: the next argument is a
program, not a filename. Single quotes
protect it from your shell, which would
otherwise eat the `$` signs and
backslashes Perl programs are full of —
that quoting rule is worth learning
now, because every one-liner in
chapter 5 follows it. Nothing here
needed a file; when a program grows
past one line, it graduates to a file
of its own, which is chapter 6.

## Check

Run the four: version prints 5.something,
`perldoc -f split` prints documentation
(or chapter 3's placeholder message —
fix that first), `perldoc -q sort`
finds the sorting entry, and the
one-liner says hello. Then chapter 5
puts the one-liner to real work on a
real file.
