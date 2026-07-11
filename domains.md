# CCA-F Domain Snapshot - THE spine of the skill tree

WHY THIS FILE EXISTS: the CCA-F domain definitions originate in a
third-party repo (github.com/paullarionov/claude-certified-architect)
that we do not control. It could restructure, go private, or drift from
the actual exam. So we snapshot the definitions HERE, pin the commit we
copied from, and treat this file as authoritative. Monitoring covers BOTH
kinds of change: domain drift inside the snapshot AND program-level
restructures above it (new certs, renamed paths, split tracks). Either
kind produces a review-queue item, never an automatic edit to this file.

## Snapshot metadata
- Source repo: https://github.com/paullarionov/claude-certified-architect
- Pinned commit: 2c08dbdddbb9da4c7c9a6d68d68a9f916c11e760
- Snapshot date: 2026-07-07

## The 5 domains (lanes)
These lanes are snapshotted from the pinned guide commit. Scope notes are
local working summaries for lesson routing.

### Domain 1: Agent architecture and orchestration (27%)
Agent loops, coordinator/subagent patterns, tool permissions, handoffs,
human escalation, and safe autonomy boundaries.

### Domain 2: Tool design and MCP integration (18%)
Tool descriptions, input schemas, MCP servers/resources, error handling,
read-only vs write tools, and external system trust boundaries.

### Domain 3: Claude Code configuration and workflows (20%)
CLAUDE.md, project commands/skills, hooks, planning mode, headless runs,
CI/CD review workflows, and repository operating rules.

### Domain 4: Prompt engineering and structured output (20%)
System prompts, few-shot examples, JSON schemas, structured extraction,
normalization, validation, and avoiding unsupported claims.

### Domain 5: Context management and reliability (15%)
Context-window strategy, summarization, passing context to subagents,
retry/error paths, degraded modes, and production handoff safety.

## Certification ladder (added 2026-07-11, Michael's ruling)

Anthropic's program is now four certifications (verified on Pearson VUE
2026-07-10). This course treats them as a progression where each rung builds
on the previous. HONESTY NOTES: (a) the ladder ordering is a LOCAL
learning-path decision; Anthropic officially frames these as role tracks
(Practitioner / Developer / Architect), not a mandated sequence. (b) Official
per-cert exam domain lists are unpublished; mappings below are provisional
until they land (the monitor Action watches for that).

| Rung | Cert | Lanes serving it |
|---|---|---|
| 1 | CCAO-F - Associate, Foundations | TODO: official domains unpublished. Provisional: lanes 3, 4 |
| 2 | CCDV-F - Developer, Foundations | TODO: official domains unpublished. Provisional: lanes 2, 3, 4 |
| 3 | CCAR-F - Architect, Foundations | Lanes 1-5 (direct successor of the CCA-F this snapshot pins) |
| 4 | CCAR-P - Architect, Professional | TODO: official domains unpublished. Provisional: lanes 1, 5 deepened |

Eligibility note: Pearson VUE states the program is partner-network
restricted. Individual path: NEEDS VERIFICATION.

## Lane 6 - "What's New" (staging)
Not an exam domain. Holds unmapped new developments per the graduation
rule in CLAUDE.md.

## Known personal gaps (seed the priority order)
- MCP server internals
- Context management at scale
New content mapping to these gets flagged PRIORITY in review-queue items.
