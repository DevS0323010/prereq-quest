# Prerequisite Quest

Your objective:

> Make all checks green.

Rules:

- Fork this repository.
- Work on your fork.
- Do not modify `.github/workflows/quest.yml`.
- Do not modify test expectations (`app/test.janet`) or mission fixtures just
  to make checks pass, unless a mission explicitly asks you to edit that file.
- Use any tools or references you normally use while developing — Google,
  man pages, Stack Overflow, LLMs, a friend. That's all fair game.
- Understand every change you commit.

Start here:

→ [`QUEST.md`](QUEST.md)

## Installing Janet

Mission 04 runs a small [Janet](https://janet-lang.org/) program. You
have three options, and any of them is fine:

- **Install it locally** — see the
  [Janet install docs](https://janet-lang.org/docs/index.html).
  Package managers carry it too (`brew install janet`,
  `apt install janet`, `pacman -S janet`); versions vary, which doesn't
  matter for this quest.
- **Use Docker instead** — Mission 05 builds an image with Janet in it
  and runs the same `app/main.janet`.
- **Lean on CI** — push and read the Actions output. Slowest feedback
  loop of the three, but it works.

`./scripts/doctor.sh` tells you what you currently have.

Instructors: see [`INSTRUCTORS.md`](INSTRUCTORS.md).
