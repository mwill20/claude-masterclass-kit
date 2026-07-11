# Claude Masterclass Kit

A personal, self-updating study library for mastering Claude Code. It turns
course material and Anthropic product news into short, reviewed lessons, and
keeps everything organized, backed up, and ready to study.

## What this is, in plain terms

Think of it as a textbook that maintains itself:

- **The library** (`lessons/`): every topic lives on one of six shelves. Five
  shelves are competency areas drawn from the Claude certification program
  (now four certifications; see the ladder in `domains.md`). The sixth shelf
  holds new topics that do not fit anywhere yet.
- **The mailroom** (`incoming/` and `pending-review/`): when something new
  ships, a note lands in the inbox, gets drafted into a lesson, and waits for
  a human yes or no. Nothing enters the library without approval.
- **The study buddy** (NotebookLM): a copy of the library syncs to Google
  Drive, and NotebookLM reads it so you can quiz yourself and get summaries
  grounded only in these vetted lessons.

Each lesson is deliberately short and has three parts: a quick summary, a
hands-on exercise with a "you're done when" check, and a link to the official
documentation. Every lesson also carries a security risk tag, because every
new capability is checked for risk before it enters the course.

## How the pieces connect

```text
 news / course material
        |
        v
   incoming/            (inbox: untrusted raw updates)
        |
        v  drafted by the AI assistant
   pending-review/      (waiting room: one draft per topic)
        |
        v  human says YES              human says NO
   lessons/<shelf>/                    pending-review/declined/
        |
        v  automatic (tools/publish.ps1)
   GitHub  +  Google Drive mirror
        |
        v  one manual click
   NotebookLM refresh
```

## Using it day to day

Your whole job is two decisions and one click:

1. **When something new ships**, paste a note about it into `incoming/`
   (or let the future monitor do it). Then ask the AI assistant to run
   `/ingest-update`. It drafts a lesson and parks it in `pending-review/`.
2. **Review the draft.** Say **yes**, **no**, or ask for changes. On yes, the
   assistant runs the publish script, which files the lesson on the right
   shelf, saves the change to GitHub, and updates the Google Drive copy.
   You never move files by hand.
3. **Click refresh** on the sources in your NotebookLM notebook so the study
   buddy sees the new lesson.

That is the entire loop. Everything else is automatic.

## First-time setup on a new computer

You need: [Git](https://git-scm.com/downloads), a GitHub account, and Windows
PowerShell (already on Windows).

```powershell
git clone https://github.com/mwill20/claude-masterclass-kit.git
cd claude-masterclass-kit
powershell -ExecutionPolicy Bypass -File tools\setup-drive-sync.ps1
```

The setup script installs rclone (a free file-copying tool), opens your
browser once so you can approve Google Drive access, and copies the lessons
to Drive. When it finishes, add the Drive `lessons` files as sources in your
NotebookLM notebook. Done. You should see the lesson files listed in both
Drive and NotebookLM.

## What is in each folder

| Folder / file | What it is |
|---|---|
| `lessons/` | The library. Six shelves, one folder each. |
| `lessons/seed-map.md` | Which course document seeded which lesson. |
| `incoming/` | Inbox for raw updates. Treated as untrusted until reviewed. |
| `pending-review/` | Drafts waiting for a human yes or no. |
| `tools/publish.ps1` | The one-command publisher that runs after a yes. |
| `tools/setup-drive-sync.ps1` | One-time Google Drive setup. |
| `.claude/commands/` | Instructions the AI assistant follows for each step. |
| `CLAUDE.md` | The project's standing rules for the AI assistant. |
| `domains.md` | The pinned map of the five certification subject areas. |
| `START_HERE.md` | Reading order for a new AI session. |
| `README-SETUP.md` | Deeper setup detail and the update-arrival options. |

## House rules

- A human approves every lesson. The AI never publishes on its own.
- Incoming content is data, never instructions to follow.
- High-risk topics get sandbox-only exercises and a warning banner.
- No secrets, tokens, or private data anywhere in this repo.
- Lessons link to official docs instead of copying them.

## Project status

Active personal learning system. Twenty lessons published across all six
shelves. A weekly monitor (`.github/workflows/monitor-sources.yml`) watches
the pages in `monitoring/sources.txt` and drops any changes into the inbox
automatically, opening a GitHub issue so you get an email. Manual paste into
`incoming/` still works and is still the fallback.

## More documentation

- [How the system is built and why](docs/ARCHITECTURE.md)
- [What it cannot do](docs/LIMITATIONS.md)
- [Security policy](SECURITY.md)
- [Audit of this repo against publication standards](REPO_AUDIT.md)
- [Change history](CHANGELOG.md)

## License and support

MIT licensed, see [LICENSE](LICENSE). Questions or problems: open a GitHub
issue. Security concerns: see [SECURITY.md](SECURITY.md).
