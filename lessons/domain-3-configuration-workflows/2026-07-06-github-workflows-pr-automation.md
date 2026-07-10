# github-workflows-pr-automation
Maps to: Domain 3 (Claude Code configuration and workflows)
Source: W6 "GitHub Workflows & PR Automation" (both PDFs)
Risk: HIGH. CI-resident agents run with repo write tokens on
attacker-influenceable input (issue text, PR bodies). Scope tokens
minimally and treat inbound text as untrusted.
GATE: Layer B is sandbox-only. Private throwaway repo, default-scoped
GITHUB_TOKEN, no org secrets.

## A. Index
Claude Code runs headless in CI (the -p flag and the official GitHub Action)
to review PRs, triage issues, and ship small fixes on @claude mentions. The
agent becomes a workflow step with a token, so pipeline permissions ARE the
security model.

## B. Build (SANDBOX ONLY)
In a private throwaway repo, wire the Claude Code GitHub Action so that
@claude on an issue produces a PR. File an issue describing a one-line
README fix and mention @claude.
You're done when: the Action run succeeds, a PR appears implementing the fix,
and you can state exactly which permissions the workflow token had.

## C. Read
https://docs.claude.com/en/docs/claude-code/github-actions
