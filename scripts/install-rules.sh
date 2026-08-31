#!/bin/bash
# Install/update methodology rules into CLAUDE.md, AGENTS.md, and GEMINI.md as a managed block.
# Re-runnable to update. Use --remove to clean up.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RULES_FILE="$SCRIPT_DIR/../docs/rules.md"
BEGIN_MARKER="<!-- mtg:begin -->"
END_MARKER="<!-- mtg:end -->"

TARGETS=(
  "$HOME/.claude/CLAUDE.md"
  "$HOME/.codex/AGENTS.md"
  "$HOME/.gemini/GEMINI.md"
)

remove_block() {
  local file="$1"
  if [ -f "$file" ] && grep -q "$BEGIN_MARKER" "$file"; then
    # Not `sed -i`: the in-place flag is not portable. BSD sed (macOS) requires
    # an argument, GNU sed refuses one, so `sed -i ''` silently removes nothing
    # on Linux and leaves the block in place. Write via a temp file, then copy
    # back with `cat` so the target keeps its inode and permissions.
    local tmp
    tmp=$(mktemp) || return 1
    if sed "/$BEGIN_MARKER/,/$END_MARKER/d" "$file" > "$tmp"; then
      cat "$tmp" > "$file"
      echo "Removed mtg block from $file"
    fi
    rm -f "$tmp"
  fi
}

install_block() {
  local file="$1"
  local rules
  rules=$(cat "$RULES_FILE")
  local block
  block=$(printf '%s\n%s\n%s' "$BEGIN_MARKER" "$rules" "$END_MARKER")

  if [ ! -f "$file" ]; then
    echo "Skipping $file (not found)"
    return
  fi

  # Remove existing block if present, then append new one
  if grep -q "$BEGIN_MARKER" "$file"; then
    remove_block "$file"
  fi

  printf '\n%s\n' "$block" >> "$file"
  echo "Updated mtg block in $file"
}

if [ "$1" = "--remove" ]; then
  for target in "${TARGETS[@]}"; do
    remove_block "$target"
  done
  exit 0
fi

if [ ! -f "$RULES_FILE" ]; then
  echo "Error: rules file not found at $RULES_FILE" >&2
  exit 1
fi

for target in "${TARGETS[@]}"; do
  install_block "$target"
done
