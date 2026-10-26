#!/bin/bash
# Install/update methodology rules into CLAUDE.md, AGENTS.md, and GEMINI.md as a managed block.
# The template path in the rules is made absolute, so it resolves from any project.
# Re-runnable to update. Use --remove to clean up.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RULES_FILE="$SCRIPT_DIR/../docs/rules.md"
BEGIN_MARKER="<!-- mtg:begin -->"
END_MARKER="<!-- mtg:end -->"

# rules.md names the template relative to the skill root, which only resolves
# inside the skill. The injected block is read from any project root.
TEMPLATE_REL="docs/methodology-template.tpl"
TEMPLATE_ABS="$(cd "$SCRIPT_DIR/.." && pwd)/$TEMPLATE_REL"

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
    # install_block adds one blank line before the block; drop that line too,
    # so install + remove restores the file exactly and reinstalls don't grow it.
    local tmp
    tmp=$(mktemp) || return 1
    if awk -v begin="$BEGIN_MARKER" -v end="$END_MARKER" '
      skip { if (index($0, end)) skip = 0; next }
      index($0, begin) { held = 0; skip = 1; next }
      /^$/ { if (held) print ""; held = 1; next }
      { if (held) print ""; held = 0; print }
      END { if (held) print "" }
    ' "$file" > "$tmp"; then
      cat "$tmp" > "$file"
      echo "Removed mtg block from $file"
    fi
    rm -f "$tmp"
  fi
}

# Print rules.md with every template path made absolute. Plain-string awk
# replacement via ENVIRON: bash 3.2 `${var//"pat"/"rep"}` does not match a
# quoted pattern, bash 5.2 expands `&` in the replacement, and `awk -v`
# processes backslashes. If the template is missing, print rules.md unchanged.
with_absolute_template() {
  if [ ! -f "$TEMPLATE_ABS" ]; then
    cat "$RULES_FILE"
    return
  fi
  MTG_OLD="$TEMPLATE_REL" MTG_NEW="$TEMPLATE_ABS" awk '
    {
      line = $0; out = ""
      while ((i = index(line, ENVIRON["MTG_OLD"])) > 0) {
        out = out substr(line, 1, i - 1) ENVIRON["MTG_NEW"]
        line = substr(line, i + length(ENVIRON["MTG_OLD"]))
      }
      print out line
    }
  ' "$RULES_FILE"
}

install_block() {
  local file="$1"
  local rules
  rules=$(with_absolute_template)
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

if [ ! -f "$TEMPLATE_ABS" ]; then
  echo "Warning: template not found at $TEMPLATE_ABS; keeping the relative path" >&2
fi

for target in "${TARGETS[@]}"; do
  install_block "$target"
done
