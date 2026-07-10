# context-fundamentals
Maps to: Domain 5 (Context management and reliability)
Source: W1 "Claude Code / Context 1"
Risk: LOW

## A. Index
The context window is working memory with hard limits and soft failure:
overflow triggers compaction, middles get lost, and stale context quietly
outweighs new instructions. Managing what enters context is the highest
leverage reliability move.

## B. Build
In a session on a real repo, work until context is meaningfully consumed,
then ask Claude Code to state the current task constraints from the start of
the session. Compare its answer against what you actually said. Then run
/compact and repeat the question.
You're done when: you have a before/after note of what survived compaction
and one rule you will adopt (what belongs in CLAUDE.md vs chat because of it).

## C. Read
https://docs.claude.com/en/docs/build-with-claude/context-windows
