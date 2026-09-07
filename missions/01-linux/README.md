# Mission 01 — Linux scavenger hunt

The penguin left something behind. Go find it.

## Task A — find the file

Somewhere under `missions/01-linux/files/` there is a file containing the
exact string:

```text
THE_PENGUIN_WAS_HERE
```

Find it. There may be files nearby that look similar but are not quite
right — read before you trust a match.

Useful tools: `ls -a`, `find`, `grep`, `cat`, `less`.

## Task B — count the errors

`missions/01-linux/server.log` is a small server log. How many lines
contain `ERROR`?

Useful tools: `grep`, `wc`, pipes (`|`).

## Record your answers

Open your profile at `answers/<github-username>.md` and fill in the
`## Mission 01 — Linux` section:

```md
## Mission 01 — Linux

### Task A — find the file

Path:

Command I used:

### Task B — count the errors

Count:

Command I used:
```

- `Path` should be the path to the file you found, relative to the
  repository root.
- `Count` should be a plain number.
- CI checks the *answers*, not the exact command you typed — but if you
  can't explain the command you used, that's worth noticing yourself.
