# Instructor guide

This repository is a diagnostic, not an exam. It exists to give you a
practical read on incoming students' developer tooling before the term
starts, so you can calibrate early lectures/labs instead of guessing.

Do not reduce its output to a single pass/fail score. Look at:

- the repository state (did the checks go green, and if not, where)
- the Actions job summary (the capability table)
- commit history (shape of the work, not just the final diff)
- the student's own explanations in `answers/<username>.md`
- their self-reported experience (Mission 00), read *against* what was
  actually observed, not instead of it

Self-report and observation disagreeing is itself useful information —
a student who says they've never used Docker but sails through Mission
04 learns fast; one who claims confidence but can't get the container
running may be overestimating themselves, or may just be having an off
day. Either way, that's a conversation, not a grade.

## Capability dimensions

| Dimension | What it's measuring |
|---|---|
| Git | commits, forks, remotes, merge conflicts |
| Linux | filesystem navigation, hidden files, paths |
| Shell | pipes, redirection, composing commands |
| SSH | connecting to a remote machine |
| Docker | reading a Dockerfile, build/run, basic image debugging |
| Debugging | forming a hypothesis from an error and testing it |
| Code reading | understanding unfamiliar code well enough to fix it |
| Development workflow | committing in logical chunks, using CI feedback |
| Independence / exploration | Mission 06 — what they notice and choose to fix |

Rough levels, for calibration only — do not compute one automatically:

```text
L0 - unfamiliar with basic developer tooling
L1 - can clone/edit/commit/push and run straightforward commands
L2 - comfortable navigating Linux and diagnosing simple failures
L3 - can handle Git conflicts, SSH, Docker, and unfamiliar projects
L4 - demonstrates strong debugging and development workflow
L5 - proactively improves tooling or identifies underspecified problems
```

A student can be L3 on Docker and L1 on Git in the same submission. That
inconsistency is expected and is exactly what the per-dimension table is
for.

## Setting this up for a cohort

1. **Push this repository** to wherever students will fork it from
   (an org repo, a template repo, etc.).

2. **Create the `challenge-conflict` branch** on the *upstream* repo
   (not on student forks) before students start:

   ```console
   git checkout -b challenge-conflict
   ```

   then edit `missions/02-git/quest-log.md`, replacing the placeholder
   line with:

   ```md
   - torch-bearer: left a spare torch by the door
   ```

   Commit and push that branch. This repository already ships that
   branch locally if you cloned/received it with full history — verify
   with `git branch -a` and push it explicitly if it's missing on the
   remote (`git push origin challenge-conflict`). `scripts/check.sh`
   and the CI workflow both check for the resulting text and will tell
   you immediately if the branch content ever drifts from this.

3. **Decide whether to wire up Mission 03 (SSH) for real.** If you have
   a course server that can print a per-user token to anyone who
   connects, set `QUEST_SSH_HOST` (and `QUEST_SSH_USER` if needed) in
   `missions/03-ssh/server.env` on the upstream repo *before* students
   fork it, so it carries over. If you don't, leave it blank — the
   mission runs in fallback mode and SSH is reported as unverified
   everywhere. This repository intentionally does not implement
   automated SSH-session verification; it only tells students where to
   put the configuration once you build that piece separately.

4. **Do not commit a solved version of any mission** to the branch
   students fork from. Verify the starter state is genuinely broken
   (Mission 04's Dockerfile, Mission 05's arithmetic bug) by running
   `./scripts/check.sh` yourself on a clean checkout before publishing.

5. Students should not need to touch `.github/workflows/quest.yml`. If
   you change it, make sure `./scripts/check.sh` still means the same
   thing the workflow checks, since students will be using it as their
   fast local feedback loop.

## Reading results

- A green Actions run means every automatable check passed. It does not
  mean the student understands everything — read `answers/<username>.md`
  and the commit history for that.
- A red run with a clear commit history and a thoughtful `answers/`
  writeup explaining what's still broken is a *better* signal than a
  green run with one squashed commit and empty answer fields.
- Mission 06 has no canonical answer. CI only checks that an explanation
  exists. The content is entirely for you to read.
