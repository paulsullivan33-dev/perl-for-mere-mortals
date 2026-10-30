# Testing Your Perl

**Outcome: a test file that pins the
parser's behaviour down — 19 assertions
under `prove`, all passing — and a clear
idea of what a failing one looks like
before it happens to you. Transcript
t06 is the evidence.**

Perl's testing culture is old and
strong: the language's own 250,000-test
suite is why "the tests pass" means
something, and CPAN installers run
every distribution's tests as they
install (chapter 10). The tools are
core: **Test::More** provides the
vocabulary, **prove** runs the files.

## The vocabulary

A test file is a Perl script that
states expectations:

```perl
use Test::More;
use LogParse qw(parse_line is_error);

my $rec = parse_line($good_line);
ok( $rec, 'a well-formed line parses' );
is( $rec->{status}, '500', 'status captured' );
is( parse_line('this is not a log line'), undef,
    'a junk line returns undef' );
done_testing();
```

`ok` asserts truth; `is` asserts
equality and, on failure, prints both
what it got and what it wanted — the
difference between a test suite and a
pile of print statements. The third
argument is the sentence the failure
will be read by. The lab's file,
`perl-lab/t/logparse.t`, makes 19
assertions in four groups: each of the
eight named fields captured correctly;
junk, empty and undef input all
returning undef; `is_error` true for a
500, false for a 404, false for undef;
and — the group that makes the fixture
earn its place — the whole lab log
parsed end to end with its counts
asserted: 36 lines, 24 INFO, 7 WARN,
5 ERROR, the same ground truth awk
established in transcript t01.

## Running it

```bash
prove -I. t/logparse.t
```

```text
t/logparse.t .. ok
All tests successful.
Files=1, Tests=19
Result: PASS
```

`-I.` puts the project folder on the
module search path so the test finds
`LogParse.pm` beside it; the test file
also adds its own parent directory via
FindBin, so it passes from any working
directory. `prove -v` shows each
assertion by number and name — the
tail of that run is in t06 too (`ok 17
- fixture has 24 INFO lines` and
friends). prove's exit code is the
contract scripts rely on: zero when
all pass, non-zero otherwise, so a
failing test stops a build instead of
decorating it.

## Why these tests, in this shape

The tests assert *behaviour a reader
of the parser depends on*, not the
parser's insides: fields by name, the
undef contract for bad input, the
error threshold, and whole-fixture
counts that an independent tool
verified first. If tomorrow's edit to
the pattern breaks any of those, a
named sentence says which. That is the
whole discipline, and it is deliberately
small enough to copy: one test file,
one module, one command — the pattern
scales by adding files to `t/`, not by
growing machinery.
