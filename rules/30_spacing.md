---
description: "Spacing-Register (ZSFspace*), Gap-Makros (ZSFgap*), Section-Gap — keine rohen Spacing-/Break-Befehle in Kapiteln, Overflow-Vermeidung"
globs: ["chapters/**/*.tex", "styles/30_layout_spacing.tex", "styles/70_document_settings.tex"]
alwaysApply: false
decisionOwner: ai
decisionStatus: final
lastUpdatedBy: loris
lastUpdatedAt: 2026-06-10
---

Die 4 Spalten auf einer A4-Querformat-Seite sind extrem schmal (~50 mm). Alle Abstände müssen exakt und zentral gesteuert werden. Alle Werte liegen in `styles/30_layout_spacing.tex`. **Nie** hardcodierte `pt`-Werte in Kapiteln oder Box-Definitionen.

## Abstands-Makros

- **Box-interne Abstände:** `\ZSFspaceXS` (1pt), `\ZSFspaceS` (3pt), `\ZSFspaceM` (6pt), `\ZSFspaceL` (9pt)
- **Semantische Gaps zwischen Blöcken (in Kapiteln erlaubt):** `\ZSFgapXS/S/M/L`, `\ZSFSectionGap` (vor neuem Themenblock)
- Box-Before/After-Skips sind zentral in `30_layout_spacing.tex` gesetzt.

## Verbotene Abstände in Kapiteln

Folgende Befehle brechen den Linter (`tests/check_chapter_rules.sh`):

- `\vspace`, `\hspace`, `\newpage`, `\columnbreak` (Ausnahme: Anhang), `\nopagebreak`, `\smallskip`, `\medskip`, `\bigskip`, `\\[…]` im Fließtext.

## Spalten-Overflows (Overfull hboxes) verhindern

- **Matrix-Stapelung:** Größere Matrizen (z. B. $A\cdot x = b$ oder Zerlegungen) niemals horizontal nebeneinander — stets vertikal untereinander stapeln.
- **Formelumbrüche:** Lange Gleichungen mit Text-Labels über `aligned` auf mehrere Zeilen aufteilen, max. eine Gleichung pro Zeile.

## Anhang-Sonderregelung

Sobald ein Fork einen Anhang einführt (`chapters/NN_anhang.tex`), gelten dort abweichende Regeln (enge Pack-Dichte gewünscht):

1. **Boxen breakable:** `\tcbset{breakable}` am Kapitel-Anfang.
2. **Keine Break-Reserven:** `\renewcommand{\BreakIfNotEnoughSpace}{}` und `\renewcommand{\BreakIfNotEnoughSpaceChapter}{}`.
3. **Spacing lokal verdichten** (`ZSFspaceS/M/L` lokal) — globale Werte unangetastet lassen.
4. **Manuelle Breaks erlaubt** (`\clearpage`, `\columnbreak`) — nur im Anhang.
