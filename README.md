# Perl for Mere Mortals

Perl is the language that glued the
early web together, and it never left:
it ships on almost every Unix machine,
it is superb at text, and a generation
of system tools is written in it. It
also has a reputation — dense, cryptic,
write-only — earned largely by code
written in a hurry in 1998. This guide
teaches the modern, disciplined subset:
every script runs under **strict** and
**warnings**, every claim is checked
against a second tool, and the famous
one-liners are explained symbol by
symbol instead of handed down as
incantations.

The lab that wrote this guide ran the
system **Perl 5.38.2** on a small Linux
machine. Against two small fixtures it
invented — a 36-line web server log and
a 12-row stock list — it took the log
apart with one-liners, then wrote a
real log analyser as a script plus a
module, and checked every number the
Perl produced against the same counts
done in awk and grep: 24 INFO lines, 7
WARN, 5 ERROR; the busiest path
`/index.html` six times; an average
response time of 114.3 ms. It looked
functions up with **perldoc**, parsed
with **named captures**, summarised
stock with the core modules **JSON::PP**
and **Digest::MD5** (whose checksum
matched `md5sum` digit for digit),
wrote 19 tests and ran them under
**prove**, and installed one module
from **CPAN** into a local library and
put it to work. It also broke things
on purpose — a typo that strict caught
before the program ran, a module that
is not installed, a value that was
never set — and kept the messages
verbatim.

One surprise the lab met on the way:
on Debian and Ubuntu the interpreter
arrives without its own documentation.
`perldoc` is a placeholder that tells
you to install the `perl-doc` package.
Chapter 3 shows the check, and the
lab's workaround is written down in
`criteria.md`.

## What this guide covers

- [**What Perl is**](what-perl-is.md) —
  the mental model: a glue language for
  text, already installed, with more
  than one way to do it and a
  disciplined way to choose
- [**The moving parts**](the-moving-parts.md) —
  the interpreter, the core library,
  perldoc, prove, and CPAN: which part
  holds what, and where new powers come
  from
- [**Installing Perl**](installing-perl.md) —
  checking what you already have, the
  system packages (including the
  separate documentation package), and
  the version check that proves it runs
- [**First checks**](first-checks.md) —
  the version banner, looking a function
  up in perldoc, asking the FAQ a
  question, and your first one-liner
- [**One-liners**](one-liners.md) —
  Perl in your pocket: `-e`, `-n`, `-p`,
  `-a` and `-i`, what each one really
  does, and the END block that turns a
  loop into a report
- [**Your first script**](your-first-script.md) —
  a log analyser worth keeping: strict
  and warnings from the first line,
  files opened and read properly, and
  the parser split into its own module
- [**Variables, context and $_**](variables-and-context.md) —
  scalars, arrays and hashes, the sigils
  that name them, the default variable
  Perl works on when you don't say, and
  context — the idea behind most Perl
  surprises
- [**Regular expressions in Perl**](regular-expressions-in-perl.md) —
  matching, substituting, and named
  captures that hand you a ready-made
  hash of fields
- [**Files, text and JSON**](files-text-and-json.md) —
  reading a stock list, checksums with
  Digest::MD5, JSON with JSON::PP, and
  where `split` stops being a CSV parser
- [**Modules and CPAN**](modules-and-cpan.md) —
  the core library you already own,
  Getopt::Long for options, and one
  CPAN module installed into a local
  library with cpanm and put to work
- [**Testing your Perl**](testing-your-perl.md) —
  Test::More assertions and the prove
  runner: 19 tests over the lab's
  parser, all passing
- [**Recipes**](recipes.md) — count
  anything in a log, replace across
  files with a backup, total a column,
  deduplicate lines, and summarise the
  stock list in one command each
- [**The neighbours**](the-neighbours.md) —
  awk and sed, Python, Ruby, and an
  honest paragraph on Raku, the language
  that used to be called Perl 6
- [**Limits**](limits.md) — what Perl
  will not do for you: readability is
  your job, the ecosystem is mature
  rather than growing, and one-liners
  have a size where they become a debt
- [**Troubleshooting**](troubleshooting.md) —
  the strict typo, the module that is
  not there, the uninitialized value,
  and the placeholder perldoc, each
  with its real message
- [**Glossary**](glossary.md) — the
  terms, collected in one place

## What it doesn't cover

Web frameworks and databases beyond a
mention — Perl has them, and they are
their own guides' worth of material.
Object-oriented Perl is pointed at, not
taught: the lab's module is procedural,
deliberately. Perl's threading model,
XS (glue to C code), and writing your
own CPAN distribution are likewise out
of scope. And nothing here teaches the
undisciplined dialect — no script in
this guide runs without strict and
warnings, because the lab's position is
that the guardrails are the lesson.

## How to use this guide

Read chapter 1 for the model and
chapter 2 before installing anything —
knowing which part holds what turns
later confusion into a named problem.
Chapters 3 and 4 get you an interpreter
and its documentation; chapter 5 is the
pocket toolkit most people use daily.
Chapter 6 is the one to type along
with: it builds the log analyser the
rest of the guide keeps returning to.
The lab's files live in `perl-lab/`:
the two fixtures (`weblog.log`,
`inventory.csv`), the scripts and the
parser module, the test file under
`perl-lab/t/`, and every run's
transcript under `perl-lab/transcripts/`.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [Text Processing for Mere Mortals](https://paulsullivan33-dev.github.io/text-processing-for-mere-mortals/)
- [Regular Expressions for Mere Mortals](https://paulsullivan33-dev.github.io/regex-for-mere-mortals/)
- [Bash for Mere Mortals](https://paulsullivan33-dev.github.io/bash-for-mere-mortals/)
- [Python for Mere Mortals](https://paulsullivan33-dev.github.io/python-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/perl-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/perl-for-mere-mortals/blob/main/LICENSE-CODE).
