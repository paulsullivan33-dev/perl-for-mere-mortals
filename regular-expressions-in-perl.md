# Regular Expressions in Perl

**Outcome: you can match, substitute,
and — the centre of this chapter —
capture named fields out of a line into
a hash, the way the lab's parser does.
The general pattern language has its
own guide in this series (Regular
Expressions for Mere Mortals); this
chapter is about Perl's particular
grip on it, demonstrated in transcript
t04.**

Regular expressions are not a library
in Perl; they are syntax. A pattern
sits between slashes, `m//` matches,
`s///` substitutes, and the operators
work on `$_` unless `=~` aims them at
another variable:

```perl
$line =~ s/status=500/status=500 (server error)/
```

That is chapter 5's one-liner, promoted
to a named variable. Everything in the
pattern language itself — character
classes, quantifiers, anchors,
alternation — this guide deliberately
leaves to the Regex guide; here we take
the three Perl-specific powers a
working script needs.

## Named captures: %+, the ready-made hash

A capture group `(...)` normally hands
back numbered variables — `$1`, `$2` —
which turn unreadable past about three.
Perl 5.10 and later allow *names*:

```perl
(?<status>[0-9]{3})
```

After a successful match, every named
capture is waiting in the special hash
**`%+`**, keyed by name: `$+{status}`.
The lab's parser (in `LogParse.pm`)
writes the whole log line as one
pattern:

```perl
if ( $line =~ /\A
        (?<ts>\S+) \s+
        host=(?<host>\S+) \s+
        level=(?<level>\S+) \s+
        method=(?<method>\S+) \s+
        path=(?<path>\S+) \s+
        status=(?<status>[0-9]{3}) \s+
        ms=(?<ms>[0-9]+) \s+
        user=(?<user>\S+)
        \s* \z/x ) {
    return { %+ };
}
```

Three details matter. The `/x` flag
lets the pattern spread over lines with
whitespace ignored, so each field gets
a line and a comment's worth of room —
a long pattern written this way can be
*read*. `\A` and `\z` anchor to the
absolute start and end of the string,
so a line that is almost a log line
does not parse as one. And
`return { %+ }` copies the capture hash
into a fresh hash reference — necessary,
because `%+` itself is repopulated by
the next match anywhere in the program.

Transcript t04 runs the same pattern
stand-alone and prints `%+` field by
field — host web-01, level ERROR,
status 500, ms 812, user marta — then
feeds a junk line at the pattern and
shows it matching nothing. A failed
match is not an error; the `if` simply
takes the other branch, and the parser
returns `undef`, which chapter 11's
tests assert by name.

## Substitution, and qr// for patterns you reuse

`s///` with `/g` replaces every match;
with `/e`, the replacement is *code*,
evaluated per match — the door to
transformations like numbering lines
or reformatting dates inline:

```perl
perl -pe 's/(\d+)/$1 * 2/e' numbers.txt
```

And a pattern you use twice can be
built once with `qr//`, which compiles
it into a value you can pass around,
store, and interpolate into larger
patterns — the tidy way to keep a
program's idea of "a status code" or
"a timestamp" in exactly one place.

## Honest warnings

Perl's regex engine is famously
complete, which includes rope: nested
quantifiers can make a pattern take
astronomical time on adversarial input,
and a pattern written without anchors
will find matches you did not mean in
data you did not expect. The parser's
discipline — anchored at both ends,
fields named, one pattern per format —
is the working defence, and chapter 14
returns to it.
