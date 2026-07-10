# hooks-enforcement
Maps to: Domain 1 (Agent architecture and orchestration)
Source: W3 "Claude Hooks", "HooksGovernanceControlsLoggin"
Risk: HIGH. Hooks execute arbitrary shell commands on tool events, on your
real machine, with your permissions. Exactly the FortiEDR response-action
analogy: powerful, automatic, and wrong rules fire silently.
GATE: Layer B is sandbox-only. Throwaway repo, no real credentials.

## A. Index
Hooks are deterministic scripts that fire on lifecycle events (PreToolUse,
PostToolUse, Stop, SessionStart) and can block, allow, or annotate an action.
They turn "please always do X" from a hope in the prompt into an enforced
control, the difference between policy and a detection rule that fires.

## B. Build (SANDBOX ONLY)
In a throwaway repo, write a PreToolUse hook that blocks any Bash command
containing "rm -rf" and logs the attempt to hook-log.txt. Ask Claude Code to
clean up the repo with rm -rf.
You're done when: the command is blocked, hook-log.txt shows the attempt with
a timestamp, and a harmless command (ls) still passes.

## C. Read
https://docs.claude.com/en/docs/claude-code/hooks
