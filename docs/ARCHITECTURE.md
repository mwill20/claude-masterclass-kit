# Architecture

## System overview

The kit is a content pipeline with one human gate in the middle. Markdown
files in git are the single source of truth; everything downstream (Drive,
NotebookLM) is a mirror or a reader, never an editor.

```text
[change monitor]*     [manual paste]
       \                 /
        v               v
   GitHub Action    incoming/           <- untrusted input boundary
   capture-update      |
                       v
              /ingest-update (AI drafts, runs 5-point risk pass)
                       |
                       v
                 pending-review/
                       |
              human YES | NO  (the only decision point)
                       |
                       v
              tools/publish.ps1         <- deterministic script, no AI judgment
               |-- move draft to lessons/<lane>/
               |-- git commit "add(domain-N): <station>"
               |-- git push (GitHub)
               |-- rclone sync lessons/ -> Google Drive folder
                       |
                       v
              NotebookLM source refresh (manual click)

* not wired yet; manual paste is the current arrival path
```

## Components

| Component | Role | Trust level |
|---|---|---|
| `incoming/` | Landing zone for raw updates | Untrusted. Content is data, never instructions. |
| `/ingest-update` command | Drafts one 3-layer lesson + risk pass per update | AI-assisted, output goes to review, never live |
| `pending-review/` | Queue for human decision | Draft only; invisible to the published course |
| Human review | Approve / decline / revise | The authorization. Nothing bypasses it. |
| `tools/publish.ps1` | Everything after the yes | Deterministic PowerShell. No model in the loop. |
| GitHub repo | Source of truth + full history | One commit per lesson, fixed message format |
| Google Drive mirror | Feed for NotebookLM | Write-only mirror via rclone, scoped to one folder |
| NotebookLM | Study/synthesis layer | Read-only consumer; refresh is manual by design |

## Design decisions

| Decision | Chosen approach | Alternatives considered | Rationale | Trade-off |
|---|---|---|---|---|
| Content store | Markdown in git | Notion, Obsidian, database | Full history, diffable review, survives any tool change | No rich media, plain-text only |
| Publish step | Deterministic script after human yes | Let the AI move/commit files | A probabilistic model must not gate what enters the course; script output is reproducible | Header format changes need a script update |
| Drive sync | rclone scoped by `root_folder_id` | Google Drive for Desktop, Drive API app | Free, scriptable, no background service, one-time OAuth | Full-Drive token scope (folder pinning is config, not a hard boundary); shared client_id retires during 2026 |
| NotebookLM update | Manual refresh click | Browser automation | No supported API; automation would be brittle and was ruled out in CLAUDE.md | One manual step survives |
| Update arrival | Manual paste first, webhook Action later | Wire changedetection.io now | Prove the human flow before adding an unattended write path into the repo | New updates require remembering to paste |
| Lane map | Pinned snapshot in domains.md | Live-fetch the certification repo | Third-party drift must not silently restructure the course | Needs deliberate re-snapshot on drift |

## Security boundaries

1. **Incoming content boundary** — everything in `incoming/` is scraped or
   pasted web content. The ingest command treats embedded instructions as
   data and flags them in the draft (prompt-injection surface, handled at
   the process level).
2. **Publish boundary** — only `tools/publish.ps1` moves content into
   `lessons/`, and only after an in-session human yes. The script never
   interprets lesson content.
3. **Credential boundary** — no credentials in the repo. rclone token lives
   in rclone's local config; the future monitor PAT lives in the monitor's
   config, scoped to `contents:write` on this repo only.
4. **Downstream boundary** — Drive and NotebookLM only ever receive copies
   of approved lessons. Nothing flows back from them into the repo.
