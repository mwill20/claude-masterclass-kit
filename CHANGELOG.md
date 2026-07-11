# Changelog

Lesson-level history is in `git log` (one commit per lesson, format
`add(domain-N): <station>`). This file tracks system-level changes.

## 2026-07-11

- Responded to Anthropic's certification program split (one cert → four:
  CCAO-F, CCDV-F, CCAR-F, CCAR-P): certification-ladder section added to
  domains.md (lanes unchanged), what's-new station published. Change was
  reported by Michael, not detected by the system.
- Added the detection layer that miss exposed: scheduled monitor Action
  (`.github/workflows/monitor-sources.yml`) diffs watched pages weekly into
  `incoming/` and opens a GitHub issue on change.

## 2026-07-10

- Batch-published 17 reviewed stations; all six lanes now populated
  (19 lessons total).
- Migrated the 2026-07-06 draft set from the pre-rename local repo into the
  review queue; publish tooling extended to parse both draft header formats.
- Documentation pass: root README.md (plain-language), docs/ARCHITECTURE.md,
  docs/LIMITATIONS.md, AGENTS.md, REPO_AUDIT.md, SECURITY.md expanded.

## 2026-07-09

- Publish pipeline automated: `tools/publish.ps1` (approve → lane → commit →
  push → Drive mirror) and `tools/setup-drive-sync.ps1` (one-time rclone +
  OAuth setup). Verified with should-fail and happy-path tests.
- Google Drive mirror configured (rclone remote `gdrive`, folder-pinned).
- First review cycle completed: API-key auth dry-run lesson approved into
  domain-3.

## 2026-07-08

- Repo initialized on GitHub as claude-masterclass-kit (MIT license), manual
  dry run of the incoming → pending-review flow staged.
