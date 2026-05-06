# bookmarks.zsh — directory bookmarking for fast navigation
#
# mark [-f] <name>   Save current directory as a bookmark
# jump <name>        cd to a bookmarked directory (aliased as j)
# marks              List all bookmarks
# unmark <name>      Remove a bookmark

BOOKMARKS_FILE="${HOME}/.local/share/bookmarks"

# Ensure the bookmarks file exists
[[ -f "$BOOKMARKS_FILE" ]] || { mkdir -p "${BOOKMARKS_FILE:h}" && touch "$BOOKMARKS_FILE" }

# Load existing bookmarks into zsh named directories
_bookmarks_load() {
  while IFS='=' read -r name dir; do
    [[ -n "$name" && -n "$dir" ]] && hash -d "$name"="$dir"
  done < "$BOOKMARKS_FILE"
}
_bookmarks_load

mark() {
  local force=0
  while [[ "$1" == -* ]]; do
    case "$1" in
      -f|--force) force=1; shift ;;
      --) shift; break ;;
      -*) echo "Unknown flag: $1"; echo "Usage: mark [-f|--force] <name>"; return 1 ;;
    esac
  done

  if [[ -z "$1" ]]; then
    echo "Usage: mark [-f|--force] <name>"
    return 1
  fi

  local name="$1"

  if [[ "$name" == */* || "$name" == *=* || "$name" == *[[:space:]]* ]]; then
    echo "Invalid bookmark name: '$name' (no /, =, or whitespace)"
    return 1
  fi

  if (( ! force )) && grep -q "^$name=" "$BOOKMARKS_FILE" 2>/dev/null; then
    local existing_dir
    existing_dir=$(grep "^$name=" "$BOOKMARKS_FILE" | head -1 | cut -d= -f2-)
    echo "Warning: bookmark '$name' already points to: $existing_dir"
    echo "Re-run with -f/--force to overwrite."
    return 1
  fi

  # Remove existing entry for this name, then append
  if [[ -f "$BOOKMARKS_FILE" ]]; then
    local tmp=$(grep -v "^$name=" "$BOOKMARKS_FILE")
    printf '%s\n' "$tmp" > "$BOOKMARKS_FILE"
  fi
  echo "$name=$PWD" >> "$BOOKMARKS_FILE"
  hash -d "$name"="$PWD"
  echo "Bookmarked: ~$name → $PWD"
}

jump() {
  if [[ -z "$1" ]]; then
    echo "Usage: jump <name>"
    return 1
  fi
  local dir
  dir=$(grep "^$1=" "$BOOKMARKS_FILE" | head -1 | cut -d= -f2-)
  if [[ -z "$dir" ]]; then
    echo "No bookmark named '$1'"
    return 1
  fi
  if [[ ! -d "$dir" ]]; then
    echo "Directory no longer exists: $dir"
    return 1
  fi
  cd "$dir"
}
alias j='jump'

marks() {
  if [[ ! -s "$BOOKMARKS_FILE" ]]; then
    echo "No bookmarks saved."
    return
  fi
  printf '%-15s %s\n' "BOOKMARK" "DIRECTORY"
  printf '%-15s %s\n' "--------" "---------"
  while IFS='=' read -r name dir; do
    [[ -n "$name" ]] && printf '%-15s %s\n' "$name" "$dir"
  done < "$BOOKMARKS_FILE"
}

unmark() {
  if [[ -z "$1" ]]; then
    echo "Usage: unmark <name>"
    return 1
  fi
  if ! grep -q "^$1=" "$BOOKMARKS_FILE" 2>/dev/null; then
    echo "No bookmark named '$1'"
    return 1
  fi
  local tmp=$(grep -v "^$1=" "$BOOKMARKS_FILE")
  printf '%s\n' "$tmp" > "$BOOKMARKS_FILE"
  unhash -d "$1" 2>/dev/null
  echo "Removed bookmark: $1"
}

# Tab completion for jump and unmark
_bookmark_names() {
  if [[ -f "$BOOKMARKS_FILE" ]]; then
    local names=(${(f)"$(cut -d= -f1 "$BOOKMARKS_FILE")"})
    compadd -a names
  fi
}
compdef _bookmark_names jump j unmark
