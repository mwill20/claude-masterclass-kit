# MCP Fundamentals: Connect Claude to External Tools

- Source file: `incoming/processed/2026-07-09-mcp-fundamentals.md`
- Captured: 2026-07-09
- Lane: Domain 2 - Tool design and MCP
- Station: MCP fundamentals
- Risk: MED
- Status: approved 2026-07-10

## Why This Maps Here

This is the entry station for the MCP lane: what the protocol is, how a tool
call actually flows, and how to connect a first server safely. Domain 2 covers
tool design and MCP, and nothing else in that lane exists yet, so this becomes
its foundation. The build exercise uses a real read-only integration, which
sets the least-privilege habit before any write-capable station arrives.

## ClawGuard Risk Pass

- Agentic wallet / payment surface exposure: none.
- Machine-readable content injection risk: medium. Tool manifests and tool
  responses are machine-readable content that enters Claude's context. A
  malicious or compromised server can plant instructions there.
- Shell/code execution surface: medium. stdio servers are local processes
  spawned by Claude Code; whatever the process can touch, the server can touch.
- Versioned skill/plugin supply-chain risk: medium. Unvetted or floating
  "latest" MCP servers are a supply-chain surface. The exercise pins to the
  official GitHub MCP endpoint only.
- Agent-to-agent / agent search discovery risk: none at this station.

Risk gate: MED. Warning banner on the station. The exercise uses a read-only
fine-grained token and removes the server at the end.

## Draft Station

> âš ï¸ MED risk: connecting any MCP server gives Claude live access to an
> external system. Use a read-only token created just for this exercise and
> remove the server when you finish.

### Layer A - Index

MCP is one standard protocol for connecting Claude to external tools, APIs,
and databases, so no tool needs custom integration code. Claude reads each
server's tool manifest, emits typed JSON tool calls, and gets structured
responses back. Servers run as local processes (stdio) or remote HTTP
endpoints, and every credential stays in environment variables, never in
config files.

### Layer B - Build

Connect Claude Code to GitHub through MCP with read-only access:

1. Create a fine-grained GitHub personal access token with only
   Contents: Read, Issues: Read, and Pull requests: Read. Nothing else.
2. Put it in an environment variable (`GITHUB_MCP_TOKEN`). Do not write it
   into any file in the repo.
3. Register the server:
   `claude mcp add --transport http github https://api.githubcopilot.com/mcp/ --header "Authorization: Bearer $GITHUB_MCP_TOKEN"`
4. Run `claude mcp list`, then inside Claude Code run `/mcp`.
5. Ask Claude: "List the open issues in <one of your repos>." Watch which
   tool it picks (`mcp__github__...`) and what comes back.
6. Clean up: `claude mcp remove github` and revoke the token on GitHub.

You're done when:
- `claude mcp list` shows github as connected.
- The issue question returns real data from your repo through an
  `mcp__github__` tool.
- Searching your repo for the token string finds nothing
  (`git grep <first 8 chars of token>` returns no hits).

### Layer C - Read

- MCP protocol documentation: https://modelcontextprotocol.io
- Claude Code MCP guide: https://docs.claude.com/en/docs/claude-code/mcp
