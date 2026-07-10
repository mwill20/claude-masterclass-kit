# Draft station: skills-and-plugins
Maps to: Domain 3 (Claude Code configuration and workflows)
Source: W5 "Skills and Plugin Architecture", "Claude Skills Architecture Summary Week5"
Risk: MED. Skills and plugins are versioned third-party code that shapes
agent behavior: classic supply-chain surface. Pin versions, read before
installing, prefer your own.

## A. Index
Skills are folders with a SKILL.md (frontmatter tells Claude when to use it,
body tells it how) that load on demand instead of bloating every session.
Plugins bundle skills, commands, agents, and MCP servers into one
installable, versionable unit.

## B. Build
Turn a workflow you repeat weekly into a skill: write SKILL.md with a
trigger description and step-by-step body, drop it in ~/.claude/skills/,
and invoke it in a fresh session by describing the task without naming
the skill.
You're done when: Claude picks the skill unprompted (check the transcript
for the skill invocation), and the output matches your documented steps.

## C. Read
https://docs.claude.com/en/docs/claude-code/skills
