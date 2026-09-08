# Mission 05 — Docker

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
`Dockerfile`.

<details><summary>Hint</summary>

Compare the paths used by `WORKDIR`, `COPY`, and `CMD`.

</details>

The `Dockerfile` bug is independent of Mission 04's, so you can find and
fix it on its own. But this container runs the same `app/main.janet`
that Mission 04 asks you to debug, so the output won't be fully correct
until that one is fixed too — don't be surprised by a `41` if Mission 04
is still outstanding.

**No Docker on your machine?** Installing it can be a real project of
its own (Docker Desktop, WSL2, BIOS virtualization, admin rights). If
that's where you are, fix the `Dockerfile` by reading it, push, and let
GitHub Actions build and run it for you — the runner already has Docker.
Say so in your profile. Reasoning your way to the fix is the skill being
measured here; running it locally is convenience.

## Record your answer

In your profile, under `## Mission 05 — Docker`:

```md
What was wrong:

What I changed:
```

## What CI checks

- `docker build` succeeds.
- `docker run --rm prereq-quest` prints exactly `hello, world` then `42`.

No Docker Compose, no multi-container setup — just a build and a run.
