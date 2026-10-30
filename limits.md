# Limits

What Perl will not do for you, stated
plainly. The lab met some of these
directly; the rest are the settled
character of the language and are
labelled as such.

**Readability is your job, not the
language's.** TIMTOWTDI is a real
freedom with a real bill: Perl will
run dense, clever, write-only code
happily, and the folklore is full of
it. The guardrails in this guide —
strict, warnings, named captures,
patterns broken over lines with `/x`,
one pattern per format — are social
technology, not syntax. Skip them and
Perl will not save you from yourself;
it will help you dig, quickly.

**One-liners have a size limit.** Past
a screenful, a one-liner has all the
costs of a program — logic, edge
cases, someone must maintain it — and
none of the protections: no strict, no
tests, no name. Chapter 5's graduation
rule (typed twice → script) is the
defence. The folklore's worst Perl is
one-liners that escaped.

**The regex engine can be made to
hang.** Nested quantifiers over
adversarial input can take
astronomical time (chapter 8). Perl
will not warn you mid-pattern. On data
from the world, anchor patterns,
bound the repetitions, and treat a
regex over untrusted input as code —
because it is.

**It is a mature ecosystem, not a
growing frontier.** CPAN's 200,000
distributions include abandonware
alongside finished tools; chapter 10's
checks exist because "it is on CPAN"
is not a quality mark. New development
energy in the wider world goes to
younger languages. Perl's counter-offer
is stability measured in decades —
code from this guide's transcripts
will run, unchanged, on Perls far
older and far newer than the lab's.

**Startup and memory are a batch
tool's, not a sprinter's.** The
interpreter starts in milliseconds and
streams files of any size line by
line, but it will not beat a compiled
language at raw numeric crunching, and
loading a file whole (the novice's
`my @all = <$fh>`) makes memory the
input's problem. The line-at-a-time
habit of chapter 6 is the answer the
language intends.

**Not the tool for some whole
categories.** Graphical interfaces,
mobile apps, hard real-time work, and
anything whose ecosystem lives
elsewhere — Perl can touch most of
these through bindings and bridges,
and in each case another guide in
this series is the honest
recommendation. A glue language's
deepest limit is that some things
should not be glued.

**Versions in the wild vary.**
Features are version-gated (named
captures need 5.10; this guide's floor)
and a system Perl can be a decade old.
Check `perl --version` on the machine
in front of you — chapter 4's first
command — before blaming the code.
