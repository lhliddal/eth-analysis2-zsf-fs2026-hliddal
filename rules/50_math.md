---
description: "Math-Makros: Mengen (R,C,N,Z,Q), Differential, sum/lim-Modi (ZSFsumAuto/ZSFlimAuto), gepaarte Begrenzer (abs/norm) — keine rohen \\mathbb in Kapiteln"
globs: ["chapters/**/*.tex", "styles/10_math.tex"]
alwaysApply: false
decisionOwner: ai
decisionStatus: final
lastUpdatedBy: loris
lastUpdatedAt: 2026-06-10
---

Mathematische Notation über die zentralen Makros aus `styles/10_math.tex` abbilden, statt roher `\mathbb{}`/`\operatorname{}`-Befehle.

- **Zahlmengen:** `\R`, `\C`, `\N`, `\Z`, `\Q`.
- **Differentialoperator:** `\dd`.
- **Operatoren:** `\sgn`, `\grad`, `\divg`, `\rot`; Vektoren `\vect{…}`.
- **Begrenzer:** `\abs{…}`, `\norm{…}` (gepaart, mathtools).
- **Summen/Limites:** `\ZSFsumAuto{sub}{super}` statt `\sum\limits`/raw `\sum`; `\ZSFlimAuto{sub}` statt `\lim\limits`. Umschalten side/stack/auto via `\SetZSFsumMode` / `\SetZSFlimMode`.
- Neue Makros nur in `styles/10_math.tex` ergänzen (nach Rücksprache). Lange Formeln über `aligned` umbrechen.
