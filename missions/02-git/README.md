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
branch called `challenge-conflict`. It contains a small, harmless edit
that will conflict with something you were asked to edit in this mission.

1. Add the upstream repository as a remote, if you haven't already:

   ```console
   git remote add upstream <url-of-the-repo-you-forked-from>
   git fetch upstream
   ```

2. Open `missions/02-git/quest-log.md` and replace the placeholder entry
   line with your own, then commit it:

   ```console
   git add missions/02-git/quest-log.md
   git commit -m "add my entry to the quest log"
   ```

3. Merge the upstream branch into your current branch:

   ```console
   git merge upstream/challenge-conflict
   ```

   Git will report a conflict in `missions/02-git/quest-log.md`, because
   both sides edited the same line.

4. Open the file, resolve the conflict by hand, remove the conflict
   markers (`<<<<<<<`, `=======`, `>>>>>>>`), and make sure **both**
   entries — yours and the one from `challenge-conflict` — end up in the
   file. Then finish the merge:

   ```console
   git add missions/02-git/quest-log.md
   git commit
   ```

You are not expected to know `rebase`, `cherry-pick`, or the reflog for
this mission. If you already do, that's a bonus signal, not a requirement.

## What CI checks

- Your repository has more than one commit.
- `missions/02-git/quest-log.md` contains no leftover conflict markers.
- `missions/02-git/quest-log.md` still contains the entry from the
  `challenge-conflict` branch.

CI does **not** try to verify your commit messages word-for-word, and it
does not check *how* you resolved the conflict — only the result.
