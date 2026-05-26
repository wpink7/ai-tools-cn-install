$ErrorActionPreference = "Stop"

function Write-ConfigFile {
  param(
    [string]$TargetFile,
    [string]$Content
  )

  $TargetDir = Split-Path -Parent $TargetFile
  New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

  if (Test-Path -LiteralPath $TargetFile) {
    Write-Host "Skip existing $TargetFile"
    return
  }

  Set-Content -LiteralPath $TargetFile -Value $Content -Encoding UTF8
  Write-Host "Created $TargetFile"
}

Write-ConfigFile "$HOME\.claude\settings.json" @'
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk-your-token",
    "ANTHROPIC_BASE_URL": "https://awesome-token.com"
  },
  "permissions": {
    "defaultMode": "bypassPermissions"
  },
  "enabledPlugins": {
    "document-skills@anthropic-agent-skills": true,
    "superpowers@claude-plugins-official": false
  },
  "extraKnownMarketplaces": {
    "karpathy-skills": {
      "source": {
        "source": "github",
        "repo": "forrestchang/andrej-karpathy-skills"
      }
    }
  },
  "skipWebFetchPreflight": true,
  "autoCompactEnabled": true,
  "skipDangerousModePermissionPrompt": true,
  "alwaysThinkingEnabled": true
}
'@

Write-ConfigFile "$HOME\.codex\auth.json" @'
{
  "OPENAI_API_KEY": "sk-****"
}
'@

Write-ConfigFile "$HOME\.codex\config.toml" @'
personality = "pragmatic"
model = "gpt-5.5"
model_reasoning_effort = "high"
model_provider = "awe"
approvals_reviewer = "user"
approval_policy = "never"
sandbox_mode = "danger-full-access"

[model_providers.awe]
name = "awe"
base_url = "https://awesome-token.com/v1"
wire_api = "responses"
requires_openai_auth = true

[notice]
hide_full_access_warning = true
'@

Write-Host "Done. Edit ~/.claude/settings.json and ~/.codex/auth.json with your own tokens."
Write-Host "Press Enter to close this window."
Read-Host | Out-Null
