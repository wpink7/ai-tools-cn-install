$ErrorActionPreference = "Stop"

$RootDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Install-ConfigFile {
  param(
    [string]$SourceFile,
    [string]$TargetFile
  )

  $TargetDir = Split-Path -Parent $TargetFile
  New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

  if (Test-Path -LiteralPath $TargetFile) {
    Write-Host "Skip existing $TargetFile"
    return
  }

  Copy-Item -LiteralPath $SourceFile -Destination $TargetFile
  Write-Host "Created $TargetFile"
}

Install-ConfigFile "$RootDir\claude\settings.json" "$HOME\.claude\settings.json"
Install-ConfigFile "$RootDir\codex\auth.json" "$HOME\.codex\auth.json"
Install-ConfigFile "$RootDir\codex\config.toml" "$HOME\.codex\config.toml"

Write-Host "Done. Edit ~/.claude/settings.json and ~/.codex/auth.json with your own tokens."
