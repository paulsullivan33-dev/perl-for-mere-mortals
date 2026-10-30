# Variables, Context and $_

**Outcome: Perl's three variable shapes
stop looking like punctuation soup —
you can read the sigils, explain the
default variable `$_`, and name the
idea (context) behind most beginner
surprises.**

## Three shapes, three sigils

Perl has three built-in containers,
each announced by its **sigil** — the
punctuation in front of the name:

- `$name` — a **scalar**: one value. A
  string, a number, a reference. `$ms`,
  `$file`, `$rec`.
- `@name` — an **array**: an ordered
  list, indexed from 0. `@F` from
  chapter 5, `@paths` in the report.
- `%name` — a **hash**: pairs of keys
  and values, looked up by name.
  `%by_level`, `%+` in chapter 8.

The sigil describes what you are
*getting*, so it changes with the
access: the whole array is `@paths`,
but one element is `$paths[0]` — a
scalar out of the array, hence `$`.
Likewise `%by_level` whole, and
`$by_level{ERROR}` for one value. Read
that way, the punctuation is a type
annotation the language writes for you.

Two fine points the lab's code uses
constantly. A **reference** is a scalar
that points at a hash or array, and the
arrow dereferences it: `$rec->{level}`
is "the `level` value of the hash that
`$rec` points at". And `my` declares a
variable in the smallest enclosing
scope — under strict, `my` (or an
explicit alternative) is not optional,
which is the point.

## $_: the default variable

A remarkable amount of Perl is written
about a variable you cannot see:

```perl
while (<$fh>) {
    print if /level=ERROR/;
}
```

`$_` is Perl's current topic. Reading
a line into nothing in particular puts
it in `$_`; `print` with no argument
prints `$_`; a bare `/pattern/` tests
`$_`; `split` and `chomp` and dozens
more work on `$_` when not told
otherwise. Chapter 5's one-liners are
short because `$_` carries the line
from the loop to every operation
without being named once.

Used with restraint, that is clarity:
the code says "for each line: if it's
an error, print it". Used across a long
distance — set here, relied on forty
lines later — it is how scripts become
riddles. The lab's own scripts name
their loop variable (`my $line`) the
moment the loop body grows past a line
or two; keep `$_` for short loops and
one-liners, where its whole life fits
on the screen.

## Context: the idea that explains the rest

Perl functions and operators look at
*how their result will be used* and
behave accordingly. This is **context**:

- **Scalar context**: one value wanted.
  `my $n = @paths;` — the array in
  scalar context gives its *count*.
- **List context**: several values
  wanted. `my @p = @paths;` copies the
  elements.
- **Void context**: nothing wanted;
  the call is for its side effects.

The same expression, two honest
answers. `parse_line` in chapter 6
depends on it politely: in the test
file, `is( parse_line('junk'), undef )`
relies on its `return;` giving `undef`
in the scalar context of the
comparison. And the famous trap —
`localtime` returning a string in
scalar context and a list of numbers
in list context — is not caprice, it
is this one rule applied.

When Perl code surprises you, the
question that unlocks it is almost
always: *what context is this in, and
what is `$_` right now?* Ask those two
before suspecting the machine.

## Check

Read these aloud: `$by_status{500}++`
("the hash by_status, at key 500, add
one"); `my $first = $paths[0]`; and
explain why `my $count = @lines` is a
number but `my @copy = @lines` is a
list of lines. If both come easily,
chapter 8's captures — which arrive as
the hash `%+` — will read as plain
sight.
