# Repository Audit

Audited: 2026-07-10. Project type: educational content system (personal
curriculum) + light automation tooling. Not a software library, dataset, or
model repo, so those standards are marked N/A with reasons.

## Summary

| Area | Status | Priority | Notes |
|------|--------|----------|-------|
| Purpose and audience | FAIL → fixed | High | No root README.md existed; GitHub landing page showed a bare file list. New plain-language README.md added. |
| Installation and quickstart | PARTIAL → fixed | High | Setup lived in README-SETUP.md only; now surfaced in README.md with exact commands. |
| Usage examples | PARTIAL → fixed | High | The day-to-day loop was documented for agents (CLAUDE.md) but not for the human user. README.md now walks it in plain language. |
| Architecture documentation | FAIL → fixed | High | No docs/ARCHITECTURE.md. Added with pipeline diagram and design decisions. |
| Dependencies and environment | PASS | High | Only external tool is rclone (installed by tools/setup-drive-sync.ps1). Scripts are Windows PowerShell 5.1 compatible. No package dependencies. |
| Evaluation and results | N/A | Medium | Content repo, not a measurable system. Lesson quality gate = human review; publish script verified with pass and should-fail cases in-session 2026-07-09. |
| Dataset documentation | N/A | Medium | No dataset. Course source material is referenced by local path, never committed. |
| Model documentation | N/A | Medium | No models trained or shipped. NotebookLM/Claude are downstream consumer tools. |
| Security documentation | PARTIAL → fixed | High | SECURITY.md existed but contained a stale claim (all sync manual); updated to match the automated Drive mirror and expanded with assumptions and threat summary. |
| Deployment documentation | N/A | Medium | Nothing is deployed. The GitHub Action (capture-update.yml) is documented inline and in ARCHITECTURE.md. |
| Monitoring and maintenance | PARTIAL | Medium | One dated maintenance item (rclone shared client_id retires during 2026) documented in README-SETUP.md and LIMITATIONS.md. No other monitoring applies. |
| Limitations and trade-offs | FAIL → fixed | High | No LIMITATIONS doc existed. Added docs/LIMITATIONS.md. |
| License and usage rights | PASS | High | MIT, present, named copyright holder. |
| Support and contact | PARTIAL → fixed | Medium | Now stated in README.md and SECURITY.md (GitHub issues). |
| Visual demo and assets | PARTIAL → fixed | Medium | Text pipeline diagram added to README.md and ARCHITECTURE.md. No image assets; acceptable for a personal content repo. |

## Strengths

- Human approval gate on every lesson, enforced by convention AND by the
  deterministic publish script (no LLM decides what enters the course).
- Untrusted-input framing for incoming content is consistent across
  CLAUDE.md, the ingest command, and the GitHub Action's security notes.
- One-commit-per-lesson history with a fixed message format makes the course
  changelog readable straight from `git log`.
- Every lesson carries its own risk tag from a five-point security pass.

## Missing Files (before this pass)

- README.md (root) — created
- docs/ARCHITECTURE.md — created
- docs/LIMITATIONS.md — created
- AGENTS.md — created (points agent tools at CLAUDE.md)
- CHANGELOG.md — created

## N/A Items and Why (not silently omitted)

- `.env.example` — the repo itself uses no environment variables. The rclone
  credential lives in rclone's own config outside the repo; the monitor PAT
  lives in the monitor's config. Documented in SECURITY.md.
- `requirements.txt` / packaging — no code dependencies; tooling is two
  PowerShell scripts using git and rclone.
- `tests/`, CI test workflow — content repo. The publish script was verified
  with happy-path and should-fail cases in-session (2026-07-09); a standing
  test suite would test git itself, not project logic.
- `docs/DATASET.md`, `docs/MODEL_CARD.md`, `docs/DEPLOYMENT.md` — no dataset,
  no model, nothing deployed.
- `CONTRIBUTING.md`, `CITATION.cff` — single-owner personal learning repo, no
  external contributors or research publication intent.
- `Lessons/00_Index.md` layout — the kit's own `lessons/<lane>/` tree is the
  canonical layout (locked in CLAUDE.md); lessons/README.md serves as index.

## Remaining Gaps

1. `docs/threat-models/THREAT_MODEL.md` — SECURITY.md now carries a threat
   summary table, but the full framework-selected threat model (per the
   /threat-model procedure) has not been produced. TODO.
2. Station drafts from 2026-07-06 keep their original compact format
   (`Maps to:` headers) rather than the kit header block. Cosmetic; publish
   tooling handles both.
3. ~~Monitor wiring deliberately not wired yet~~ — RESOLVED 2026-07-11: an
   in-repo weekly monitor Action (monitor-sources.yml) now watches
   monitoring/sources.txt and writes changes into incoming/. The external
   changedetection.io path is no longer needed; capture-update.yml remains
   as an optional webhook entry point.

## Priority Fix Order (executed this pass)

1. Root README.md in plain language
2. SECURITY.md stale-claim fix + threat summary
3. docs/ARCHITECTURE.md
4. docs/LIMITATIONS.md
5. AGENTS.md, CHANGELOG.md, lessons index refresh
