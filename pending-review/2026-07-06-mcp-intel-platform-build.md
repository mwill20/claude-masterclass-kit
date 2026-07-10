# Draft station: mcp-intel-platform-build
Maps to: Domain 2 (Tool design and MCP integration)
Source: W4 mini project fintrack-mcp-intel (AssignementsDone/Mini_Project Assignment W4/)
Risk: MED. Building a server means you own the tool descriptions, input
validation, and error responses that another agent will trust.

## A. Index
Capstone-grade MCP exercise: a purpose-built intelligence-platform server
(fintrack-mcp-intel) with its own CLAUDE.md, .env.example, and answer sheet.
Already completed once; this station is the rebuild-from-memory rep.

## B. Build
Rebuild one tool from the fintrack-mcp-intel project without looking at the
original: define the tool, its input schema, a structured error response for
bad input, and wire it to Claude Code. Then diff your version against the
completed assignment.
You're done when: the tool answers a live query in-session, malformed input
returns your structured error instead of a stack trace, and the diff shows
you what the original did better.

## C. Read
https://modelcontextprotocol.io/docs/develop/build-server
TODO: confirm this is the current canonical build-a-server doc at review time.
