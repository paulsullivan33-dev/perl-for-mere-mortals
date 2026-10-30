# Writing criteria for this guide

Every "for Mere Mortals" guide is written to the same nine-point
standard, so a reader who trusts one can trust the rest. Here it
is, with the verification notes for this particular guide below.

1. **Fix it first.** Reader outcomes lead, not action items: each
   chapter opens by naming the outcome it delivers, shows a check
   the reader can run to confirm they got it, and a reasonable
   reader finishes able to state what was done, what it means,
   and what to try next.
2. **Plain language.** Short sentences, everyday vocabulary,
   technical terms defined on first use. No slang, and no
   idioms that only make sense in one country — the reader may
   be translating as they go.
3. **No dead ends.** A guide never tells the reader to do
   something it cannot show them how to verify. Every claim a
   reader relies on — an install, a command, an output — is
   something this guide demonstrates or clearly labels
   documented-only below.
4. **Live-verified where it matters.** Procedures are run for
   real in the guide's lab wherever the build machine allows it,
   and the transcripts kept in the repository are the evidence.
   What could not be run is listed honestly below, never
   presented as if it had been.
5. **General audiences.** Nothing in this guide — examples,
   fixtures, names, addresses — is modelled on any particular
   reader or author's real life, network, or organisations.
   The lab's log and stock list are invented whole.
6. **Standalone.** A reader needs this guide, its lab, and
   nothing else. Where another guide would genuinely help, it
   is pointed to once, by name, and the chapter still completes
   without it.
7. **Honest about limits.** Chapter 14 names what the tool
   cannot do: readability is the programmer's job, one-liners
   have a size where they become a debt, the regex engine can
   be made to hang, and the ecosystem is mature rather than
   growing.
8. **The ethics rule is in the text, early.** Perl raises no
   interception or impersonation question of the kind other
   guides in this series carry; its own hazard is quieter —
   a powerful text tool pointed at logs and files that are
   not yours. Chapter 1 and chapter 5 state the working rule
   plainly: run these tools on your own machines and your own
   data, keep the `.bak` parachute on in-place edits, and
   preview with `-p` before you rewrite anything with `-i`.
9. **Builds clean.** The site builds with MkDocs in strict mode
   with no warnings, and a fresh reader following the chapters
   in order reaches the stated outcome of each.

## Verification notes for this guide

The build machine is a 2-CPU, 7.7 GB Ubuntu 24.04 sandbox,
shared with other work while the lab ran. The lab used the
machine's **system Perl 5.38.2** (Ubuntu noble's perl) from
`/usr/bin/perl`, unmodified. One piece of the standard setup
was missing — the documentation: Debian and Ubuntu split it
into the **perl-doc** package, and the system `perldoc` is a
placeholder script that prints "You need to install the
perl-doc package to use this program." and exits 1. The lab
could not install system packages (the sandbox's apt state is
shared), so it downloaded the perl-doc `.deb`
(5.38.2-3.2ubuntu0.6) without installing it, unpacked it with
`dpkg -x` into the lab scratch area, and ran the genuine
perldoc from the unpack with `PERL5LIB` pointed at its pod
directory; both required lookups then worked. All lab files
live in `perl-lab/`; transcripts in `perl-lab/transcripts/`.

Fixtures are this guide's own and deliberately generic: a
36-line key=value web log for an invented two-host site
(INFO 24, WARN 7, ERROR 5 by construction) and a 12-row stock
CSV for an invented parts shop. No real person, organisation,
address or event appears in either.

Run for real, with transcripts as evidence:

- Version banner (Perl 5.38.2), `prove --version`
  (TAP::Harness 3.44), the perldoc placeholder failure kept
  verbatim, and working perldoc lookups from the unpacked
  perl-doc: `-f split` and the FAQ search `-q sort` (t00).
- Ground truth established *without* Perl: `wc`, `grep -c`
  and awk computed the fixture's level counts (24/7/5),
  status counts (200×24, 301×2, 404×5, 500×5), busiest
  paths (/index.html 6, /products 5, /api/status and /login
  4 each), response-time total 4,114 ms (average 114.3 ms),
  and the inventory's 2,915 units worth 4,312.60 (t01).
- One-liners: `-e`, `-n` printing the 5 ERROR lines
  (grep agrees), `-n` with an END block counting 7 warnings,
  `-a`/`-l` tallying statuses to awk's identical figures,
  `-p` substituting in a stream, and `-i.bak` rewriting a
  copy — 16 `user=guest` lines in the copy, all 16 original
  `user=anon` lines preserved in the `.bak` (t02).
- The log analyser `logreport.pl` with its parser module
  `LogParse.pm`: `perl -c` clean on both, and its full
  report matching the t01 ground truth on every figure,
  including the `--top 5` run showing the /api/status–/login
  tie the awk check found (t03).
- Named captures: the parser's pattern run stand-alone,
  printing all eight fields from `%+` and the same record
  encoded as JSON by JSON::PP; a junk line matching
  nothing (t04).
- Core modules on the inventory: JSON::PP's summary
  (north 1,678 units / 2,435.80; south 1,237 / 1,876.80)
  recomputed independently by awk to the same figures, and
  Digest::MD5's checksum `d5209f33cf8fc480839d592099c92188`
  identical to `md5sum`'s output for the same file (t05).
- Tests: `perl-lab/t/logparse.t` — 19 Test::More assertions
  over field capture, the undef contract, the error
  threshold, and whole-fixture counts — run under prove:
  all passing (t06).
- CPAN: the standalone cpanm script fetched from
  cpanmin.us installed **Text-CSV 2.06** into a local
  library in the lab scratch area (its own test suite ran
  as part of the install), and `Text::CSV_PP` then parsed
  the inventory: 12 rows, warehouse totals 1,678 and 1,237,
  matching awk a third time (t07).
- Failures kept verbatim: a `$coutn` typo refused by strict
  at compile time (exit 255 under `perl -c`); a missing
  module's `Can't locate No/Such/Module.pm in @INC`
  (exit 2); an uninitialized-value warning under `-w`; and
  the analyser's `Cannot open /nonexistent.log` die
  (exit 2) (t08).
- Chapter 12's recipes run as written: the POST count (7,
  grep agrees), the `-F,` column total (2,915 units), and
  the order-preserving deduplication of a five-line file
  with three distinct lines (t09).

Documented only — described from the projects' documentation,
not run, and the text does not claim otherwise:

- Fresh installation of Perl itself (`apt install perl`,
  `dnf install perl`): the lab's Perl was already present,
  and the sandbox's shared apt state ruled out installing;
  the verification commands are the ones the lab ran.
- perlbrew's version management and Strawberry Perl on
  Windows: named and characterised, not exercised.
- Text::CSV_XS (the compiled accelerator) and CPAN's own
  `cpan` client: the lab used the pure-Perl CSV_PP via
  cpanm; the XS half is not needed for correctness and is
  not claimed.
- The neighbour languages of chapter 13 (awk and sed beyond
  the checking one-liners, Python, Ruby) and Raku:
  characterised, not run or benchmarked.
- Object-oriented Perl, threading, XS, database access and
  web frameworks: out of scope by the README's own statement,
  not silently skipped.
