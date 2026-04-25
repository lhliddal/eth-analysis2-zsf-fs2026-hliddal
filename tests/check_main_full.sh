#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAIN_TEX="${ROOT_DIR}/main.tex"

required_chapters=(
  "chapters/01_grundlagen"
  "chapters/02_komplexe_zahlen"
  "chapters/03_funktionen"
  "chapters/04_differentialrechnung"
  "chapters/05_funktionen_mehrere_variablen"
  "chapters/06_integrale"
  "chapters/07_integrale_mehrere_variablen"
  "chapters/08_vektoranalysis"
  "chapters/09_differentialgleichungen"
  "chapters/10_systeme_differentialgleichungen"
  "chapters/11_anhang"
)

if [ ! -f "${MAIN_TEX}" ]; then
  echo "Error: main.tex not found at ${MAIN_TEX}"
  exit 1
fi

status=0

for chapter in "${required_chapters[@]}"; do
  if ! awk -v c="${chapter}" 'BEGIN { ok=0 } $0 ~ "^[[:space:]]*\\\\input\\{" c "\\}" { ok=1 } END { exit ok ? 0 : 1 }' "${MAIN_TEX}"; then
    echo "[FULL BUILD CHECK] Missing active input: \\input{${chapter}}"
    status=1
  fi
done

if [ "${status}" -ne 0 ]; then
  echo "main.tex is not in full-build mode."
  exit 1
fi

echo "main.tex full-build check passed."
