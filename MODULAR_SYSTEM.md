# Modulares ZSF-LaTeX-System (Pflichtdokumentation)

Diese Datei ist verbindlich für alle zukünftigen Änderungen. 

## Projektphasen

Das Projekt ist in zwei wesentliche Phasen unterteilt:

- **Phase 1 (Aktuell):** Abschnitt für Abschnitt wird die bestehende Word/PDF-Zusammenfassung inhaltlich 1:1 in LaTeX übertragen, jedoch vollständig im neuen, modularen ZSF-Design nachgebaut. Ziel ist die reine Übertragung und formale Strukturierung ohne inhaltliche Änderungen.
- **Phase 2 (Zukünftig):** Nach Abschluss der Übertragung werden die Inhalte ergänzt, fachlich überarbeitet und weiter verfeinert.

## Absolute Wichtigkeit

Das Layout- und Formel-System ist strikt modular aufgebaut. Diese Modularität ist nicht optional, sondern **Pflicht**. 

- Keine lokalen Spacing-Hacks (`\vspace`, `\hspace`, `\newpage`) in Kapiteldateien.
- Keine lokalen Stilabweichungen für Boxen, Titel oder Summen-Schreibweisen.
- Neue Inhalte müssen die zentralen Makros verwenden.
- Ziel: Die 50+ Kapitel sollen sich vollständig auf den physikalischen/mathematischen Inhalt fokussieren. Das Layouting wird im Hintergrund durch die globale Präambel dynamisch angewendet.

## Projektstruktur & "Single Source of Truth"

Die Konfiguration ist in Modulen organisiert, um einen unübersichtlichen Monolithen zu vermeiden:

- `main.tex`: Das Hauptdokument, lädt die Präambel und die Kapitel (`chapters/`).
- `preamble.tex`: Dient **nur** als Loader für die Module (`\input{styles/...}`).
- `styles/*.tex`: Hier befindet sich das echte "Fleisch" der Architektur:
  - `00_packages.tex`: Zentrale Pakete (`mathtools` statt `amsmath`, moderne `siunitx`-Optionen, kein `detect-all`!).
  - `10_math.tex`: Globale Math-Makros (Summen, Limes etc.).
  - `20_tables.tex`: Sichere Tabellenspalten-Deklarationen (`C`, `L`, `R`, sowie `Y`, `Z`, `Q`).
  - `30_layout_spacing.tex`: Globale Abstände und Dimensions.
  - `40_colors_structure.tex`: Farben, Geometrie und Kapitel-Paletten.
  - `50_typography_semantics.tex`: Globale Schrifteinstellungen und Semantik-Längen (Tabellen Rule-Colors etc.).
  - `60_boxes.tex`: Definition aller Boxen (`tcolorbox` Umgebungen).
  - `70_document_settings.tex`: Sonstige LaTeX-Meta-Settings.

**WICHTIG:** Wenn etwas nicht passt, ändere *nicht* die Kapiteldatei und *nicht* `preamble.tex`, sondern das entsprechende Modul im `styles/` Ordner.

## Verbindliche Nutzungsregeln (Best Practices)

### 1. Tabellen (`fulltablebox`, `valuegrid`)
Direkte Tabellen-Formatierungen (`\columncolor`, `\rowcolor`, harte `>{\hsize=...}`) in Kapiteln sind verboten.

**Valuegrid (Wertetabellen):** Ein einziges parametrisiertes Environment:
```tex
\begin{valuegrid}{5}[Optionaler Titel]  % 5 = Anzahl Datenspalten
    & col1 & col2 & col3 & col4 & col5 \\
    ...
\end{valuegrid}
```
Legacy-Aliase (`valuegridtwo` bis `valuegridseven`) sind noch verfügbar, aber `valuegrid{n}` ist bevorzugt.
- Stattdessen globale Wrappermakros verwenden (z.B. `\ZSFrowColor`).
- **Tabellen-Design-Entkopplung:** Tabellenlinien-Farben (`\arrayrulecolor`) werden über den `tabularx*`-Aufruf in `styles/60_boxes.tex` geladen, um Konflikte mit `tcolorbox` colframe zu vermeiden. Die Box-Umrandung ist hell (`black!20`), die Trennlinien innen sind kräftiger (`black!70`).
- **Tabellenspalten:** Niemals primitive Dateitypen (`c, l, r, p`) in LaTeX überschreiben! Nutze proportionale, parametrisierte Spalten:
  - `Y{#1}` (zentriert, proportional) anstelle von `c{#1}`
  - `Z{#1}` (linksbündig, proportional) anstelle von `l{#1}`
  - `Q{#1}` (rechtsbündig, proportional) anstelle von `r{#1}`

### 2. Mathe (Summen, Limits & Operatoren)
Summen- und Limeszeichen werden *nur* über `\ZSFsum...` und `\ZSFlim...` gesetzt. Mode (side/stack/auto) wird global über Makros (z. B. `\SetZSFsumMode{...}`) gesteuert.

**Zahlmengen:** `\R`, `\C`, `\N`, `\Z`, `\Q` statt `\mathbb{R}` etc.

**Vektoranalysis-Operatoren:** `\grad`, `\divg`, `\rot` statt `\operatorname{...}`.

**Gepaarte Begrenzer (mathtools):**
- `\abs{x}` → |x|, `\abs*{\frac{a}{b}}` → auto-skaliert
- `\norm{v}` → ‖v‖, `\norm*{\frac{a}{b}}` → auto-skaliert

**Differential:** `\dd` für aufrechtes d, z. B. `\int f(x)\dd x`.

### 3. Herleitungen (`Goal...`-Makros)
Herleitungen mit markiertem Ziel werden über `Goal...`-Makros aufgebaut.

**Neue kompakte Formelaussage:**
```tex
\begin{formulabox}
  $\displaystyle ...$
\end{formulabox}
```

**Zwei parallele Vergleichsformeln:**
```tex
\GoalPair
  {Links Titel}{Links Bedingung}{}{Links Ziel}
  {Rechts Titel}{Rechts Bedingung}{}{Rechts Ziel}
```

### 4. Text-Box-Bindungen (Spacing)
Um zu definieren, ob ein Textabschnitt zur Box darüber/darunter oder zu einer abgesetzten Formel gehört, existieren semantische Spacing-Makros. Sie berechnen Layout-Abstände deterministisch, blockieren Seitenumbruche und erfordern keine manuellen `\vspace`-Hacks.

- `\textVorBox{...}` & `\textNachBox{...}`: Ziehen erklärenden Text untrennbar (`1pt` Abstand) an das zugehörige UI-Element (Boxen, Custom-Umgebungen).
- `\textVorFormel{...}` & `\textNachFormel{...}`: Analog verwendbar *innerhalb* von Boxen für abgesetzte Formeln.

**Architektonische Besonderheiten (Best Practices):**
- **Decoupling von Margin & Padding:** Die Innenabstände (Padding) von Boxen nutzen globale Layout-Tokens (z.B. `\ZSFspaceS = 2pt`). Um Textblock-Ränder davon zu entkoppeln, wird für den vertikalen **Aussenabstand** weg von der Box das eigenständige Token `\ZSFspaceOuter` (z.B. `3pt`) genutzt.
- **Sicheres Unskip (`\ZSFRobustUnskip`):** `\textNachBox` verwendet das zentale Tool `\ZSFRobustUnskip`, um den intern generierten `after skip` einer vorangegangenen Box zu tilgen, ohne in unvorhergesehenes Verhalten zu rennen.

> **Rollout abgeschlossen:** Das Text-Box-Bindungssystem ist in allen Kapiteln (ausser Anhang) ausgerollt. Die Farben sind als semantische Token `TextVorBoxColor` (sehr dunkles Blau) und `TextNachBoxColor` (sehr dunkles Grün) in `40_colors_structure.tex` definiert.

## Kapitel-Farbpalette

Jedes Kapitel bekommt automatisch eine eigene Farbe (`\chaptercolor`) und eine abgestimmte helle Variante (`\chaptercolorlight`). Diese Farben werden dynamisch von allen abhängigen Makros genutzt: `\ChapterBar`, `\SubsectionBar`, `\BoxTitleColor`, `\FormulaboxBackColor`, Tabellen-Row-Colors etc. Dadurch sieht das gesamte Dokument pro Kapitel visuell konsistent aus, ohne dass in den Kapiteldateien je eine Farbe gesetzt werden muss.

### Mechanik

Definiert in `styles/40_colors_structure.tex`:

- **Palette:** 20 Farben als `ChapterColor0..19` plus passende `ChapterColor<k>Light`-Varianten.
  - `ChapterColor0` ist reserviert für den Frontchapter (`\StartFrontChapter`) und fest auf ETH-Rot (`A50D0D`) gesetzt.
  - `ChapterColor1..19` werden zyklisch den Kapiteln zugeordnet.
- **Zuweisung:** `\StartChapter{...}` ruft `\SetChapterPaletteByNumber` auf. Dieses Makro liest den `section`-Counter und setzt `\chaptercolor`/`\chaptercolorlight` auf den zugehörigen Slot. Bei >20 Kapiteln wird zyklisch gewrappt und eine `PackageWarning` ausgegeben.
- **Folge für Autor:innen:** In Kapiteln nie `\definecolor` oder `\color{...}` manuell setzen. Ausschliesslich `\StartChapter{Titel}` (bzw. `\StartChapterOnNewColumn{Titel}`) verwenden.

### Kontrast-Optimierung (Reihenfolge der Palette)

Die **Reihenfolge** der Slots `ChapterColor1..19` ist nicht beliebig, sondern so sortiert, dass aufeinanderfolgende Kapitel maximal unterscheidbar sind — insbesondere auch im Dreier-Fenster (`Kap n`, `Kap n+1`, `Kap n+2`).

- **Metrik:** CIEDE2000-Farbabstand (perzeptuell, nicht naives RGB).
- **Zielfunktion:** Maximierung des Minimums aller ΔE-Werte in den Pairs mit Abstand 1 und Abstand 2 über die aktuell genutzten Kapitelslots.
- **Verfahren:** Simulated Annealing über Permutationen von `ChapterColor1..19` (`ChapterColor0` fix).
- **Ergebnis (Kapitel 1–11):**
  - min Nachbar-ΔE: **48.6** (vorher 12.6)
  - min 3-Fenster-ΔE (Kap n zu Kap n+2): **49.3** (vorher 6.2)

Praktisch heißt das: Jedes Kapitel ist vom vorigen und vom vor-vorigen klar visuell unterscheidbar, auch für Personen mit Farbfehlsichtigkeit.

### Palette anpassen / erweitern

- **Reihenfolge umsortieren:** Darf man, aber nur über eine Neu-Optimierung. Dabei immer `ChapterColor0` unverändert lassen und beim Umsortieren die `...Light`-Variante jedes Slots **zusammen** mit dem Hauptton verschieben.
- **Slot-Anzahl erhöhen (>20 Kapitel):** `\ZSFchapterPaletteSize` erhöhen **und** entsprechend viele `ChapterColor<k>`/`ChapterColor<k>Light`-Definitionen ergänzen. Danach erneut auf Kontrast optimieren.
- **Einzelne Farbe verändern:** Beide zugehörigen Definitionen (`ChapterColor<k>` und `ChapterColor<k>Light`) gemeinsam anpassen. Helle Variante soll zum Hauptton passen (z. B. derselbe Farbton mit ~85 % Helligkeit).
- **Niemals** Kapitel-Farben in Kapiteldateien hart-coden. Kapitelfarben sind ausschliesslich in `40_colors_structure.tex` definiert und werden über `\chaptercolor`/`\chaptercolorlight` referenziert.

## Automatisierte Qualitätssicherung

Zur schnellen Qualitätssicherung (Linting) der Kapiteldateien gibt es einen Rule-Check. Führe ihn nach jedem neuen Kapitel aus:

```bash
./tests/check_chapter_rules.sh
```

Der Check durchsucht `chapters/*.tex` und meldet lokale Layout-Hacks (z. B. `\vspace`, `\hspace`, rohe `\sum\limits`/`\lim\limits` oder direkte Farben via `\rowcolor`/`\columncolor`), die gegen diese Dokumentation verstoßen.

## Build

Nach jedem Edit bitte manuell den Build triggern (bzw. den VS Code Task "LaTeX: Build main" nutzen):
```bash
latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -outdir=build -auxdir=build main.tex
```

## Hinweis für neue Chats (AI Agents)
Bei Rückfragen oder neuen Aufgaben immer zuerst diese Datei und die relevanten Module in `styles/` beachten. Die modulare Struktur hat höchste Priorität vor kurzfristigen Einzel-Hacks.
