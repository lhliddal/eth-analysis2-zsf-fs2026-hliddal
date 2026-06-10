---
description: "Tabellen über zentrale Spaltentypen (C/L/R, F/T/H, proportional Y/Z/Q + f/t/h) aus styles/20_tables.tex; verbotene Roh-Tabellen-Befehle"
globs: ["chapters/**/*.tex", "styles/20_tables.tex"]
alwaysApply: false
decisionOwner: ai
decisionStatus: final
lastUpdatedBy: loris
lastUpdatedAt: 2026-06-10
---

Analysis 2 nutzt ein eigenes Spaltentyp-System (definiert in `styles/20_tables.tex`), auf das die Kapitel geschrieben sind. **Dieses System nicht durch ein fremdes ersetzen** — Formatierung gehört zentral, nicht in die Kapitel.

## Spaltentypen (aus `styles/20_tables.tex`)

Feste Breite (gleichverteilt, umbrechend):
- `C` — zentriert, `L` — linksbündig, `R` — rechtsbündig
- `T` — Standard-Text (linksbündig)
- `F` — zentrierte Formelspalte (Mathe-Modus)
- `H` — Formelspalte mit Hintergrund (`FormulaboxBackColor`)

Proportional (Argument = Anteil an `\hsize`):
- `Y{n}` zentriert · `Z{n}` linksbündig · `Q{n}` rechtsbündig
- `f{n}` Formel · `t{n}` Text · `h{n}` Formel mit Hintergrund

`\TableTitle{...}` für Spaltentitel verwenden.

## Verboten in Kapiteln

- `\begin{tabular}`, rohes `\rowcolor`/`\rowcolors`/`\columncolor`, `\arrayrulecolor` — Farben/Streifen kommen zentral aus `styles/`.
- Keine eigenen `\newcolumntype`-Definitionen in Kapiteln — nur in `styles/20_tables.tex`.
