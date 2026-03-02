# PowerShell profile — Windows Terminal
# Location: $PROFILE (typically ~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1)

# Prompt (colored, matches Linux/Mac style)
function prompt {
    $user = $env:USERNAME
    $host_ = $env:COMPUTERNAME
    $path = (Get-Location).Path.Replace($HOME, '~')
    Write-Host "$user" -ForegroundColor Green -NoNewline
    Write-Host "@" -ForegroundColor Cyan -NoNewline
    Write-Host "$host_ " -ForegroundColor Green -NoNewline
    Write-Host "$path " -ForegroundColor Cyan -NoNewline
    return "$ "
}

# Aliases
Set-Alias -Name ll -Value Get-ChildItem
function la { Get-ChildItem -Force @args }

function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }

# History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# PATH additions
$scriptsPath = Join-Path $HOME ".scripts"
if (Test-Path $scriptsPath) {
    $env:PATH += ";$scriptsPath"
}

# Source local overrides (not tracked)
$localProfile = Join-Path $HOME ".ps_local.ps1"
if (Test-Path $localProfile) { . $localProfile }
