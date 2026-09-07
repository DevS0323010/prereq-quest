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

This mission runs the `app/main.janet` program fixed in Mission 04, so
complete that mission first.

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
