# subagents-multi-agent
Maps to: Domain 1 (Agent architecture and orchestration)
Source: W5 "Subagents & Multi-Agent Collaboration" (both PDFs)
Risk: MED. Subagents multiply the shell/exec surface: each spawned agent
inherits tool access. Scope agent tool lists deliberately (least privilege,
same principle as service-account scoping).

## A. Index
Subagents are separate context windows with their own system prompt and tool
allowlist, dispatched for focused work (explore, review, plan) so the main
context stays clean. Coordinator keeps state; workers return conclusions,
not transcripts.

## B. Build
Create a custom subagent in .claude/agents/ that is read-only (no Edit,
Write, or Bash) and prompt the main session to use it to summarize your
repo's structure. Then try to make the subagent edit a file.
You're done when: the summary comes back to the main session, and the edit
attempt is refused because the tool is not in the subagent's allowlist.

## C. Read
https://docs.claude.com/en/docs/claude-code/sub-agents
