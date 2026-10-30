# Troubleshooting

Every message below is quoted from a
real run in transcript t08 (or t00),
with the cause and the fix. Perl's
error messages are famously *good* —
specific, located, and usually naming
the remedy — but only once you have
seen them in calm conditions.

## Global symbol "$coutn" requires explicit package name

```text
Global symbol "$coutn" requires explicit package name (did you forget to declare "my $coutn"?) at broken.pl line 4.
broken.pl had compilation errors.
```

**Cause:** a typo'd variable name
(`$coutn` for `$count`) under
`use strict`. **Fix:** none needed
beyond spelling — this is strict doing
exactly its job, at compile time,
before any line ran. Find it fastest
with `perl -c file.pl`, which checks
without running. Exit code was 255.
The polite parenthetical — *did you
forget to declare* — is Perl guessing
your intent, and it is usually right.

## Can't locate No/Such/Module.pm in @INC

```text
Can't locate No/Such/Module.pm in @INC (you may need to install the No::Such::Module module) (@INC entries checked: ...).
BEGIN failed--compilation aborted.
```

**Cause:** `use` of a module that is
not installed in any place Perl
searches. The `::` in the name becomes
slashes in the filename — the message
shows both forms. **Fixes, in order:**
check the spelling (this error fires
on typos exactly as on absences); check
whether it is core under a slightly
different name; install it, preferably
into a local library (chapter 10); or
add the folder that does hold it with
`-I` or `use lib`. The @INC list in
the message is the search path itself —
read it before concluding anything.
Exit code was 2.

## Use of uninitialized value

```text
Use of uninitialized value $x in concatenation (.) or string at -e line 1.
```

**Cause:** a variable used before it
was given a value — `undef` in a
string, a number, or a comparison.
This is **warnings** speaking, which
is why the program kept running and
printed an empty value after the
complaint. **Fix:** trace where the
value was supposed to come from —
often a parse that silently failed
(`parse_line` returning undef,
chapter 8) or a field missing from
input. Treat the first occurrence as
the bug; the tenth is the same bug
echoing.

## You need to install the perl-doc package

```text
You need to install the perl-doc package to use this program.
```

**Cause:** Debian/Ubuntu split the
documentation out; `perldoc` is a
placeholder until **perl-doc** is
installed (chapter 3). The interpreter
is unaffected. **Fix:** install the
package; in the lab's no-install
sandbox, unpack the `.deb` and run the
real perldoc from the unpack
(transcript t00).

## Cannot open ... No such file or directory

```text
Cannot open /nonexistent.log: No such file or directory
```

**Cause:** the checked `open ... or
die` of chapter 6, working as designed
— the text after the colon is the
operating system's reason, carried in
`$!`. **Fix:** the path, the working
directory, or the permissions —
whichever the reason names. A program
that dies like this on bad input is
healthy; the dangerous version is the
one that reports success on a file it
never read, which is what the `or die`
exists to prevent. Exit code was 2.

## The debugging order

When a Perl program misbehaves: run
`perl -c` first (does it compile);
confirm `perl --version` (is this the
interpreter you think it is); reduce
to the smallest input that still
fails — for parsers, one line in a
file by itself; and read the *first*
message, not the last. Perl reports in
causal order, and the cascade after
the first error is usually just the
first error, still falling.
