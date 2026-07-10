# commands-workflow-automation
Maps to: Domain 3 (Claude Code configuration and workflows)
Source: W3 "Type one command Ship entire workflow", "The SDLC just got rebuilt by AI"
Risk: MED. A slash command is stored prompt injection by design: whatever
the file says, the agent does. Review command files like you review
playbook definitions before enabling them.

## A. Index
Custom slash commands are markdown files in .claude/commands/ that package a
whole workflow behind one typed command. Repeatable process plus arguments
in, consistent multi-step execution out. The SOAR playbook of Claude Code.

## B. Build
Write a /preflight command for one of your repos: run the test suite, check
git status, and summarize what would ship. Run it twice, once clean and once
with a deliberately broken test.
You're done when: both runs finish, the broken run clearly reports the
failure, and the command file reads like a checklist a human could follow.

## C. Read
https://docs.claude.com/en/docs/claude-code/slash-commands
