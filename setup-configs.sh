#!/usr/bin/env bash
set -euo pipefail

write_file() {
  local target_file="$1"
  local content="$2"

  mkdir -p "$(dirname "$target_file")"

  if [ -f "$target_file" ]; then
    echo "Skip existing $target_file"
    return
  fi

  printf '%s\n' "$content" > "$target_file"
  echo "Created $target_file"
}

write_file "$HOME/.claude/settings.json" '{
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
}'

write_file "$HOME/.codex/auth.json" '{
  "OPENAI_API_KEY": "sk-****"
}'

write_file "$HOME/.codex/config.toml" 'personality = "pragmatic"
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
hide_full_access_warning = true'

echo "Done. Edit ~/.claude/settings.json and ~/.codex/auth.json with your own tokens."
