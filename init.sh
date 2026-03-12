#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/templates"
SOUL_FILE="$SCRIPT_DIR/soul.md"
METHODOLOGY_FILE="$SCRIPT_DIR/methodology.md"
STABLE_DIR="$HOME/.ai-methodology"
TEMPLATE_FILE="$TEMPLATES_DIR/methodology.md.tpl"

CLAUDE_TARGET="$HOME/.claude/CLAUDE.md"
CODEX_TARGET="$HOME/.codex/AGENTS.md"

MARKER_BEGIN="<!-- ai-methodology:begin -->"
MARKER_END="<!-- ai-methodology:end -->"

IDE=""
DRY_RUN=false
BACKUP=true

usage() {
  cat <<'EOF'
Usage:
  ./init.sh --ide <claude|cursor|codex|all> [--dry-run] [--no-backup]

Options:
  --ide <name>     Target IDE: claude, cursor, codex, or all (required)
  --dry-run        Preview without writing
  --no-backup      Skip backup before write
  -h, --help       Show help
EOF
}

require_file() {
  if [ ! -f "$1" ]; then
    echo "Missing required file: $1" >&2
    exit 1
  fi
}

timestamp() {
  date "+%Y%m%d-%H%M%S"
}

copy_source_files() {
  mkdir -p "$STABLE_DIR"

  if [ "$DRY_RUN" = true ]; then
    echo "[dry-run] would copy soul.md → $STABLE_DIR/soul.md"
    echo "[dry-run] would copy methodology.md → $STABLE_DIR/methodology.md"
    return
  fi

  cp "$SOUL_FILE" "$STABLE_DIR/soul.md"
  cp "$METHODOLOGY_FILE" "$STABLE_DIR/methodology.md"
  echo "Copied source files to $STABLE_DIR/"
}

# inject_managed_block <target_file> <template_content>
# 1. File doesn't exist → create with markers + content
# 2. File exists with markers → replace content between markers
# 3. File exists without markers → prepend markers + content, preserve existing
inject_managed_block() {
  local target="$1"
  local content="$2"
  local managed_block="${MARKER_BEGIN}
${content}
${MARKER_END}"

  mkdir -p "$(dirname "$target")"

  if [ "$DRY_RUN" = true ]; then
    if [ ! -f "$target" ]; then
      echo "[dry-run] would create: $target (new file with managed block)"
    elif grep -q "$MARKER_BEGIN" "$target"; then
      echo "[dry-run] would update managed block in: $target"
    else
      echo "[dry-run] would prepend managed block to: $target"
    fi
    echo "[dry-run] managed block size: $(echo "$managed_block" | wc -c | tr -d ' ') bytes"
    return
  fi

  # Backup before write
  if [ "$BACKUP" = true ] && [ -f "$target" ]; then
    cp "$target" "$target.bak.$(timestamp)"
  fi

  if [ ! -f "$target" ]; then
    # Case 1: file doesn't exist — create with managed block
    echo "$managed_block" > "$target"
    echo "Created: $target"
  elif grep -q "$MARKER_BEGIN" "$target"; then
    # Case 2: file has markers — replace content between them
    # Write managed block to temp file, then assemble: before + block + after
    local tmpblock tmpout
    tmpblock=$(mktemp)
    tmpout=$(mktemp)
    echo "$managed_block" > "$tmpblock"

    # Extract lines before the begin marker
    sed -n "/$MARKER_BEGIN/q;p" "$target" > "$tmpout"
    # Append the new managed block
    cat "$tmpblock" >> "$tmpout"
    # Extract lines after the end marker
    sed -n "/$MARKER_END/,\$p" "$target" | tail -n +2 >> "$tmpout"

    mv "$tmpout" "$target"
    rm -f "$tmpblock"
    echo "Updated managed block in: $target"
  else
    # Case 3: file has no markers — prepend managed block
    local existing
    existing=$(cat "$target")
    printf '%s\n\n%s\n' "$managed_block" "$existing" > "$target"
    echo "Prepended managed block to: $target (existing content preserved)"
  fi
}

write_cursor() {
  if [ "$DRY_RUN" = true ]; then
    echo "[dry-run] would copy to clipboard for Cursor User Rules"
    echo "[dry-run] content size: $(wc -c < "$TEMPLATE_FILE" | tr -d ' ') bytes"
    return
  fi

  cat "$TEMPLATE_FILE" | pbcopy
  echo "Copied to clipboard. Paste into: Cursor > Settings > Rules > User Rules"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --ide)
      IDE="${2:-}"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --no-backup)
      BACKUP=false
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [ -z "$IDE" ]; then
  echo "--ide is required." >&2
  usage
  exit 1
fi

if [ "$IDE" != "claude" ] && [ "$IDE" != "cursor" ] && [ "$IDE" != "codex" ] && [ "$IDE" != "all" ]; then
  echo "Unsupported --ide value: $IDE (expected: claude, cursor, codex, or all)" >&2
  exit 1
fi

require_file "$SOUL_FILE"
require_file "$METHODOLOGY_FILE"
require_file "$TEMPLATE_FILE"

copy_source_files

TEMPLATE_CONTENT=$(cat "$TEMPLATE_FILE")

if [ "$IDE" = "claude" ] || [ "$IDE" = "all" ]; then
  inject_managed_block "$CLAUDE_TARGET" "$TEMPLATE_CONTENT"
fi

if [ "$IDE" = "codex" ] || [ "$IDE" = "all" ]; then
  inject_managed_block "$CODEX_TARGET" "$TEMPLATE_CONTENT"
fi

if [ "$IDE" = "cursor" ] || [ "$IDE" = "all" ]; then
  write_cursor
fi

echo "Done."
