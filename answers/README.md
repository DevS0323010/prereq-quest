# Your answers

Copy the template below into a new file:

```text
answers/<your-github-username>.md
```

For example, if your GitHub username is `octocat`, create
`answers/octocat.md`. A ready-to-copy version of this template also lives
at `answers/TEMPLATE.md`.

This file is committed to a public fork. Use only your GitHub username;
do not include a student ID, Discord name, legal name, email address, or
other private identifier. Your instructor should collect any roster
mapping separately through a private channel.

This file is where your written answers live: your profile, plus a
section for each mission that asks for one. Not every mission does —
Mission 02 is judged from your repository itself, so the template has no
section for it, and that's not a mistake. Each mission's `README.md`
tells you what (if anything) goes here. CI reads this file, so keep the
section headings (the `##` lines) intact — you can edit everything else
freely.

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

