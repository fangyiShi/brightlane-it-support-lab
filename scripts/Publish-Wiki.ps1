# Publishes the reviewed Markdown sources using the local user's Git login.
# Run after merging and pulling main: .\scripts\Publish-Wiki.ps1
[CmdletBinding()]
param([switch]$Preview)

$ErrorActionPreference = 'Stop'
Get-Command git -ErrorAction Stop | Out-Null

$RepoRoot = Split-Path $PSScriptRoot -Parent
$WikiSource = Join-Path $RepoRoot 'wiki'
$WikiFiles = @(
    'Home.md',
    '01-Environment-Setup-and-Windows-Server.md',
    '02-Active-Directory-and-DNS.md',
    '03-OUs-Users-and-Groups.md',
    '04-Windows-Client-and-Domain-Join.md',
    '05-File-Shares-and-Permissions.md',
    '06-Group-Policy.md',
    '07-PowerShell-Administration.md',
    'Verification-and-Troubleshooting.md',
    '_Sidebar.md'
)
foreach ($File in $WikiFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $WikiSource $File))) {
        throw "Missing Wiki source: $File. Pull the latest repository changes first."
    }
}

function Invoke-Git {
    & git @args
    if ($LASTEXITCODE -ne 0) { throw 'Git failed. Resolve the reported error before retrying.' }
}

if ($Preview) {
    Write-Host 'Preview only. No files changed and nothing published.'
    $WikiFiles | ForEach-Object { Write-Host "  $_" }
    return
}

# Publish only the merged, committed sources from this repository.
$Branch = Invoke-Git -C $RepoRoot branch --show-current
if ($Branch -ne 'main') {
    throw 'Publish from main only, after the documentation pull request is merged.'
}
$Dirty = Invoke-Git -C $RepoRoot status --porcelain
if ($Dirty) { throw 'The repository has local changes. Commit or set them aside before publishing.' }
$Origin = Invoke-Git -C $RepoRoot remote get-url origin
if ($Origin -notin @(
    'https://github.com/fangyiShi/brightlane-it-support-lab.git',
    'https://github.com/fangyiShi/brightlane-it-support-lab',
    'git@github.com:fangyiShi/brightlane-it-support-lab.git'
)) { throw 'Origin is not the expected Bright Lane repository.' }
Invoke-Git -C $RepoRoot fetch origin main
$SourceCommit = Invoke-Git -C $RepoRoot rev-parse HEAD
$RemoteCommit = Invoke-Git -C $RepoRoot rev-parse origin/main
if ($SourceCommit -ne $RemoteCommit) {
    throw 'Local main differs from origin/main. Pull the merged changes before publishing.'
}

$WikiCheckout = Join-Path ([System.IO.Path]::GetTempPath()) ('brightlane-wiki-' + [guid]::NewGuid().ToString('N'))
try {
    Invoke-Git clone 'https://github.com/fangyiShi/brightlane-it-support-lab.wiki.git' $WikiCheckout
    # Keep unrelated Wiki pages. Only replace the reviewed source files.
    foreach ($File in $WikiFiles) {
        Copy-Item -LiteralPath (Join-Path $WikiSource $File) -Destination (Join-Path $WikiCheckout $File)
    }
    Invoke-Git -C $WikiCheckout add -- @WikiFiles
    $Changes = Invoke-Git -C $WikiCheckout diff --cached --name-only
    if ($Changes) {
        Invoke-Git -C $WikiCheckout commit -m "Publish Phase 1 documentation from $SourceCommit"
        # A normal push rejects conflicting remote updates; never force-push.
        Invoke-Git -C $WikiCheckout push origin HEAD
        Write-Host 'Published: https://github.com/fangyiShi/brightlane-it-support-lab/wiki'
    } else {
        Write-Host 'The Wiki already matches the prepared sources.'
    }
    # Validate the generated checkout before recursive cleanup.
    $ResolvedCheckout = [System.IO.Path]::GetFullPath($WikiCheckout)
    $TempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd('\')
    if ((Split-Path $ResolvedCheckout -Parent) -ne $TempRoot -or
        (Split-Path $ResolvedCheckout -Leaf) -notmatch '^brightlane-wiki-[0-9a-f]{32}$') {
        throw 'Unexpected temporary checkout path; cleanup stopped.'
    }
    Remove-Item -LiteralPath $ResolvedCheckout -Recurse -Force
} catch {
    Write-Warning "Publishing stopped. Temporary checkout retained at: $WikiCheckout"
    throw
}
