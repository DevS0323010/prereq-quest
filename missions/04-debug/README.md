# Mission 04 — Debug an unfamiliar project

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

Don't have Janet installed? Run `./scripts/doctor.sh` for install guidance,
or build/run the project inside Docker (Mission 05) instead — the same
source file is used there.

## Record your answer

In your profile, under `## Mission 04 — Debug`:

```md
What was wrong:

What I changed:
```

## What CI checks

- `janet app/test.janet` exits successfully.

That's it. The tests are the specification here — don't edit
`app/test.janet` to make it agree with broken code. If a test looks
wrong to you, say so in your profile instead of changing it.
