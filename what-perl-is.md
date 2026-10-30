# What Perl Is

**Outcome: you can say what Perl is
for, why it is probably already on your
machine, and why this guide insists on
two lines — `use strict; use warnings;`
— at the top of every script.**

Perl is a programming language created
by Larry Wall in 1987 to do the jobs
that sat awkwardly between shell
scripts and C programs: reading text
files, pulling them apart, counting,
sorting, reformatting, and reporting.
It was built by a linguist, and it
shows: Perl borrows ideas from natural
language, offers several ways to say
the same thing, and trusts the
programmer to pick the clear one. Its
unofficial motto is TIMTOWTDI —
"there is more than one way to do it".

That history explains both halves of
its reputation. Perl powered much of
the early web and still runs a great
deal of the world's plumbing: log
processing, system administration,
bioinformatics pipelines, build tools,
and — quietly — parts of the test
suites of other languages. It also
collected a folklore of unreadable
one-liners and hurried scripts, written
before the language grew the guardrails
this guide treats as non-negotiable.

## The model in one paragraph

A Perl program is text the `perl`
interpreter reads and runs. There is no
separate compile step to manage: you
write a file, run `perl file.pl`, and
it goes. Around the interpreter sits a
large **core library** of modules that
ship with it — JSON, checksums, file
handling, testing — and beyond that
**CPAN**, the public archive of over
200,000 third-party modules built up
since 1995. Chapter 2 names each part
properly.

Three properties decide most of what
Perl is like to use:

- **Text is home ground.** Strings,
  regular expressions and file reading
  are built into the language's syntax,
  not bolted on. Splitting a log line
  into named fields is a few characters
  of code (chapter 8).
- **It is already there.** macOS and
  nearly every Linux distribution ship
  a system Perl, because their own
  tools depend on it. The lab's machine
  had Perl 5.38.2 waiting before anyone
  installed anything (transcript t00).
- **It scales from one line to a
  program.** The same language writes
  `perl -ne 'print if /ERROR/' log` at a
  prompt and a tested, modular analyser
  a chapter later — and this guide does
  exactly that, in that order.

## The disciplined subset

Perl's flexibility means the language
will happily run code you would not
want to read next month. The modern
community answer is a short header that
turns the guardrails on:

```perl
use strict;
use warnings;
```

**strict** makes Perl refuse undeclared
variables — which turns the commonest
typo in programming into a message at
compile time, before a single line
runs. **warnings** makes it speak up
about suspicious values, like using a
variable that was never given one. The
lab met both doing their jobs, and
chapter 15 quotes the messages
verbatim. Nothing in this guide runs
without those two lines, and the
one-liners of chapter 5 are their only
exception — a one-liner is typed,
checked against the file in front of
you, and gone.

## A note on versions and names

The living language is **Perl 5**,
released on a yearly cadence; the lab
ran 5.38.2. You will meet old references
to "Perl 6": that language was renamed
**Raku** in 2019 and is a different
language with its own interpreter, not
a newer Perl. Chapter 13 gives it an
honest paragraph. When this guide says
Perl, it means Perl 5.

## Check

You have the model if you can finish
these sentences: Perl is a language for
______ that is already installed on
______; strict exists to catch ______;
CPAN is where ______ live. (Text,
almost every Unix machine, typos and
undeclared variables, third-party
modules.) Chapter 2 takes the machine
apart.
