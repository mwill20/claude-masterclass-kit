# setup-drive-sync.ps1 - ONE-TIME setup for the Google Drive mirror.
#
# Installs rclone (if missing) and creates an rclone remote named "gdrive"
# scoped to the Master Class Drive folder. A browser window will open once
# for Google OAuth consent - approve it with the account that owns the
# Drive folder and the NotebookLM notebook.
#
# Least-privilege note: rclone's Google Drive token uses the full "drive"
# scope because the target folder was created in the Drive web UI (the
# narrower drive.file scope can only see files rclone itself created).
# root_folder_id confines every rclone command in this repo to that one
# folder. The OAuth token lives in rclone's local config, not in this repo.
#
# Usage: powershell -ExecutionPolicy Bypass -File tools\setup-drive-sync.ps1

$ErrorActionPreference = 'Stop'

# Folder ID from https://drive.google.com/drive/u/0/folders/1Q0YlNYl9a_Q8fIGxCWpyaQIMX3h5ONUQ
$DriveFolderId = '1Q0YlNYl9a_Q8fIGxCWpyaQIMX3h5ONUQ'
$RemoteName    = 'gdrive'

# --- 1. Ensure rclone is installed -----------------------------------------
$rclone = Get-Command rclone -ErrorAction SilentlyContinue
if (-not $rclone) {
    Write-Host "rclone not found. Installing via winget..." -ForegroundColor Yellow
    winget install --id Rclone.Rclone --accept-source-agreements --accept-package-agreements
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: winget install failed. Install manually from https://rclone.org/downloads/ then rerun this script." -ForegroundColor Red
        exit 1
    }
    # Refresh PATH for this session so the new binary is found
    $env:Path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path', 'User')
    $rclone = Get-Command rclone -ErrorAction SilentlyContinue
    if (-not $rclone) {
        Write-Host "rclone installed but not on PATH yet. Open a NEW terminal and rerun this script." -ForegroundColor Yellow
        exit 1
    }
}
Write-Host "rclone found: $($rclone.Source)" -ForegroundColor Green

# --- 2. Create the remote (opens browser for OAuth) ------------------------
$remotes = rclone listremotes
if ($remotes -contains "${RemoteName}:") {
    Write-Host "Remote '$RemoteName' already configured. Skipping OAuth." -ForegroundColor Green
}
else {
    Write-Host "Creating remote '$RemoteName'. A browser window will open - approve access with your Google account." -ForegroundColor Cyan
    rclone config create $RemoteName drive scope=drive root_folder_id=$DriveFolderId
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: rclone config failed. Rerun this script to retry." -ForegroundColor Red
        exit 1
    }
}

# --- 3. Verify: list the folder and do a first mirror -----------------------
Write-Host "Verifying access to the Drive folder..."
rclone lsd "${RemoteName}:"
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: could not read the Drive folder. Check the OAuth account and rerun." -ForegroundColor Red
    exit 1
}

$LessonsDir = Join-Path (Split-Path -Parent $PSScriptRoot) 'lessons'
Write-Host "Running first mirror of lessons/ ..."
rclone sync $LessonsDir "${RemoteName}:lessons" --exclude 'README.md'
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: first sync failed. Rerun: rclone sync lessons ${RemoteName}:lessons" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Drive sync is set up. From now on tools\publish.ps1 mirrors lessons/ automatically." -ForegroundColor Green
Write-Host "Last step (one time): in NotebookLM, add the Drive 'lessons' folder files as sources:" -ForegroundColor Cyan
Write-Host "  https://notebooklm.google.com/notebook/05a9be96-c8a7-43e2-a375-ec8ea899eb56"
