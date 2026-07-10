# Limitations

## Known limitations

- **NotebookLM refresh is manual.** There is no supported API, so after every
  approved lesson (or batch), someone has to click refresh in the notebook.
  The system is designed around this: it is one click, not a workflow.
- **Update capture is not wired.** New Anthropic changes arrive only when a
  human pastes them into `incoming/`. The GitHub Action exists but has no
  monitor pointed at it yet, so the course only updates when prompted.
- **Lessons are deliberately skeletal.** The 3-layer model (index, exercise,
  doc link) is a map, not a textbook. Anyone expecting full prose chapters
  will find the stations thin; depth lives in the linked official docs and
  the hands-on exercise.
- **Windows-only tooling.** Both scripts are PowerShell 5.1. Publishing from
  macOS/Linux means doing the file move, commit, push, and rclone sync by
  hand (the steps are in the script comments).
- **Single-user design.** One reviewer, one Drive account, one notebook. No
  roles, no multi-user review, no conflict handling for concurrent edits.
- **Drive token scope is wider than the folder.** rclone holds a full-Drive
  OAuth token; the pin to one folder is rclone configuration, not a Google-
  enforced boundary. See SECURITY.md.

## Failure modes

- rclone's shared client_id retires during 2026; syncs will start failing
  until a personal client_id is configured (instructions in README-SETUP.md).
- If a draft is missing its lane header (`Lane:` or `Maps to:` line), the
  publish script stops and asks for `-Lane` explicitly. It does not guess.
- If Drive sync fails after a push, GitHub is still correct; rerun
  `rclone sync lessons gdrive:lessons`. GitHub is the source of truth.
- The domains.md snapshot can drift from the live certification guide. Drift
  is surfaced as a review item, never auto-applied.

## Assumptions

- The reviewer reads drafts before saying yes; the gate is only as good as
  the review.
- The machine running the tools has git and GitHub access as mwill20.
- Lesson content contains no secrets, so mirroring to Drive is safe.

## When not to use this project

- As a shared team knowledge base (single-user design).
- As a source of authoritative Anthropic documentation (lessons link to
  docs; they do not replace them).
- As a template for compliance-grade content pipelines (the approval gate is
  conversational, not cryptographically enforced).

## Future work

- Wire changedetection.io to the capture Action once the manual loop has run
  for a few real updates.
- Personal rclone client_id before the shared one retires.
- Full threat model in docs/threat-models/ (summary currently in SECURITY.md).
