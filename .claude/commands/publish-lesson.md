# /publish-lesson — Run the deterministic publish pipeline for one approved draft

PRECONDITION: Michael said YES to this draft in this session (via /review-queue
or directly). His in-session yes IS the authorization. Never run this command
without it. Never batch-publish.

## What it does

Everything downstream of the approval is a script, not judgment:

```
powershell -ExecutionPolicy Bypass -File tools\publish.ps1 -Draft <filename>
```

The script:
1. Rewrites the draft header from "pending review" to "approved <date>".
2. Moves it from /pending-review/ into the lane it declares (`- Lane:` line),
   e.g. lessons/domain-3-configuration-workflows/.
3. Commits with the mandated format: "add(domain-N): <station>".
4. Pushes to GitHub.
5. Mirrors lessons/ to the Google Drive folder via rclone (skips with a
   warning if rclone is not set up — run tools/setup-drive-sync.ps1 once).
6. Prints the one remaining manual step: refresh NotebookLM sources.

## Variants

- Declined item:  `tools\publish.ps1 -Draft <file> -Decline`
  (moves to /pending-review/declined/, commits the record)
- Updated station (not new): add `-Update` → commit says "update(domain-N): ...".
- Preview without acting: add `-DryRun`.

## Agent rules

- Report the script output to Michael, including any SKIPPED/FAILED lines.
- If the script fails, stop and show the error. Do not improvise file moves,
  commits, or pushes by hand — the script is the pipeline.
- After success, remind Michael of the single NotebookLM refresh click.
