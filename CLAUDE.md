# ZSF Analysis 2 — CLAUDE.md

> AUTO-GENERATED — rules-hash:78c1d91dfa4e67af
>
> Quelle: `rules/*.md` (mit YAML-Frontmatter).
> Nicht direkt bearbeiten. Änderungen: `rules/*.md` editieren → `make sync-rules`.
> Drift-Check: `make check-rules`.

Kompiliertes Regelwerk für Claude / Anthropic. Diese Datei ist eigenständig — sie enthält alle Projekt-Regeln für Tools, die nur `CLAUDE.md` lesen.

## Source of Truth

Bei Konflikt zwischen dieser Datei und `rules/*.md` gewinnen die Quelldateien.

- `rules/00_meta.md`
- `rules/10_architecture.md`
- `rules/20_boxes.md`
- `rules/30_spacing.md`
- `rules/40_tables.md`
- `rules/50_math.md`
- `rules/60_workflow.md`
- `rules/70_github.md`
- `rules/80_didaktik.md`

## Working Commands

- `make build`        — latexmk → `$(PDF_BASENAME).pdf` (Aux-Files nach build/)
- `make check`        — full check (main, chapters, root, pdf-identity, lint, rule-authorship, rules)
- `make sync-rules`   — `rules/*.md` → alle Adapter regenerieren
- `make check-rules`  — Drift-Check über Hash-Stempel

## Operating Mode

- Wenn dies die einzige geladene KI-Regel-Datei ist, gelten die kompilierten Regeln unten als verbindlich.
- `alwaysApply: true`-Regeln sind Projekt-weit aktiv. `globs`-Scope-Regeln greifen nur bei passenden Pfaden.
- Niemals diese Datei direkt editieren — immer `rules/*.md` ändern und neu kompilieren.

## Rule Index

- `00_meta.md` — Project-wide — ZSF Analysis 2 — Projekt-Meta, Zweck, kritische Regeln (Sprache, Modularität, keine Inhaltsänderung ohne Befehl)
- `10_architecture.md` — Project-wide; besonders relevant für `main.tex`, `preamble.tex`, `chapters/**/*.tex`, `styles/**/*.tex` — Verzeichnis-Architektur, Modul-Verantwortlichkeiten, Verbote in Kapiteln, Fork-Guardrails (keine Module/Tests löschen)
- `20_boxes.md` — Scoped; gilt bei Änderungen an `chapters/**/*.tex`, `styles/60_boxes.tex`, `styles/40_colors_structure.tex`, `styles/50_typography_semantics.tex` — Box-Auswahl (Decision Tree), Struktur-Makros (StartChapter, SubsectionBar), Inline-Marker (ZSFkeyword, ZSFdanger, ZSFconclusion), Kapitel-Skeleton
- `30_spacing.md` — Scoped; gilt bei Änderungen an `chapters/**/*.tex`, `styles/30_layout_spacing.tex`, `styles/70_document_settings.tex` — Spacing-Register (ZSFspace*), Gap-Makros (ZSFgap*), Section-Gap — keine rohen Spacing-/Break-Befehle in Kapiteln, Overflow-Vermeidung
- `40_tables.md` — Scoped; gilt bei Änderungen an `chapters/**/*.tex`, `styles/20_tables.tex` — Tabellen über zentrale Spaltentypen (C/L/R, F/T/H, proportional Y/Z/Q + f/t/h) aus styles/20_tables.tex; verbotene Roh-Tabellen-Befehle
- `50_math.md` — Scoped; gilt bei Änderungen an `chapters/**/*.tex`, `styles/10_math.tex` — Math-Makros: Mengen (R,C,N,Z,Q), Differential, sum/lim-Modi (ZSFsumAuto/ZSFlimAuto), gepaarte Begrenzer (abs/norm) — keine rohen \\mathbb in Kapiteln
- `60_workflow.md` — Project-wide — Build-/Check-Workflow (make build/check/sync-rules/check-rules), Agent-Build-Pflicht nach jeder Änderung, Datei-Platzierung
- `70_github.md` — Scoped; gilt bei Änderungen an `.github/**`, `Makefile`, `tests/**`, `styles/75_pdf_identity.tex`, `README.md` — Naming-Konventionen (Repo, PDF, Tags), GitHub Actions (CI Build, Release), PDF-Identity als Single Source of Truth
- `80_didaktik.md` — Project-wide; besonders relevant für `chapters/**/*.tex` — Didaktisches Prinzip für Inhalt/Erklärungen: nützlicher + intuitiver statt korrekter, Rezept-Charakter, Stolperfallen, scannbares Design + Übersichtlichkeit — keine eigenmächtigen Präzisierungen

## Compiled Rules

### `00_meta.md`

- Quelle: `rules/00_meta.md`
- Scope: Project-wide
- Beschreibung: ZSF Analysis 2 — Projekt-Meta, Zweck, kritische Regeln (Sprache, Modularität, keine Inhaltsänderung ohne Befehl)
- Zuletzt aktualisiert: 2026-06-10 (loris)

LaTeX-Zusammenfassung Analysis 2 (D-MAVT FS2026). A4 Querformat, 4 Spalten, 8pt, strikt modular (`extarticle`). Layout, Farben und Boxen werden zentral in `styles/` gesteuert; Kapitel fokussieren sich vollständig auf Fach-Inhalt.

**Zweck:** Prüfungsvorbereitung — wird direkt in der Prüfung verwendet. Schnelle Auffindbarkeit und visuelle Klarheit haben höchste Priorität.

##### Kritische Regeln

- **Build-Befehl:** Nach jeder Änderung ausschließlich `make build` verwenden — keine alternativen oder abgekürzten Kommandos (`latexmk`, `pdflatex`, …). Erst nach erfolgreichem Build gilt eine Aufgabe als erledigt.
- **Inhalte niemals ändern, kürzen oder vereinfachen** ohne expliziten Befehl.
- Keine neuen Packages oder Makros ohne explizite Anfrage hinzufügen.
- Stil und Struktur (Boxtypen, Farben, Abstände) konsistent mit bestehendem System halten.
- **Modularität ist Pflicht:** Abstände, Farben, Makros, Strukturen gehören in `styles/*.tex`. Hardcodierte Werte direkt in Box-Definitionen oder Kapiteldateien sind verboten.
- **Sprache:** Inhalte auf Deutsch. Technische Begriffe auf Englisch erlaubt. LaTeX-Labels, Befehle, Dateinamen auf Englisch.
- Vor Commit: `make check` (Lint + Strukturtests + PDF-Identität + Rule-Drift).

### `10_architecture.md`

- Quelle: `rules/10_architecture.md`
- Scope: Project-wide; besonders relevant für `main.tex`, `preamble.tex`, `chapters/**/*.tex`, `styles/**/*.tex`
- Beschreibung: Verzeichnis-Architektur, Modul-Verantwortlichkeiten, Verbote in Kapiteln, Fork-Guardrails (keine Module/Tests löschen)
- Zuletzt aktualisiert: 2026-06-10 (loris)

Die Konfiguration ist modular organisiert. Bei Layout-Änderungen NICHT die Kapitel oder `preamble.tex` ändern, sondern das passende Modul in `styles/`.

##### Modul-Verantwortlichkeiten

| Kategorie | Ort |
|---|---|
| Pakete | `styles/00_packages.tex` |
| Math-Makros (Mengen, sum/lim, Operatoren) | `styles/10_math.tex` |
| Tabellen-Spaltentypen | `styles/20_tables.tex` |
| Abstände, Layout, multicols | `styles/30_layout_spacing.tex` |
| Farben, Kapitel-Paletten, Struktur-Makros | `styles/40_colors_structure.tex` |
| Schrift / Semantik | `styles/50_typography_semantics.tex` |
| Lesbarkeit (Hyphenation/Penalties) | `styles/55_readability.tex` |
| Box-Umgebungen (tcolorbox) | `styles/60_boxes.tex` |
| Dokument-Settings | `styles/70_document_settings.tex` |
| PDF-Identity / Owner-Marker | `styles/75_pdf_identity.tex` |
| Inhalte | `chapters/XX_*.tex` |
| KI-Regelwerke (Quell-Wahrheit) | `rules/*.md` |

`main.tex` = nur Document-Class + `\input{preamble}` + Kapitel-`\input`. `preamble.tex` = nur Loader für `styles/*.tex`.

##### Fork-Guardrails (verbindlich)

- Module und Tests dürfen **nicht gelöscht** werden. Das Tabellen-Modul (`20_tables.tex`, eigenes Spaltentyp-System) und die Tests (inkl. `check_pdf_identity.sh`) bleiben vollständig; `make check` muss `check-pdf-identity` enthalten.

##### Verboten in Kapitel-Dateien

- Abstände: `\vspace`, `\hspace`, `\medskip`, `\bigskip`, `\smallskip`, `\newpage`, `\columnbreak`, `\nopagebreak` → stattdessen `\ZSFgapXS/S/M/L`, `\ZSFSectionGap`
- Schrift/Hervorhebung direkt: `\textbf`, `\textit`, `\textsf`, `\scriptsize`, `\small`, `\large` → semantische Marker (siehe `20_boxes`)
- Rohe Tabellen: `\begin{tabular}`, `\rowcolor`, `\rowcolors`, `\columncolor`, `\arrayrulecolor` → Tabellen über die zentralen Spaltentypen + Tabellen-Boxen (siehe `40_tables`)
- Strukturbefehle: `\section`, `\subsection`, `\chapter` → `\StartChapter` / `\StartFrontChapter` / `\SubsectionBar`
- `\usepackage` → alles in `styles/00_packages.tex`
- Hartkodierte Kapitelfarben → `\chaptercolor` / `\chaptercolorlight`

##### Verboten in Box-Definitionen (`styles/*.tex`)

- Hardcodierte `pt`/`em`/`mm`-Werte → immer `\ZSFspace*`-Register
- Direkte Schriftbefehle → immer `\ZSFfont*`-Makros
- Direkte Farb-Tints → immer benannte `\colorlet`

### `20_boxes.md`

- Quelle: `rules/20_boxes.md`
- Scope: Scoped; gilt bei Änderungen an `chapters/**/*.tex`, `styles/60_boxes.tex`, `styles/40_colors_structure.tex`, `styles/50_typography_semantics.tex`
- Beschreibung: Box-Auswahl (Decision Tree), Struktur-Makros (StartChapter, SubsectionBar), Inline-Marker (ZSFkeyword, ZSFdanger, ZSFconclusion), Kapitel-Skeleton
- Zuletzt aktualisiert: 2026-06-10 (loris)

Für inhaltliche Darstellungen müssen die vordefinierten Umgebungen genutzt werden. Das Layout- und Formel-System ist strikt modular.

##### Box-Auswahl (Decision Tree)

| Was wird ausgedrückt? | Box / Umgebung |
| :--- | :--- |
| Definition / Satz / Lemma | `defbox[Titel]` |
| Tabelle (mit Header/ohne, mit Zebra/ohne) | `tablebox[Titel]` |
| Abbildung | `figbox[Titel]` |
| Formel(n), evtl. mit Kontext | `formulabox` |
| Warnung / Stolperfalle | `warnbox[Titel]` |
| Eigenschaft / kurze Aussage | `statementbox[Titel]` |
| Schritt-für-Schritt-Verfahren | `procedure[Titel]` + `\ProcStep` |
| Lose Faktenliste | `factlist` + `\ZSFFact` |
| Faktenliste mit Rahmen + Titel | `propertylist[Titel]` + `\ZSFFact` |
| Wertetabelle (kompakt) | `valuegrid{n}[Titel]` |
| Ziele / Bedingungen (kompaktes Grid) | `goalbox`, `compactgridbox` |
| Bild + Text nebeneinander | `splitbox[fraction]` |
| Reiner Fließtext-Block | `runintext` |

##### Nutzungsregeln

- **defbox vs. statementbox:** Im Zweifel `defbox` für gewichtige Sätze und Definitionen (Titel **und** beliebiger Inhalt). `statementbox` (dezenter linker Farbbalken) für kleinere Aussagen oder kompakte Sätze.
- **Formel-Grouping:** Mehrere verwandte Formeln gehen in **eine** `formulabox` mit `\formulasep` (graue Trennlinie) und optionalen Beschreibungen via `\formulanote`. Für gleichwertige Fälle: `\ZSFItemHeading{Fall A}`.
- **Bilder:** Ausschließlich über `figbox` + `\ZSFfig{path}`. Niemals nackte `\includegraphics`-Befehle in Kapiteln.

##### Struktur-Makros

| Makro | Verwendung |
|---|---|
| `\StartChapter[label]{Titel}` | Hauptkapitel mit auto-Nummerierung + Farbpalette (Index) |
| `\StartFrontChapter{Titel}` | Unnummeriertes Kapitel (Front-Matter, ETH-Rot) |
| `\SubsectionBar[label]{Titel}` | Nummerierter Abschnitt mit farbigem Balken |
| `\SubsectionBar*{Titel}` | Unnummerierter Abschnitt |

Niemals `\section` / `\subsection` / `\chapter` direkt verwenden.

##### Inline-Marker

- `\ZSFkeyword{Fachbegriff}` — zentrale Fachbegriffe als **primäre Scan-Anker**, im Fließtext und direkt in Box-Inhalten. Sparsam pro Block (1–3 pro `runintext`, ca. 8–14 pro Kapitel). Nicht in Formeln, Notizen oder Überschriften.
- `\ZSFdanger{Achtung-Text}` — Inline-Pill für Stolperfallen / kritische Ausnahmen.
- `\ZSFconclusion{Folgerung}` — leitet eine Folgerung ein (gerendert als $\Rightarrow$).
- `\ZSFref{label}` — Querverweis, gerendert als `(→ 6.6)` in der Farbe des Zielkapitels. **Neue** Querverweise nur, wenn ein Schritt ein Verfahren aus einem **anderen** Kapitel delegiert — nicht für elementare Operationen. Hartcodierte Abschnittsnummern (z. B. `[9.8]`) sind verboten — jeder Nummern-Verweis läuft über `\ZSFref`, auch innerhalb desselben Kapitels. Ziel-Label via `\SubsectionBar[sec:...]{Titel}`.
- **Formatierungs-Verbot:** Niemals `\textbf{}` / `\textit{}` zur semantischen Hervorhebung — immer die obigen Marker.

##### Farb-Palette

- 20 Slots (`ChapterColor0..19` + `*Light`-Varianten), perzeptuell sortiert (CIEDE2000).
- Slot 0 reserviert für `\StartFrontChapter` (ETH-Rot).
- Kapitelfarben niemals hardcoden — nur `\chaptercolor` / `\chaptercolorlight`.

##### Kapitel-Skeleton

```tex
\StartChapter[ch:label]{Kapiteltitel}

\begin{runintext}
  Einleitender Absatz mit \ZSFkeyword{Schluesselbegriff}.
\end{runintext}

\SubsectionBar{Erste Subsection}

\begin{defbox}[Definition]
  ...
\end{defbox}
```

### `30_spacing.md`

- Quelle: `rules/30_spacing.md`
- Scope: Scoped; gilt bei Änderungen an `chapters/**/*.tex`, `styles/30_layout_spacing.tex`, `styles/70_document_settings.tex`
- Beschreibung: Spacing-Register (ZSFspace*), Gap-Makros (ZSFgap*), Section-Gap — keine rohen Spacing-/Break-Befehle in Kapiteln, Overflow-Vermeidung
- Zuletzt aktualisiert: 2026-06-10 (loris)

Die 4 Spalten auf einer A4-Querformat-Seite sind extrem schmal (~50 mm). Alle Abstände müssen exakt und zentral gesteuert werden. Alle Werte liegen in `styles/30_layout_spacing.tex`. **Nie** hardcodierte `pt`-Werte in Kapiteln oder Box-Definitionen.

##### Abstands-Makros

- **Box-interne Abstände:** `\ZSFspaceXS` (1pt), `\ZSFspaceS` (3pt), `\ZSFspaceM` (6pt), `\ZSFspaceL` (9pt)
- **Semantische Gaps zwischen Blöcken (in Kapiteln erlaubt):** `\ZSFgapXS/S/M/L`, `\ZSFSectionGap` (vor neuem Themenblock)
- Box-Before/After-Skips sind zentral in `30_layout_spacing.tex` gesetzt.

##### Verbotene Abstände in Kapiteln

Folgende Befehle brechen den Linter (`tests/check_chapter_rules.sh`):

- `\vspace`, `\hspace`, `\newpage`, `\columnbreak` (Ausnahme: Anhang), `\nopagebreak`, `\smallskip`, `\medskip`, `\bigskip`, `\\[…]` im Fließtext.

##### Spalten-Overflows (Overfull hboxes) verhindern

- **Matrix-Stapelung:** Größere Matrizen (z. B. $A\cdot x = b$ oder Zerlegungen) niemals horizontal nebeneinander — stets vertikal untereinander stapeln.
- **Formelumbrüche:** Lange Gleichungen mit Text-Labels über `aligned` auf mehrere Zeilen aufteilen, max. eine Gleichung pro Zeile.

##### Anhang-Sonderregelung

Sobald ein Fork einen Anhang einführt (`chapters/NN_anhang.tex`), gelten dort abweichende Regeln (enge Pack-Dichte gewünscht):

1. **Boxen breakable:** `\tcbset{breakable}` am Kapitel-Anfang.
2. **Keine Break-Reserven:** `\renewcommand{\BreakIfNotEnoughSpace}{}` und `\renewcommand{\BreakIfNotEnoughSpaceChapter}{}`.
3. **Spacing lokal verdichten** (`ZSFspaceS/M/L` lokal) — globale Werte unangetastet lassen.
4. **Manuelle Breaks erlaubt** (`\clearpage`, `\columnbreak`) — nur im Anhang.

### `40_tables.md`

- Quelle: `rules/40_tables.md`
- Scope: Scoped; gilt bei Änderungen an `chapters/**/*.tex`, `styles/20_tables.tex`
- Beschreibung: Tabellen über zentrale Spaltentypen (C/L/R, F/T/H, proportional Y/Z/Q + f/t/h) aus styles/20_tables.tex; verbotene Roh-Tabellen-Befehle
- Zuletzt aktualisiert: 2026-06-10 (loris)

Analysis 2 nutzt ein eigenes Spaltentyp-System (definiert in `styles/20_tables.tex`), auf das die Kapitel geschrieben sind. **Dieses System nicht durch ein fremdes ersetzen** — Formatierung gehört zentral, nicht in die Kapitel.

##### Spaltentypen (aus `styles/20_tables.tex`)

Feste Breite (gleichverteilt, umbrechend):
- `C` — zentriert, `L` — linksbündig, `R` — rechtsbündig
- `T` — Standard-Text (linksbündig)
- `F` — zentrierte Formelspalte (Mathe-Modus)
- `H` — Formelspalte mit Hintergrund (`FormulaboxBackColor`)

Proportional (Argument = Anteil an `\hsize`):
- `Y{n}` zentriert · `Z{n}` linksbündig · `Q{n}` rechtsbündig
- `f{n}` Formel · `t{n}` Text · `h{n}` Formel mit Hintergrund

`\TableTitle{...}` für Spaltentitel verwenden.

##### Verboten in Kapiteln

- `\begin{tabular}`, rohes `\rowcolor`/`\rowcolors`/`\columncolor`, `\arrayrulecolor` — Farben/Streifen kommen zentral aus `styles/`.
- Keine eigenen `\newcolumntype`-Definitionen in Kapiteln — nur in `styles/20_tables.tex`.

### `50_math.md`

- Quelle: `rules/50_math.md`
- Scope: Scoped; gilt bei Änderungen an `chapters/**/*.tex`, `styles/10_math.tex`
- Beschreibung: Math-Makros: Mengen (R,C,N,Z,Q), Differential, sum/lim-Modi (ZSFsumAuto/ZSFlimAuto), gepaarte Begrenzer (abs/norm) — keine rohen \\mathbb in Kapiteln
- Zuletzt aktualisiert: 2026-06-10 (loris)

Mathematische Notation über die zentralen Makros aus `styles/10_math.tex` abbilden, statt roher `\mathbb{}`/`\operatorname{}`-Befehle.

- **Zahlmengen:** `\R`, `\C`, `\N`, `\Z`, `\Q`.
- **Differentialoperator:** `\dd`.
- **Operatoren:** `\sgn`, `\grad`, `\divg`, `\rot`; Vektoren `\vect{…}`.
- **Begrenzer:** `\abs{…}`, `\norm{…}` (gepaart, mathtools).
- **Summen/Limites:** `\ZSFsumAuto{sub}{super}` statt `\sum\limits`/raw `\sum`; `\ZSFlimAuto{sub}` statt `\lim\limits`. Umschalten side/stack/auto via `\SetZSFsumMode` / `\SetZSFlimMode`.
- Neue Makros nur in `styles/10_math.tex` ergänzen (nach Rücksprache). Lange Formeln über `aligned` umbrechen.

### `60_workflow.md`

- Quelle: `rules/60_workflow.md`
- Scope: Project-wide
- Beschreibung: Build-/Check-Workflow (make build/check/sync-rules/check-rules), Agent-Build-Pflicht nach jeder Änderung, Datei-Platzierung
- Zuletzt aktualisiert: 2026-06-10 (loris)

##### Workflow-Befehle

```bash
make build                  # latexmk -> analysis2_fs2026_hliddal.pdf (Aux nach build/)
make check                  # check-main-full + check-chapters + check-root-clean
                            #   + check-pdf-identity + lint + check-rule-authorship + check-rules
make sync-rules             # rules/*.md -> MODULAR_SYSTEM.md, CLAUDE.md, AGENTS.md,
                            #   .github/copilot-instructions.md, .cursor/rules/*.mdc
make check-rules            # Drift-Check (Hash-Stempel) gegen rules/*.md
make check-rule-authorship  # Pflicht-Frontmatter prüfen
make clean                  # build/ + aux entfernen
```

Der Rule-Compiler liegt in `tools/sync-agent-rules.mjs` (Node 18+). Quellen sind `rules/*.md` mit YAML-Frontmatter.

##### Agent-Build-Pflicht

Nach **jeder** Änderung sofort `make build` ausführen — immer genau dieser Befehl. Erst nach erfolgreichem Build gilt eine Aufgabe als erledigt.

##### Regeln ändern

KI-Regeln **nie** direkt in `CLAUDE.md`/`AGENTS.md`/`MODULAR_SYSTEM.md`/`.github/copilot-instructions.md`/`.cursor/rules/*` editieren (alle auto-generiert). Stattdessen `rules/*.md` ändern → `make sync-rules` → `make check-rules` muss synchron melden.

##### Datei-Platzierung

Root ist tabu für Fremd-Dateien (`tests/check_root_clean.sh` blockt). Neues gehört in `chapters/`, `styles/`, `tests/`, `scripts/`, `tools/`, `rules/`, `graphics/`, `_scratch/`.

### `70_github.md`

- Quelle: `rules/70_github.md`
- Scope: Scoped; gilt bei Änderungen an `.github/**`, `Makefile`, `tests/**`, `styles/75_pdf_identity.tex`, `README.md`
- Beschreibung: Naming-Konventionen (Repo, PDF, Tags), GitHub Actions (CI Build, Release), PDF-Identity als Single Source of Truth
- Zuletzt aktualisiert: 2026-06-10 (loris)

##### Namenskonventionen

- **Repository:** `eth-analysis2-zsf-fs2026-hliddal` (Muster: `eth-<fach>-zsf-<semester>-hliddal`)
- **PDF:** `analysis2_fs2026_hliddal.pdf` (Muster: `fach_semester_hliddal.pdf`)
- **Semesterformat:** `fsYYYY` oder `hsYYYY`
- **Release-Tags:** Semantic Versioning `vMAJOR.MINOR.PATCH`

##### GitHub Actions

- **Workflow `CI Build`** (push/PR auf `main`): `make check` + `make build`, PDF als Artifact.
- **Workflow `Release PDF`** (push auf Tag `v*`): `make check` + `make build` + `make release-proof`; Release mit PDF + SHA256.

##### PDF-Identity / Authentizität

`styles/75_pdf_identity.tex` ist Single Source of Truth für `\ZSFOwnerNameASCII` (Author), `\ZSFOwnerID` (`LEKH-ZSF-ANA2-2026-A1B2`), `\ZSFReleaseID`, `\ZSFBuildID` sowie Title/Subject/Keywords. `tests/check_pdf_identity.sh` prüft die Metadaten nach Build (Teil von `make check`) — der Test darf nicht entfernt werden.

##### Konsistenz bei Naming-Änderungen

Naming-Patterns immer konsistent halten in: `Makefile`, `tests/check_root_clean.sh`, `styles/75_pdf_identity.tex`, `README.md`, `.github/workflows/*.yml`, `rules/70_github.md`.

### `80_didaktik.md`

- Quelle: `rules/80_didaktik.md`
- Scope: Project-wide; besonders relevant für `chapters/**/*.tex`
- Beschreibung: Didaktisches Prinzip für Inhalt/Erklärungen: nützlicher + intuitiver statt korrekter, Rezept-Charakter, Stolperfallen, scannbares Design + Übersichtlichkeit — keine eigenmächtigen Präzisierungen
- Zuletzt aktualisiert: 2026-06-10 (loris)

Diese Regel betrifft **was** drinsteht und **wie** erklärt wird (nicht das Layout). Vollständige Leitlinie: `ZSF_DIDAKTIK_PRINZIP.md`.

##### Maßstab

Die ZSF wird **direkt in der Prüfung** verwendet. Maßstab für jeden Satz:

> Hilft das beim schnellen, sicheren Lösen von Prüfungsaufgaben?

Nicht der Maßstab ist Vollständigkeit, Allgemeinheit oder lückenlose Strenge.

##### Kernregeln

- **Ungenauigkeiten auf Kursniveau sind toleriert**, solange sie intuitiv tragfähig sind.
- **Sonderfälle/Präzisierungen hinzuzufügen ist ein Fehler**, wenn sie die Aussage nur „wasserdicht", aber schwerer lesbar machen. Regel: nicht „korrekter" machen — sondern **nützlicher und intuitiver**.
- Gute Erklärung: Rezept-Charakter (`procedure` + `\ProcStep`), konkretes Zahlenbeispiel, Intuition in einem Satz, Stolperfallen via `\ZSFdanger`, Querchecks zur Selbstkontrolle.

##### Scannbarkeit & Übersichtlichkeit

- **Scannbares Design ist Pflicht:** In der Prüfung wird nicht gelesen, sondern gesucht. Jede Information muss in Sekunden auffindbar sein — über Boxen, Titel, Marker und visuelle Struktur statt Fließtext.
- **Übersichtlichkeit schlägt Dichte:** Lieber klar gegliederte Blöcke (Box pro Aussage, Tabelle statt Aufzählung im Text) als kompakte, aber unstrukturierte Absätze.
- Lange Fließtext-Passagen sind ein Warnsignal — Inhalt in `procedure`, `factlist`, Tabellen oder einzelne Boxen umstrukturieren, sodass das Auge beim Überfliegen hängen bleibt.

##### Konsequenz für KI-Assistenten

- Beim Review/Bearbeiten **keine** mathematischen Sonderfälle, Ausnahmen oder Präzisierungen eigenmächtig ergänzen.
- Erklärungen verbessern heißt: klarer formulieren, Beispiel/Intuition ergänzen, Stolperfalle markieren — **nicht** Korrektheit erhöhen.
- Inhalte nie ohne expliziten Befehl ändern, kürzen oder „korrigieren" (siehe `00_meta`).
