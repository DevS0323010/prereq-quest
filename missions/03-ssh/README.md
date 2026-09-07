# Mission 03 — SSH

This mission checks whether you can get a shell on another machine and do
something useful once you're there. It runs in one of two modes,
depending on whether your instructor has set up a server. Check
`missions/03-ssh/server.env`.

## Preferred mode — a real server is configured

If `QUEST_SSH_HOST` in `missions/03-ssh/server.env` is set, connect to it:

```console
ssh <QUEST_SSH_USER>@<QUEST_SSH_HOST>
```

You'll need credentials or a key from your instructor — this repository
does not manage that for you. Once connected, the server will print (or
otherwise expose) a short token tied to your account.

Record in your profile, under `## Mission 03 — SSH`:

```md
SSH token:

Command I used:
```

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
