# Source Update: MCP Fundamentals (course seed)

- Source: Week 4 Session 2 deck, "Model Context Protocol (MCP) Integration"
  (local course material: Week4/Model Context Protocol (MCP) Integration.pdf)
- Captured: 2026-07-09
- Type: course-seeded capability, not a monitored-source diff

## What the source covers

- MCP is an open protocol that connects Claude to external tools, APIs, and
  databases through one standard instead of per-tool custom integrations.
- Core concepts: server URL, tool, tool manifest, tool call. Claude reads the
  manifest at session start and emits typed JSON tool calls; the server
  executes and returns structured responses.
- Request flow: prompt -> Claude scans manifest -> picks tool -> typed JSON
  call to the MCP server -> external API responds -> Claude synthesizes.
- Server transports: stdio (local process), HTTP (remote, recommended),
  SSE (deprecated), WebSocket (server-push cases).
- Configuration: .mcp.json at project root (team-shared) or user scope.
  Prefer `claude mcp add` over hand-editing. Verify with `claude mcp list`
  and /mcp. Tools appear as mcp__<server>__<tool>.
- Setup walkthrough: fine-grained GitHub PAT (read-only scopes), token via
  environment variable only, register with
  `claude mcp add --transport http github <url> --header "Authorization: Bearer $TOKEN"`.
- Security patterns: credential isolation (env vars, never in CLAUDE.md or
  settings), least-privilege tokens (read-only first, separate read vs write
  servers), audit logging of every tool call into the SIEM, network
  allowlisting (treat MCP servers like database connections, no production
  access).
- Anti-patterns: tokens in settings files, no audit logging, PII in tool
  responses, unapproved servers (exfiltration risk), overprivileged tokens,
  MCP from production boxes.
- Enterprise governance: approved server registry with version pinning,
  permission tiers (read-only / read-write / admin / break-glass), data
  sensitivity rules, change management.
