# The Moving Parts

**Outcome: you can name the five parts
of a working Perl setup — interpreter,
core library, perldoc, prove, CPAN —
and say which part to reach for when
something is missing.**

Perl looks like a single program. In
use it is a small system of parts, and
most beginner confusion is really two
parts being mistaken for each other.

## The interpreter: `perl`

One program, `perl`, does everything:
it runs scripts (`perl report.pl`),
runs code given on the command line
(`perl -e 'print "hi\n"'`), checks a
file without running it (`perl -c`),
and via its flags becomes the line
editor and filter of chapter 5. It also
reports on itself: `perl --version`
prints the release (5.38.2 in the lab)
and `perl -V` dumps its build
configuration. When a script misbehaves,
the version is the first fact worth
knowing, because the language still
evolves — a feature from a 2020 tutorial
may not exist in a 2012 system Perl.

## The core library

Perl ships with well over a hundred
modules installed — the **core library**.
A module is a file of Perl code with a
name like `JSON::PP`, loaded with `use`.
The ones this guide leans on:

- **strict** and **warnings** — the
  guardrails of chapter 1. They are
  modules (well, pragmas) too.
- **Getopt::Long** — parses command-line
  options like `--top 5` (chapter 6).
- **JSON::PP** — reads and writes JSON,
  in pure Perl, no installation
  (chapter 9).
- **Digest::MD5** — checksums
  (chapter 9).
- **Test::More** — the vocabulary of
  Perl tests: `ok`, `is`, `done_testing`
  (chapter 11).
- **FindBin** and **lib** — how a script
  finds its own companion modules.

You can list what your Perl carries with
`perl -e 'print "$_\n" for @INC'` for
the *places* it looks, and the `corelist`
tool for what a given release contains.
The practical point: before installing
anything, check whether the core already
has it. Chapter 9's entire stock summary
runs on core modules alone.

## perldoc: the manual that travels with it

Perl's documentation is installed as
**pod** files and read with **perldoc**:
`perldoc perlfunc` for all built-in
functions, `perldoc -f split` for one
function, `perldoc -q sort` to search
the FAQ, `perldoc MODULENAME` for a
module's own manual. Chapter 4 runs all
of these. One trap, met in the lab and
worth knowing before you need it: on
Debian and Ubuntu the documentation is
a separate package, `perl-doc`, and
until it is installed `perldoc` is a
placeholder that says so and stops
(transcript t00). The interpreter works
fine without it; the manual does not
exist without it.

## prove: the test runner

Tests are Perl files ending in `.t`
that print a simple protocol. **prove**
runs them, counts the results, and
reports pass or fail per file. It ships
with Perl (the lab's is TAP::Harness
3.44) and chapter 11 puts it to work:
19 assertions over the lab's log parser,
all passing (transcript t06).

## CPAN and its installers

Beyond the core sits **CPAN**, the
Comprehensive Perl Archive Network:
200,000+ distributions uploaded by
their authors since 1995. Installing
from it is a solved problem with two
tools worth knowing by name: **cpan**,
the client that ships with Perl, and
**cpanm** (App::cpanminus), a single
self-contained script you fetch and run,
which is what the lab used to install
Text::CSV into a *local* library —
a folder inside the project, not a
change to the system (chapter 10,
transcript t07). The local-library
pattern matters: it means a project can
carry its dependencies beside it, and
your system Perl stays exactly as the
system vendor left it.

## Check

Name the part: the thing that runs your
script (the interpreter); the module
you need that is already installed (the
core library); the command that tells
you what `split` really does (perldoc);
the command that runs your tests
(prove); the archive you visit when the
core runs out (CPAN). Chapter 3 makes
sure all five are present.
