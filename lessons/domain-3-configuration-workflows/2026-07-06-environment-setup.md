# environment-setup
Maps to: Domain 3 (Claude Code configuration and workflows)
Source: W0 "Claude Code - Environment Setup Instructions"
Risk: LOW

## A. Index
Install, authenticate, and verify Claude Code; know where its three config
layers live (user ~/.claude/, project .claude/, directory) before touching
any of them. A working `claude` in a real repo is the prerequisite for
everything else in this tree.

## B. Build
On a clean machine or fresh user profile, install Claude Code, authenticate,
and open it inside a small real repo. Run one file edit and one Bash command
through it.
You're done when: `claude --version` prints, the edit shows in `git diff`,
and you can name the file where user-level settings live.

## C. Read
https://docs.claude.com/en/docs/claude-code/setup
