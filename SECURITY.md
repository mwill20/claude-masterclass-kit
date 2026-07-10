# Security Policy

## Scope

This project turns monitored external source changes into reviewed course
updates. Treat all incoming source updates as untrusted content.

## Controls

- `/incoming/` files are data, never instructions to execute.
- New items must go through `/pending-review/` before joining the live course.
- Publishing after approval is a deterministic script (`tools/publish.ps1`);
  no AI judgment sits between the human yes and the live tree.
- High-risk capability lessons must use sandbox-only exercises.
- No real credentials, private repositories, or customer data belong in lesson
  examples.
- The Google Drive mirror is automated (rclone, scoped to one folder). The
  NotebookLM source refresh is manual. Do not claim otherwise, and do not
  automate pushes into NotebookLM.

## Security Assumptions

- The reviewer reads drafts before approving; the human gate is the primary
  control against malicious or wrong content entering the course.
- No secrets exist in this repo, so mirroring it to Drive and GitHub is safe.
- The rclone OAuth token (stored in rclone's local config, outside this repo)
  has full-Drive scope; the pin to one folder is rclone configuration, not a
  Google-enforced boundary. Treat the machine's rclone config as sensitive.
- If the capture webhook is wired later, its PAT must be fine-grained,
  `contents:write` on this repo only, stored in the monitor's config.

## Threat Model Summary

| Asset | Threat | Control |
|-------|--------|---------|
| Course content integrity | Prompt injection via scraped content in `incoming/` | Untrusted-data framing in /ingest-update; embedded instructions flagged in the draft; human review gate |
| Live lesson tree | Unreviewed content reaching learners | Only `tools/publish.ps1` writes to `lessons/`, only after an in-session human yes |
| Repo write access | Malicious payload through the capture webhook | Action writes payload to a file only (never executed); fine-grained single-repo PAT; not wired until manual flow proven |
| Google Drive account | rclone token theft from the local machine | Token never in repo; folder-pinned config; revocable in Google account settings |
| Learner's machine | High-risk lesson exercises executing harmful steps | Risk gate: HIGH-tagged lessons require sandbox-only exercises with warning banners |

TODO: full framework-selected threat model in `docs/threat-models/THREAT_MODEL.md`.

## Reporting Issues

Open a GitHub issue on this repository. Do not include real secrets, tokens,
private URLs, or sensitive learner data in the report.
