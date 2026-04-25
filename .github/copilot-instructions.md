# ETH Analysis 2 – Formelsammlung (ZSF) · Copilot Instructions

## Projektübersicht

LaTeX-Formelsammlung für ETH Analysis 2 (Differential-/Integralrechnung, mehrere Variablen, Vektoranalysis, DGL), A4 Querformat, 4 Spalten, 8pt.
Das Dokument ist **modular** aufgebaut:
- `main.tex` — Skelett: `\documentclass` + `\input{preamble}` + `\input` je Kapitel
- `preamble.tex` — Loader für `styles/*.tex` (kein eigener Inhalt)
- `styles/` — modulare Style-Module (`00_packages` … `75_pdf_identity`)
- `chapters/01_grundlagen.tex` … `chapters/11_anhang.tex` — je ein Kapitel als eigene Datei

Arbeitsumgebung: **macOS**, **VS Code** mit **LaTeX Workshop Extension** und **GitHub Copilot Agent**.

**Zweck:** Prüfungsvorbereitung — die Formelsammlung wird direkt in der Prüfung verwendet.
**Priorität:** Schnelle Auffindbarkeit und klare Übersicht haben höchste Priorität.

## Kritische Regeln

- **Formeln niemals ändern, kürzen oder vereinfachen** ohne expliziten Befehl. Alle Formeln bleiben vollständig und mathematisch korrekt.
- Keine neuen Packages oder Makros ohne explizite Anfrage hinzufügen.
- Stil und Struktur (Boxtypen, Farben, Abstände) konsistent mit bestehendem System halten.
- **Good Practice immer einhalten**: sauberer, lesbarer LaTeX-Code; bestehende Makros und Umgebungen konsequent nutzen statt Inline-Workarounds.
- **Modularität ist Pflicht**: Alles, was sinnvoll modular umgesetzt werden kann (Abstände, Farben, Makros, Strukturen), **muss** modular sein — über zentrale Register, Makros oder Stile in `styles/*.tex`. Hardcodierte Werte direkt in Box-Definitionen oder Kapiteldateien sind verboten.
- **Modular denken**: Erweiterungen so umsetzen, dass sie sich nahtlos ins bestehende System einfügen.

## Modulare Philosophie — konkrete Regeln

Single Source of Truth: jeder Wert existiert genau an einem Ort und wird überall referenziert.

### Was wo hingehört

| Kategorie | Ort |
|---|---|
| Pakete | `styles/00_packages.tex` |
| Math-Makros (`\ZSFsum*`, `\ZSFlim*`, `\R`, `\C`, `\grad`, `\divg`, `\rot`, …) | `styles/10_math.tex` |
| Tabellen-Spaltentypen, Wrapper (`valuegrid`, `\ZSFrowColor`) | `styles/20_tables.tex` |
| Abstände, Layout, multicols | `styles/30_layout_spacing.tex` |
| Farben + Kapitel-Paletten | `styles/40_colors_structure.tex` |
| Schrift / Semantik | `styles/50_typography_semantics.tex` |
| Lesbarkeit (Hyphenation/Penalties) | `styles/55_readability.tex` |
| Box-Umgebungen (tcolorbox) | `styles/60_boxes.tex` |
| Hyperref-Settings | `styles/70_document_settings.tex` |
| PDF-Identity / Owner-Marker | `styles/75_pdf_identity.tex` |
| Inhalte | `chapters/XX_*.tex` |

### Verboten in Kapitel-Dateien

- Abstände: `\vspace`, `\hspace`, `\medskip`, `\bigskip`, `\smallskip`
- Schrift direkt: `\scriptsize`, `\small`, `\large`, `\sffamily`, `\bfseries`, `\itshape`, `\textit`, `\textbf`, `\textsf` (Ausnahme: definierte Strukturmarken)
- Layout-Hacks: `\noindent` (außerhalb definierter Umgebungen), `\penalty`, `\columnbreak`
- Tabellen-Farben direkt: `\rowcolor`, `\columncolor` — stattdessen `\ZSFrowColor` etc.
- Mengen direkt: `\mathbb{R|C|N|Z|Q}` — stattdessen `\R`, `\C`, `\N`, `\Z`, `\Q`
- Operatoren direkt: `\operatorname{grad|div|rot}` — stattdessen `\grad`, `\divg`, `\rot`
- Summen/Limits direkt: `\sum\limits|\nolimits`, `\lim\limits` — stattdessen `\ZSFsumSide|Stack|Auto`, `\ZSFlimAuto`

`tests/check_chapter_rules.sh` setzt diese Verbote automatisch durch.

## Build & Pfad-Eigenheiten

Der Workspace liegt auf dem **Desktop** (nicht iCloud). LaTeX Workshop verwendet `%DOCFILE%.tex`. Build-Output: `build/`.

**Agent-Build-Pflicht:** Agent-Tool-Edits triggern LaTeX Workshop nicht. Nach jedem Edit immer manuell bauen:
```
make build
```

## GitHub Naming & Release System (für KI-Agenten)

### Namenskonventionen

- **Repository-Muster:** `eth-<fach>-zsf-<semester>-hliddal`
  - Beispiel: `eth-analysis2-zsf-fs2026-hliddal`
- **PDF-Muster im Root:** `<fach>_<semester>_hliddal.pdf`
  - Beispiel: `analysis2_fs2026_hliddal.pdf`
- **Semesterformat:** `fsYYYY` oder `hsYYYY`
- **Release-Tags:** Semantic Versioning als `vMAJOR.MINOR.PATCH`

### GitHub Actions System

- Workflow `CI Build` (push/PR auf `main`):
  - führt `make check` und `make build` aus
  - veröffentlicht die PDF als Artifact
- Workflow `Release PDF` (push auf Tag `v*`):
  - führt `make check`, `make build`, `make release-proof` aus
  - erstellt GitHub Release mit:
    - `analysis2_fs2026_hliddal.pdf`
    - `build/main.pdf.sha256`

### Agent-Regeln für GitHub-Änderungen

- Änderungen an Naming-Patterns **immer** konsistent in:
  - `Makefile`
  - `tests/check_root_clean.sh`
  - `tests/check_pdf_identity.sh`
  - `styles/75_pdf_identity.tex`
  - `README.md`
  - `.github/workflows/*.yml`
  - `.cursorrules` und dieser Datei
- Release-Flow nie auf manuelle Uploads zurückbauen.
- Bei Tag-Releases prüfen, dass PDF-Name und Hash-Datei mit den Mustern übereinstimmen.

## Authentizität / PDF-Identity

`styles/75_pdf_identity.tex` ist Single Source of Truth für:
- `\ZSFOwnerNameASCII` (PDF-Author)
- `\ZSFOwnerID`, `\ZSFReleaseID`, `\ZSFBuildID`
- Title, Subject, Keywords (über `pdfinfo`, `hypersetup`, optional XMP via `hyperxmp`)
- Sichtbarer Marker auf Seite 1 (`\ZSFVisibleMarkertrue`)

`tests/check_pdf_identity.sh` ist Teil von `make check` und prüft alle Metadaten gegen die erwarteten Werte. `make release-proof` schreibt SHA256 nach `build/main.pdf.sha256` — wird im Release-Workflow als Asset publiziert.

## Kapitelstruktur (Kap. 1–11)

| Kap. | Titel |
|---|---|
| 1 | Grundlagen |
| 2 | Komplexe Zahlen |
| 3 | Funktionen |
| 4 | Differentialrechnung |
| 5 | Funktionen mehrerer Variablen |
| 6 | Integrale |
| 7 | Integrale mehrerer Variablen |
| 8 | Vektoranalysis |
| 9 | Differentialgleichungen |
| 10 | Systeme von Differentialgleichungen |
| 11 | Anhang |

## siunitx-Konventionen

- Dezimaltrennzeichen: Komma (`output-decimal-marker = {,}`)
- Einheiten: `\si{...}`, Zahlenwert+Einheit: `\SI{...}{...}`
- Einheitenbrüche: `per-mode = symbol`
