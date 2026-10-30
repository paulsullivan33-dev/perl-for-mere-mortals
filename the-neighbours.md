# The Neighbours

Perl shares its ground — text, glue,
automation — with several tools you
will meet in the same breath. These are
characterisations from the projects'
own documentation and this guide's
experience of the shapes involved, not
benchmarks; the lab ran Perl only.

## awk and sed: the elders

Before Perl there were **awk** (1977)
and **sed**, and a fair slice of Perl
is their ideas generalised: awk's
pattern-action lines and field
splitting became `-n` and `-a`; sed's
`s///` kept its spelling. This guide
used awk as its independent witness in
nearly every transcript, which is the
right relationship: awk is unbeatable
for a one-off column job in a pipeline,
and it stops exactly where Perl starts
— named data structures, modules,
tests, programs longer than a screen.
The Text Processing guide in this
series teaches both properly.

## Python: the other answer

Python (which has its own guide here)
is the language most often chosen
today for the jobs Perl was chosen for
in 1998: glue, automation, text with
structure. The honest comparison is
not about power — both are fully
capable — but about shape. Python
enforces one readable style and reads
like pseudocode; Perl is terser,
denser in text handling, and already
installed on machines Python has never
touched. Perl's regular expressions
are built into the syntax; Python's
live in a module, `re`, modelled
largely on Perl's. If you are starting
fresh with a team, Python is usually
the pick. If the machine, the log
files and thirty years of working
scripts are already there, Perl earns
its keep — and reading it is a skill
either way, because the scripts are
not going anywhere.

## Ruby: the cousin who tidied up

Ruby took much of Perl's outlook —
expressive, more than one way, text
friendly — and polished it into
consistency, then rode Rails to web
fame. Its one-liners (`ruby -ne`) will
feel familiar after chapter 5, down to
the flags. Where Ruby is the house
language (Rails shops, Homebrew,
Jekyll sites), it is the natural glue;
Perl's edge is deployment archaeology:
it is simply present on more machines,
with more decades of system scripts
already written in it.

## Raku: the sibling, not the sequel

One honest paragraph, as promised.
**Raku** began life in 2000 as "Perl
6", a ground-up redesign by many of
the same people, and was renamed in
2019 precisely because it is not a
version of Perl: it is a different
language — gradual typing, grammars
(regexes grown into full parsers),
concurrency built in — with its own
interpreter and its own community, and
essentially no compatibility with the
code in this guide. Perl 5 did not
stop while Raku grew: it kept its
yearly releases and its ecosystem.
Nothing here runs on Raku and nothing
there runs here; if grammars and a
clean-slate design appeal, Raku is
worth its own look — as a new
language, not an upgrade.

## The shell itself

And beneath them all, **Bash** (also
guided here): the right tool for
*sequencing* programs, the wrong tool
for parsing anything complicated. The
working rule of this whole series of
neighbours: shell to arrange, awk for
a column, Perl when the job needs
memory, modules or a test, Python when
the team reads it tomorrow. Every one
of those boundaries is a chapter
somewhere in the lab's transcripts.
