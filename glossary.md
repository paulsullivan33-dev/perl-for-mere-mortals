# Glossary

The terms, collected in one place.

**@F** — the array `-a` autosplit fills
with the fields of the current line.

**@INC** — the list of directories Perl
searches for modules; `-I` and
`use lib` add to it.

**$_** — the default variable: the
current topic that loops, `print`,
patterns and many functions work on
when none is named.

**%+** — the hash of named captures
from the last successful match, keyed
by capture name.

**$!** — the variable holding the
operating system's latest error text;
the human half of every checked `open`.

**context** — whether an expression's
result is used as one value (scalar
context), many (list context), or not
at all (void context); behaviour
follows from it.

**core library** — the hundred-plus
modules that ship with Perl itself:
JSON::PP, Digest::MD5, Getopt::Long,
Test::More and friends.

**CPAN** — the Comprehensive Perl
Archive Network, the public archive of
third-party Perl distributions since
1995.

**cpanm** — App::cpanminus: a single
self-contained script that installs
CPAN distributions, into a local
library when told `-L`.

**hash** — `%name`: a container of
key–value pairs, looked up by key.
The counting tool of chapters 5–9.

**local library** — a project-owned
folder of installed modules, kept out
of the system Perl's library.

**module** — a file of Perl code with
a `::`-separated name, loaded with
`use`; the unit of reuse, and of CPAN.

**named capture** — a regex group with
a name, `(?<status>...)`, whose text
arrives in `%+` after the match.

**one-liner** — a program passed to
`perl -e` on the command line instead
of living in a file.

**perldoc** — the reader for Perl's
installed documentation (pod); `-f`
looks up a function, `-q` searches
the FAQ.

**perlbrew** — the tool that builds
and switches between Perl versions in
a home directory, leaving the system
Perl alone.

**pod** — "plain old documentation",
the markup the Perl manuals and module
docs are written in.

**pragma** — a module that changes the
language's behaviour: `strict`,
`warnings`, `lib`.

**prove** — the test runner shipped
with Perl; runs `.t` files and reports
pass or fail per file.

**Raku** — the language begun as
"Perl 6" and renamed in 2019; a
different language from Perl 5, not a
version of it.

**reference** — a scalar that points
at a hash or array; the arrow `->`
follows the pointer.

**scalar** — `$name`: a single value —
string, number, or reference.

**sigil** — the punctuation before a
variable name (`$`, `@`, `%`) that
says what shape of thing is being
got.

**strict** — the pragma that makes
undeclared variables compile errors;
chapter 1's non-negotiable first line.

**Test::More** — the core module
providing `ok`, `is` and
`done_testing`, the vocabulary of
Perl tests.

**TIMTOWTDI** — "there is more than
one way to do it", Perl's motto and
its standing warning.

**warnings** — the pragma that makes
Perl report suspicious values and
constructs as they happen.
