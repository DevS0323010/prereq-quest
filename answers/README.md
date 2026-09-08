# Your answers

Copy the template below into a new file:

```text
answers/<your-github-username>.md
```

For example, if your GitHub username is `octocat`, create
`answers/octocat.md`. A ready-to-copy version of this template also lives
at `answers/TEMPLATE.md`.

This file is where every mission's written answers live: your profile,
plus one section per mission. Each mission's `README.md` tells you what
goes in its section. CI reads this file, so keep the section headings
(the `##` lines) intact — you can edit everything else freely.

This file is self-reported where it says so (mostly the profile and the
SSH section). It is not used to penalize you for inexperience. It exists
so your instructor can compare what you *say* you've done against what
CI *observed* you doing.

## How CI reads this file

It's a simple parser, not a Markdown engine. Three rules keep it happy:

- Leave the `##` headings and the `Label:` lines as they are — plain,
  starting at the beginning of the line. Don't bold them (`**Path:**`),
  indent them, or turn them into list items (`- Path:`).
- Put your answer after the colon, or on the next non-blank line.
- Don't wrap answers in code fences (```` ``` ````).

Backticks around a value are tolerated, so ``Path: `missions/…` `` is
fine. Everything that isn't a heading or a label is yours to edit
freely.

---

```md
# <github-username>

## Environment

OS:

Editor / IDE:

Shell:

Languages I have used:

## Things I have done before

- [ ] SSH into another machine
- [ ] Resolve a Git merge conflict
- [ ] Build a Docker image
- [ ] Read a stack trace
- [ ] Compile software from source
- [ ] Use a debugger
- [ ] Use Linux as a primary development environment

## Something I built

...

## Something I want to understand better

...

## Mission 01 — Linux

### Task A — find the file

Path:

Command I used:

### Task B — count the errors

Count:

Command I used:

## Mission 03 — SSH

SSH token:

Command I used:

## Mission 04 — Docker

What was wrong:

What I changed:

## Mission 05 — Debug

What was wrong:

What I changed:

## Mission 06 — Improve something

What I changed:

Why:
```
