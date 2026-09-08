# Mission 02 — Git

Git history is part of what gets graded here, not just the final files.

## Task A — commit as you go

Don't do this whole quest in one commit. As you complete each mission,
commit that mission's work with a message that describes it. A reasonable
shape, across the whole quest, looks something like:

```text
add profile
solve linux mission
fix the application
finish docker mission
```

Exact wording doesn't matter. What matters is that your history shows the
shape of the work, not a single "finish quest" commit at the end.

## Task B — resolve a conflict

The upstream repository (the one you forked from, not your fork) has a
branch called `challenge-conflict`. Merge
`upstream/challenge-conflict` into your current branch and resolve the
conflict in `missions/02-git/quest-log.md`.

Before merging, replace the placeholder entry in that file with your own
entry and commit it. After resolving the conflict, the file must contain
both your entry and the entry from `challenge-conflict`, with no conflict
markers left.

<details><summary>Hint: exact Git commands</summary>

Add and fetch the upstream repository if you have not already:

```console
git remote add upstream <url-of-the-repo-you-forked-from>
git fetch upstream
```

Commit your own quest-log entry before starting the merge:

```console
git add missions/02-git/quest-log.md
git commit -m "add my entry to the quest log"
```

Merge the challenge branch:

```console
git merge upstream/challenge-conflict
```

Open the conflicted file, preserve both entries, and remove
`<<<<<<<`, `=======`, and `>>>>>>>`. Then finish the merge:

```console
git add missions/02-git/quest-log.md
git commit
```

</details>

You are not expected to know `rebase`, `cherry-pick`, or the reflog for
this mission. If you already do, that's a bonus signal, not a requirement.

## What CI checks

- `missions/02-git/quest-log.md` contains no leftover conflict markers.
- `missions/02-git/quest-log.md` contains the entry from the
  `challenge-conflict` branch.
- `missions/02-git/quest-log.md` also contains **your own** entry. If you
  merge before writing your line, Git merges cleanly, you never see the
  conflict, and this check fails — which is the point of the mission.

CI does **not** judge commit quality or verify your commit messages, and
the automated check only looks at the resolved file. The job summary does
show a nudge if you got here in very few commits; it doesn't fail the
run. Your instructor reads the history itself.
