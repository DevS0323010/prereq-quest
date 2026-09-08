# Mission 05 — Debug an unfamiliar project

This is the important one.

`app/main.janet` is a very small program written in
[Janet](https://janet-lang.org/), a language you have almost certainly
never used. That's on purpose — this mission isn't testing whether you
know Janet, it's testing whether you can read a small amount of
unfamiliar code, run it, and reconcile what it does with what it should
do.

You do not need a Janet tutorial to do this. You need to run the program,
read the output, read the ~25 lines of source, and think.

## Task

Run the program:

```console
janet app/main.janet Brian
```

You should see:

```text
hello, Brian
42
```

You won't, at first. One of the numbers will be wrong. Find out why and
fix it.

Then run the tests:

```console
janet app/test.janet
```

or use the local checker:

```console
./scripts/check.sh
```

Don't have Janet installed? See the root `README.md` for install
options. If installing it isn't practical for you, push your fix and let
GitHub Actions run the tests — it installs Janet itself. (Mission 04's
container runs this same file, but only if you have Docker, so that's
not a way around a missing Janet unless you already had Docker anyway.)

## Record your answer

In your profile, under `## Mission 05 — Debug`:

```md
What was wrong:

What I changed:
```

## What CI checks

- `janet app/test.janet` exits successfully.

That's it. The tests are the specification here — don't edit
`app/test.janet` to make it agree with broken code. If a test looks
wrong to you, say so in your profile instead of changing it.
