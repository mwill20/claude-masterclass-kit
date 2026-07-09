# publish.ps1 - one-command publish for an approved lesson draft.
#
# Runs AFTER a human approves a draft in /review-queue. This script is the
# deterministic playbook for everything downstream of that approval:
#   move draft -> correct lane -> commit -> push -> mirror lessons/ to Drive.
# NotebookLM refresh stays manual by design (no supported API).
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File tools\publish.ps1                     # auto-picks the only draft
#   powershell -ExecutionPolicy Bypass -File tools\publish.ps1 -Draft 2026-07-07-x.md
#   powershell -ExecutionPolicy Bypass -File tools\publish.ps1 -Draft x.md -Decline
#   Switches: -Update (commit as update(...)), -NoPush, -SkipSync, -DryRun

[CmdletBinding()]
param(
    [string]$Draft,
    [string]$Lane,      # override auto-detect, e.g. "domain-3" or "whats-new"
    [string]$Station,   # override auto-detect
    [switch]$Update,
    [switch]$Decline,
    [switch]$NoPush,
    [switch]$SkipSync,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$RepoRoot   = Split-Path -Parent $PSScriptRoot
$PendingDir = Join-Path $RepoRoot 'pending-review'
$LessonsDir = Join-Path $RepoRoot 'lessons'
$RcloneRemote = 'gdrive'
$NotebookUrl  = 'https://notebooklm.google.com/notebook/05a9be96-c8a7-43e2-a375-ec8ea899eb56'

$LaneFolders = @{
    'domain-1'  = 'domain-1-agent-architecture'
    'domain-2'  = 'domain-2-tool-design-mcp'
    'domain-3'  = 'domain-3-configuration-workflows'
    'domain-4'  = 'domain-4-prompt-structured-output'
    'domain-5'  = 'domain-5-context-reliability'
    'whats-new' = 'lane-6-whats-new'
}

function Fail([string]$msg) { Write-Host "ERROR: $msg" -ForegroundColor Red; exit 1 }

# --- Resolve the draft ---------------------------------------------------
if (-not $Draft) {
    $candidates = @(Get-ChildItem $PendingDir -File -Filter '*.md' | Where-Object { $_.Name -ne 'README.md' })
    if ($candidates.Count -eq 0) { Fail "Nothing in pending-review/ to publish." }
    if ($candidates.Count -gt 1) {
        $names = ($candidates | ForEach-Object { $_.Name }) -join "`n  "
        Fail "Multiple drafts pending. Pick one with -Draft:`n  $names"
    }
    $Draft = $candidates[0].Name
}
$DraftPath = Join-Path $PendingDir (Split-Path -Leaf $Draft)
if (-not (Test-Path $DraftPath)) { Fail "Draft not found: $DraftPath" }
$DraftName = Split-Path -Leaf $DraftPath

# --- Decline path ---------------------------------------------------------
if ($Decline) {
    $DeclinedDir = Join-Path $PendingDir 'declined'
    if (-not (Test-Path $DeclinedDir)) { New-Item -ItemType Directory -Path $DeclinedDir | Out-Null }
    if ($DryRun) { Write-Host "[dry-run] Would move $DraftName -> pending-review/declined/ and commit."; exit 0 }
    # Move-Item + git add handles both tracked and not-yet-tracked drafts (git mv chokes on untracked)
    Move-Item $DraftPath (Join-Path $DeclinedDir $DraftName)
    git -C $RepoRoot add "pending-review/$DraftName" "pending-review/declined/$DraftName"
    git -C $RepoRoot commit -m "decline: $DraftName"
    if (-not $NoPush) { git -C $RepoRoot push }
    Write-Host "Declined and recorded: $DraftName" -ForegroundColor Yellow
    exit 0
}

# --- Auto-detect lane and station from the draft's header ----------------
$content = Get-Content $DraftPath -Raw

if (-not $Lane) {
    if ($content -match '(?m)^\s*-\s*Lane:\s*(.+)$') {
        $laneLine = $Matches[1]
        if ($laneLine -match '[Dd]omain\s*([1-5])') { $Lane = "domain-$($Matches[1])" }
        elseif ($laneLine -match "what'?s\s*new") { $Lane = 'whats-new' }
    }
    if (-not $Lane) { Fail "Could not detect lane from draft. Pass -Lane domain-N or -Lane whats-new." }
}
if (-not $LaneFolders.ContainsKey($Lane)) {
    Fail "Unknown lane '$Lane'. Valid: $($LaneFolders.Keys -join ', ')"
}
$LaneFolder = $LaneFolders[$Lane]
$TargetDir  = Join-Path $LessonsDir $LaneFolder
if (-not (Test-Path $TargetDir)) { Fail "Lane folder missing: $TargetDir" }

if (-not $Station) {
    if ($content -match '(?m)^\s*-\s*Station:\s*(.+)$') { $Station = $Matches[1].Trim() }
    else { $Station = [System.IO.Path]::GetFileNameWithoutExtension($DraftName) }
}

$verb = 'add'
if ($Update) { $verb = 'update' }
$laneTag = $Lane
if ($Lane -eq 'whats-new') { $laneTag = 'lane-6' }
$CommitMsg = "$verb($laneTag): $Station"

if ($DryRun) {
    Write-Host "[dry-run] Would publish:"
    Write-Host "  draft   : pending-review/$DraftName"
    Write-Host "  target  : lessons/$LaneFolder/$DraftName"
    Write-Host "  commit  : $CommitMsg"
    Write-Host "  push    : $(-not $NoPush)"
    Write-Host "  sync    : $(-not $SkipSync) (rclone remote '$RcloneRemote')"
    exit 0
}

# --- Promote draft content from 'pending review' to approved --------------
$today = Get-Date -Format 'yyyy-MM-dd'
$content = $content -replace '(?m)^# Pending Review - ', '# '
$content = $content -replace '(?m)^\s*-\s*Status:\s*pending review\s*$', "- Status: approved $today"
$content = $content -replace '(?ms)\r?\n## Review Question.*$', ''
Set-Content -Path $DraftPath -Value $content -Encoding utf8 -NoNewline

# --- Move, commit, push ----------------------------------------------------
# Move-Item + git add handles both tracked and not-yet-tracked drafts (git mv chokes on untracked)
Move-Item $DraftPath (Join-Path $TargetDir $DraftName)
git -C $RepoRoot add "pending-review/$DraftName" "lessons/$LaneFolder/$DraftName"
if ($LASTEXITCODE -ne 0) { Fail "git add failed." }
git -C $RepoRoot commit -m $CommitMsg
if ($LASTEXITCODE -ne 0) { Fail "git commit failed." }
Write-Host "Committed: $CommitMsg" -ForegroundColor Green

if (-not $NoPush) {
    git -C $RepoRoot push
    if ($LASTEXITCODE -ne 0) { Fail "git push failed. Lesson is committed locally; push manually." }
    Write-Host "Pushed to GitHub." -ForegroundColor Green
}

# --- Mirror lessons/ to Google Drive via rclone ----------------------------
if (-not $SkipSync) {
    $rclone = Get-Command rclone -ErrorAction SilentlyContinue
    if (-not $rclone) {
        Write-Host "SKIPPED Drive sync: rclone not installed. Run tools\setup-drive-sync.ps1 once." -ForegroundColor Yellow
    }
    else {
        $remotes = rclone listremotes
        if ($remotes -notcontains "${RcloneRemote}:") {
            Write-Host "SKIPPED Drive sync: rclone remote '$RcloneRemote' not configured. Run tools\setup-drive-sync.ps1 once." -ForegroundColor Yellow
        }
        else {
            rclone sync $LessonsDir "${RcloneRemote}:lessons" --exclude 'README.md'
            if ($LASTEXITCODE -eq 0) { Write-Host "Mirrored lessons/ to Google Drive." -ForegroundColor Green }
            else { Write-Host "Drive sync FAILED (exit $LASTEXITCODE). Repo is fine; rerun: rclone sync lessons ${RcloneRemote}:lessons" -ForegroundColor Red }
        }
    }
}

Write-Host ""
Write-Host "One manual step left: refresh sources in NotebookLM:" -ForegroundColor Cyan
Write-Host "  $NotebookUrl"
