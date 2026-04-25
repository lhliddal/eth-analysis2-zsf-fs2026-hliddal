# tests/

Lint- und Struktur-Checks für das Projekt.

## Skripte

- `check_main_full.sh` — prüft, dass `main.tex` alle 11 Kapitel in Reihenfolge lädt.
- `check_chapter_rules.sh` — verbietet `\vspace`/`\hspace`, rohe `\sum\limits`/`\lim\limits`, `\rowcolor`/`\columncolor`, `\operatorname{grad|div|rot}`, `\mathbb{...}` in Kapiteln (zentrale Makros nutzen).
- `check_root_clean.sh` — blockt unerwartete Dateien im Projekt-Root.
- `check_pdf_identity.sh` — prüft Author/Title/Subject/Keywords im gebauten PDF.
- `run_test.sh <datei.tex>` — baut eine Standalone-Testdatei aus `tests/` in `tests/build/`.

## Standalone-Testdateien

Lege neue `test_*.tex` hier ab, nicht im Root. `run_test.sh <name>` baut sie.

Für reine Scratch-Experimente: `_scratch/`.
