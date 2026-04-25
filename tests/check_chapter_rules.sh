#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHAPTER_DIR="$ROOT_DIR/chapters"

if [[ ! -d "$CHAPTER_DIR" ]]; then
  echo "chapters directory not found: $CHAPTER_DIR"
  exit 1
fi

patterns=(
  '\\vspace\*?\{'
  '\\hspace\*?\{'
  '\\sum\\(limits|nolimits)'
  '\\lim\\(limits|nolimits)'
  '\\columncolor\{'
  '\\rowcolor\{'
  '\\operatorname\{(grad|div|rot)\}'
  '\\mathbb\{[RCNZQ]\}'
)

messages=(
  'Use central spacing macros instead of local \\vspace.'
  'Use central spacing macros instead of local \\hspace.'
  'Use ZSFsumSide/ZSFsumStack/ZSFsumAuto instead of raw \\sum limits toggles.'
  'Use ZSFlimAuto (or central lim mode) instead of raw \\lim limits toggles.'
  'Use centralized table color macros/types; avoid direct \\columncolor in chapters.'
  'Use \\ZSFrowColor instead of direct \\rowcolor in chapters.'
  'Use \\grad, \\divg, \\rot instead of \\operatorname{...}.'
  'Use \\R, \\C, \\N, \\Z, \\Q instead of \\mathbb{...}.'
)

violations=0

search_matches() {
  local pattern="$1"
  local file="$2"
  if command -v rg >/dev/null 2>&1; then
    rg -n --pcre2 "$pattern" "$file"
  else
    grep -nE "$pattern" "$file"
  fi
}

while IFS= read -r file; do
  for i in "${!patterns[@]}"; do
    if search_matches "${patterns[$i]}" "$file" >/dev/null; then
      echo "[RULE VIOLATION] $file"
      search_matches "${patterns[$i]}" "$file"
      echo "  -> ${messages[$i]}"
      violations=1
    fi
  done
done < <(find "$CHAPTER_DIR" -name '*.tex' | sort)

if [[ "$violations" -ne 0 ]]; then
  echo "Chapter rule check failed."
  exit 1
fi

echo "Chapter rule check passed."
