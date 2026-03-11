#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/templates"
SOUL_FILE="$SCRIPT_DIR/soul.md"
METHODOLOGY_FILE="$SCRIPT_DIR/methodology.md"
STABLE_DIR="$HOME/.ai-methodology"
CLAUDE_TARGET="$HOME/.claude/CLAUDE.md"
CURSOR_TEMPLATE="$TEMPLATES_DIR/cursor.txt.tpl"

IDE=""
DRY_RUN=false
BACKUP=true

usage() {
  cat <<'EOF'
Usage:
  ./init.sh --ide <cursor|claude> [--dry-run] [--no-backup]

Options:
  --ide <name>     Target IDE: claude, cursor, or all (required)
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

write_claude() {
  local template="$TEMPLATES_DIR/claude.md.tpl"
  require_file "$template"

  mkdir -p "$(dirname "$CLAUDE_TARGET")"

  if [ "$BACKUP" = true ] && [ -f "$CLAUDE_TARGET" ]; then
    cp "$CLAUDE_TARGET" "$CLAUDE_TARGET.bak.$(timestamp)"
  fi

  if [ "$DRY_RUN" = true ]; then
    echo "[dry-run] would write: $CLAUDE_TARGET"
    echo "[dry-run] content size: $(wc -c < "$template" | tr -d ' ') bytes"
    return
  fi

  cp "$template" "$CLAUDE_TARGET"
  echo "Wrote Claude global instructions: $CLAUDE_TARGET"
}

write_cursor() {
  require_file "$CURSOR_TEMPLATE"

  if [ "$DRY_RUN" = true ]; then
    echo "[dry-run] would copy to clipboard for Cursor User Rules"
    echo "[dry-run] content size: $(wc -c < "$CURSOR_TEMPLATE" | tr -d ' ') bytes"
    echo ""
    echo "--- preview ---"
    cat "$CURSOR_TEMPLATE"
    echo "--- end preview ---"
    return
  fi

  cat "$CURSOR_TEMPLATE" | pbcopy
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

if [ "$IDE" != "claude" ] && [ "$IDE" != "cursor" ] && [ "$IDE" != "all" ]; then
  echo "Unsupported --ide value: $IDE (expected: claude, cursor, or all)" >&2
  exit 1
fi

require_file "$SOUL_FILE"
require_file "$METHODOLOGY_FILE"

copy_source_files

if [ "$IDE" = "claude" ] || [ "$IDE" = "all" ]; then
  write_claude
fi

if [ "$IDE" = "cursor" ] || [ "$IDE" = "all" ]; then
  write_cursor
fi

echo "Done."
