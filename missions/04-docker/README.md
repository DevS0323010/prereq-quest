# Mission 04 — Docker

The `Dockerfile` at the repository root is broken. `docker build` will
succeed — the image builds fine — but `docker run` will not behave.

## Task

```console
docker build -t prereq-quest .
docker run --rm prereq-quest
```

The container should print exactly:

```text
hello, world
42
```

It won't, at first. Read the error `docker run` gives you, then read the
`Dockerfile`. The problem is small — a path mismatch, not a missing tool.

This mission depends on Mission 05 being fixed first: the container runs
the same `app/main.janet` that mission 05 asks you to debug, so make sure
that's correct before you spend time here.

## Record your answer

In your profile, under `## Mission 04 — Docker`:

```md
What was wrong:

What I changed:
```

## What CI checks

- `docker build` succeeds.
- `docker run --rm prereq-quest` prints exactly `hello, world` then `42`.

No Docker Compose, no multi-container setup — just a build and a run.
