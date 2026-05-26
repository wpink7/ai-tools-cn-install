#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_file() {
  local source_file="$1"
  local target_file="$2"

  mkdir -p "$(dirname "$target_file")"

  if [ -f "$target_file" ]; then
    echo "Skip existing $target_file"
    return
  fi

  cp "$source_file" "$target_file"
  echo "Created $target_file"
}

install_file "$ROOT_DIR/claude/settings.json" "$HOME/.claude/settings.json"
install_file "$ROOT_DIR/codex/auth.json" "$HOME/.codex/auth.json"
install_file "$ROOT_DIR/codex/config.toml" "$HOME/.codex/config.toml"

echo "Done. Edit ~/.claude/settings.json and ~/.codex/auth.json with your own tokens."
