# Draft station: how-claude-code-works
Maps to: Domain 1 (Agent architecture and orchestration)
Source: W4 "Claude Code's Hidden Architecture", W1 "Foundations and Claude Code Mental"
Risk: LOW

## A. Index
Claude Code is an agentic loop: gather context, plan, act through tools,
read results, repeat until done. Everything else (hooks, subagents, MCP)
plugs into that loop. Knowing the loop tells you where any feature attaches.

## B. Build
In a throwaway repo, give Claude Code one multi-step task ("find every TODO
in this repo and write them to todos.md"). Watch the tool calls it makes and
write down the loop stages you can identify: which calls gathered context,
which acted, which verified.
You're done when: todos.md exists, and your notes name at least 3 distinct
loop stages with the tool call that implemented each.

## C. Read
https://docs.claude.com/en/docs/claude-code/overview
