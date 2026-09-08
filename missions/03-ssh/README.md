# Mission 03 — SSH

This mission checks whether you can authenticate with SSH and connect to
a remote endpoint. It runs in one of two modes, depending on whether your
instructor has set up a server. Check `missions/03-ssh/server.env`.

## Preferred mode — a real server is configured

If `QUEST_SSH_HOST` in `missions/03-ssh/server.env` is set, connect to it:

```console
ssh -i <path-to-the-key-file> <QUEST_SSH_USER>@<QUEST_SSH_HOST>
```

**Getting the key.** Your instructor distributes it out of band — this
repository does not manage it, and the key is deliberately not committed
here. If you don't have it, ask your instructor; not having it is not
something you can fix from inside the repo, so don't burn time on it.

Once you have the file, save it somewhere you'll remember and point
`ssh` at it with `-i`, as above. On macOS and Linux, SSH refuses to use
a key other people could read, so you may need:

```console
chmod 600 <path-to-the-key-file>
```

On **Windows**, `chmod` doesn't change anything real. If `ssh` complains
that the key file is unprotected or its permissions are too open, move
the key into your `~/.ssh` folder (from Git Bash) and try again. If you
use the built-in Windows OpenSSH from a different shell, restrict the
file to your own user instead:

```console
icacls <path-to-the-key-file> /inheritance:r /grant:r "%USERNAME%:R"
```

This term everyone connects with the same key and sees the same token;
that's expected, not a bug. Once connected, the server prints a short
token and disconnects (you may also see a `PTY allocation request
failed` message — also expected, ignore it).

Record in your profile, under `## Mission 03 — SSH`:

```md
SSH token:

Command I used:
```

**Don't have the key yet?** That's a normal state, not a failure — the
server can be configured before the keys reach everyone. Say so plainly
instead of leaving it blank or guessing:

```md
SSH token: (don't have the key yet — asked my instructor on <date>)

Command I used: (the command I would run, once I have it)

Have you used SSH before? Briefly describe a time you did (or say you
haven't):
```

CI does not check the token either way, so this costs you nothing.

## Fallback mode — no server configured

If `QUEST_SSH_HOST` is empty, there is no server to connect to yet. This
capability is **self-reported and unverified** in that case. Instead,
answer honestly in your profile (`answers/<github-username>.md`):

```md
SSH token: (not applicable — fallback mode)

Command I used: (not applicable — fallback mode)

Have you used SSH before? Briefly describe a time you did (or say you
haven't):
```

CI will not fail this mission in fallback mode — it will simply mark SSH
as unverified in the job summary. That's expected, not a bug.

Do not fabricate a token. An honest "I haven't done this before" is far
more useful to your instructor than a made-up answer.
