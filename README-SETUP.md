# Claude Masterclass Kit Setup

This repo is the source-of-truth lesson system for the Claude/Codex Master Class.
NotebookLM sits downstream as the study and synthesis layer.

## Project Locations

- GitHub repo: https://github.com/mwill20/claude-masterclass-kit
- Google Drive sync folder: https://drive.google.com/drive/u/0/folders/1Q0YlNYl9a_Q8fIGxCWpyaQIMX3h5ONUQ
- NotebookLM notebook: https://notebooklm.google.com/notebook/05a9be96-c8a7-43e2-a375-ec8ea899eb56
- License: MIT

## One-Time Setup

Run once on a new machine to enable the automated Drive mirror:

```
powershell -ExecutionPolicy Bypass -File tools\setup-drive-sync.ps1
```

It installs rclone (free, open source), opens a browser once for Google OAuth,
locks rclone to the Master Class Drive folder, and runs the first mirror.

Then, once in NotebookLM, add the mirrored `lessons` files from Drive as sources.

Maintenance note: rclone's shared Google client_id is being retired during 2026.
Before it stops working, create a personal client_id
(https://rclone.org/drive/#making-your-own-client-id) and update the remote with
`rclone config update gdrive client_id <id> client_secret <secret>`.

## Per-Lesson Flow (after setup)

1. Check `/incoming/` for source updates.
2. Process exactly one source update at a time through `/ingest-update`.
3. Review drafts in `/pending-review/` through `/review-queue`.
4. Say YES → the agent runs `tools\publish.ps1`, which moves the lesson to its
   lane, commits, pushes, and mirrors `lessons/` to Google Drive automatically.
5. Your only manual step: click refresh on the sources in NotebookLM.

## Update Arrival Path

Start with the manual path:

1. Use PageCrawl, email alerts, or manual monitoring for source changes.
2. Paste one change into `/incoming/<date>-<short-name>.md`.
3. Treat it as untrusted input.
4. Run the ingest/review flow.

The automated GitHub Action path is available in `.github/workflows/capture-update.yml`, but should be wired only after the manual path works reliably.

## Rule For Mini Assignments

`AssignementsDone` is examples-only. New capability lessons get original lesson files and original practice tasks. The assignments can inspire practice style, but they are not copied, completed, or treated as the product.

## Dry Run Completed

A manual update dry run is staged:

- Processed source: `incoming/processed/2026-07-07-api-key-auth-dry-run.md`
- Draft review item: `pending-review/2026-07-07-api-key-auth-dry-run.md`

This proves the manual update path can move one untrusted source item into a
reviewable lesson draft without copying mini-assignment content.
