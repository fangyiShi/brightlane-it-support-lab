# Publishes the reviewed Markdown sources using the local user's Git login.
# Run from the downloaded/cloned repository: .\scripts\Publish-Wiki.ps1
$ErrorActionPreference = 'Stop'
Get-Command git -ErrorAction Stop | Out-Null

$WikiSource = Join-Path (Split-Path $PSScriptRoot -Parent) 'wiki'
$WikiFiles = @(
    'Home.md',
    '01-Environment-Setup-and-Windows-Server.md',
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

$WikiCheckout = Join-Path ([System.IO.Path]::GetTempPath()) ('brightlane-wiki-' + [guid]::NewGuid().ToString('N'))
try {
    Invoke-Git clone 'https://github.com/fangyiShi/brightlane-it-support-lab.wiki.git' $WikiCheckout
    # Keep unrelated Wiki pages. Only replace the four reviewed source files.
    foreach ($File in $WikiFiles) {
        Copy-Item -LiteralPath (Join-Path $WikiSource $File) -Destination (Join-Path $WikiCheckout $File)
    }
    Invoke-Git -C $WikiCheckout add -- @WikiFiles
    $Changes = Invoke-Git -C $WikiCheckout diff --cached --name-only
    if ($Changes) {
        Invoke-Git -C $WikiCheckout commit -m 'Improve Wiki navigation, setup guide and verification'
        # A normal push rejects conflicting remote updates; never force-push.
        Invoke-Git -C $WikiCheckout push origin HEAD
        Write-Host 'Published: https://github.com/fangyiShi/brightlane-it-support-lab/wiki'
    } else {
        Write-Host 'The Wiki already matches the prepared sources.'
    }
    Remove-Item -LiteralPath $WikiCheckout -Recurse -Force
} catch {
    Write-Warning "Publishing stopped. Temporary checkout retained at: $WikiCheckout"
    throw
}
