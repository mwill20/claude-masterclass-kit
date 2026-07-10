# large-repo-context-scaling  [PRIORITY: known personal gap]
Maps to: Domain 5 (Context management and reliability)
Source: W4 "Session 7 Large Repo Strategies & Context Scaling", "Session7_HandsOn_Lab_ShopFlow"
Risk: LOW

## A. Index
Big codebases do not fit in context, so the strategies are: targeted search
instead of bulk reads, subagents that explore and return conclusions,
scratchpad files as durable memory, and CLAUDE.md as the standing map.
Read less, route better.

## B. Build
Rerun the ShopFlow lab pattern on a large repo you did not write: forbid
yourself from pasting files. Use search plus one explore subagent to answer
"where does X happen and what would break if I changed it", writing findings
to a scratchpad file as you go.
You're done when: the answer names specific files and call paths, the
scratchpad reconstructs your reasoning, and main-session context stayed
below compaction.

## C. Read
https://docs.claude.com/en/docs/claude-code/common-workflows
