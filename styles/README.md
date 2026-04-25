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
