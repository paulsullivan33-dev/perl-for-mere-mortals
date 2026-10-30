# Installing Perl

**Outcome: a Perl you can run and a
perldoc that can answer questions, both
verified — plus an honest account of
the one package Debian and Ubuntu keep
separate.**

## First, check what you have

Most readers of this guide need to
install nothing. Perl is load-bearing
infrastructure on Unix-like systems:

```bash
which perl
perl --version
```

The lab's machine answered
`/usr/bin/perl` and version **5.38.2**,
the system Perl of Ubuntu 24.04
(transcript t00). macOS ships a system
Perl too (older; Apple discourages
relying on it for your own projects,
but it runs everything in chapters
4–6). If `which perl` finds one at
5.30 or newer, you have everything this
guide's core chapters need. Start at
chapter 4 and come back here only for
the documentation check below.

If there is no Perl — a minimal
container, a stripped server — the
system package is one command:

```bash
sudo apt install perl        # Debian / Ubuntu
sudo dnf install perl        # Fedora family
```

That route is documented-only in this
guide's ledger: the lab's sandbox
shares its package state with other
work, so the lab did not install
system packages, and did not need to —
its Perl was already present. The
version command above is the same one
that proves the lab's Perl, and it is
the check to run after any install.

## The documentation is a separate package

Here is the trap, met for real. On
Debian and Ubuntu:

```bash
perldoc -f split
```

may answer:

```text
You need to install the perl-doc package to use this program.
```

and exit with code 1. Nothing is broken
and your Perl is fine: `/usr/bin/perldoc`
on those systems is a placeholder shell
script, and the real perldoc plus all
the pod files live in the **perl-doc**
package. The fix on a normal machine:

```bash
sudo apt install perl-doc
```

The lab could not install packages, so
it demonstrated the same content
another way: it *downloaded* the
perl-doc `.deb` without installing it
(`apt-get download perl-doc`), unpacked
it with `dpkg -x` into a scratch
folder, and ran the real perldoc from
the unpack with `PERL5LIB` pointed at
its pod directory. Both lookups this
guide depends on — a function entry and
an FAQ search — then worked, and
transcript t00 shows the placeholder
failure and the working lookups side by
side. The workaround is a lab artefact;
the lesson for your machine is the
package name.

## When the system Perl is not yours to use

Two situations deserve a sentence each,
both documented-only here. If you need
a *different* Perl version than the
system offers, or several side by side,
the community tool is **perlbrew**: it
builds Perls into your home directory
and switches between them, leaving the
system Perl untouched — that isolation
is the same instinct as chapter 10's
local library, applied to the
interpreter itself. And on Windows,
**Strawberry Perl** is the standard
distribution: a Perl, a compiler, and
the common libraries in one installer.

Whichever route you took, the gate is
the same two commands: `perl --version`
prints a version, and `perldoc -f
split` prints documentation instead of
an apology. Chapter 4 runs both.
