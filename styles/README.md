# Style Modules

This directory contains the internal modular style system loaded by preamble.tex.

- 00_packages.tex: package imports and package-level setup
- 10_math.tex: global math operators and sum/lim mode macros
- 20_tables.tex: table column types and cellspace/table helpers
- 30_layout_spacing.tex: global layout and spacing scale
- 40_colors_structure.tex: chapter palette and chapter-start orchestration
- 50_typography_semantics.tex: typography and semantic content helpers
- 60_boxes.tex: tcolorbox styles, chapter/subsection bars, derivation blocks
- 70_document_settings.tex: hyperref/list/math/table final settings

Keep chapter files content-focused and route layout/styling through these modules.

## Anhang-Sonderregelung (chapters/11_anhang.tex)

**Der Anhang wird NUR auf expliziten Nutzer-Befehl verändert.** Niemals "im
Vorbeigehen" bei globalen Style-Refactorings. Bei globalen Änderungen
stattdessen den Header-Kompensations-Block oben in `11_anhang.tex` erweitern.

Der Anhang folgt **eigenen Layout-Regeln** und MUSS bei jeder Änderung am
globalen Style-System separat geprüft und ggf. lokal kompensiert werden:

1. **Boxen müssen brechen können** über Spalten-/Seitengrenzen (im Rest des
   Dokuments sind Boxen unbreakable, damit Blöcke nicht zerschnitten werden).
2. **Keine `\BreakIfNotEnoughSpace`-Reserven** im Anhang (dort ist dichter
   Satz erwünscht, kein Whitespace am Spaltenende).
3. **Spacing-Skala** (`ZSFspaceS/M/L`) wird im Anhang lokal auf ihre
   ursprünglichen, dichteren Werte (2/4/8pt) zurückgesetzt. Wenn die
   globalen Werte geändert werden, ändert sich der Anhang nicht mit.
4. **Manuelle Page-/Column-Breaks** sind im Anhang erlaubt (Anhang ist
   immer separat); im Rest des Dokuments sind sie verboten.

Diese Regelung steht zusätzlich als Kommentar oben in `chapters/11_anhang.tex`.
Bei Refactorings am Style-System: Anhang explizit visuell verifizieren.
