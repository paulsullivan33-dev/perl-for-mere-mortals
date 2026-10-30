# One-Liners — Perl in Your Pocket

**Outcome: you can take a log apart at
the command line — print its error
lines, count its warnings, tally a
column, edit a copy in place — and you
know what each flag is really doing.
Every example ran against the lab's
36-line log, and every count was
checked against grep or awk in the
same transcript (t02).**

A one-liner is a Perl program given to
`-e` instead of a file. Four flags turn
it into a tool that works on files line
by line. Learn them as sentences:

- `-n` — "wrap my code in a loop that
  reads each line of the input into
  `$_`." Nothing prints unless your
  code prints it.
- `-p` — like `-n`, plus "and print
  `$_` afterwards." A filter: lines
  come in, possibly edited, and go out.
- `-a` — with `-n` or `-p`, "split each
  line into the array `@F` on
  whitespace first" — autosplit.
- `-l` — "handle line endings for me":
  strips the newline from each input
  line and adds one to each print.
- `-i` — with `-p`, "edit the file in
  place" — optionally keeping a backup
  under a suffix you name.

## Print the lines you care about

```bash
perl -ne 'print if /level=ERROR/' weblog.log
```

Under `-n`, each line arrives in `$_`,
and `print` with no argument prints
`$_`. The pattern `/level=ERROR/` is a
test against `$_` — most Perl operators
work on `$_` when you don't name a
variable, which is most of why Perl
one-liners are short. Output: the
log's 5 ERROR lines. Independent check
in the same transcript: `grep -c
'level=ERROR'` says 5.

## Count with an END block

```bash
perl -ne '$c++ if /level=WARN/; END { print "$c warnings\n" }' weblog.log
```

prints `7 warnings`. The new part is
`END { ... }`: code that runs after the
loop finishes, however it finished.
Count during the loop, report in END —
that pair is the single most useful
one-liner shape, and chapter 6's script
is this shape grown up.

## Tally a field with -a

```bash
perl -lane '$s{$F[5]}++; END { print "$_ $s{$_}" for sort keys %s }' weblog.log
```

`-a` split each line into `@F`, so
`$F[5]` is the sixth field — in this
log, `status=200` and friends. The hash
`%s` counts them. Output:

```text
status=200 24
status=301 2
status=404 5
status=500 5
```

The awk equivalent in transcript t01
produced the same four numbers, arrived
at by a completely different road —
that is what "checked" means in this
guide.

## Edit in place, with a parachute

```bash
perl -pe 's/status=500/status=500 (server error)/' weblog.log
```

Under `-p` the substitution edits `$_`
and the loop prints it: a safe preview.
Change `-p` to `-i` territory only when
the preview is right:

```bash
cp weblog.log demo-copy.log
perl -i.bak -pe 's/user=anon/user=guest/' demo-copy.log
```

`-i.bak` rewrote the copy with every
`user=anon` changed to `user=guest`,
and kept the original as
`demo-copy.log.bak`. The transcript
verifies both sides: the copy has 16
`user=guest` lines; the backup still
has all 16 `user=anon` lines. Bare
`-i` with no suffix keeps no backup —
on a copy you made for the purpose,
fine; on the only copy of anything,
never.

## Where one-liners end

One-liners have no `use strict` safety
net (you can add `-Mstrict` if you want
it) and no room for the second thought.
The lab's rule, and this guide's:
a one-liner is for a question you are
asking once, in front of the file it
runs on. The moment the same code is
typed twice, or needs an option, or
someone else must read it, it becomes
a script. That graduation is the next
chapter.
