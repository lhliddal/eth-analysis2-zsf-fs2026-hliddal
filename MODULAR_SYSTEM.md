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

## Build-Pflicht

**Nach jeder Änderung muss `make build` laufen** — Layout-, Spacing-, Makro- oder Inhaltsänderungen werden grundsätzlich gebaut und das PDF überprüft, bevor weitergearbeitet wird. Direkte Aufrufe von `latexmk` oder `pdflatex` aus dem Repo-Root sind verboten; das PDF wird ausschliesslich über `make build` erzeugt.

Gründe:
- `make build` schreibt alle Aux-Artefakte (`*.aux`, `*.fls`, `*.log`, `*.fdb_latexmk`, `*.synctex.gz`, …) ins `build/`-Verzeichnis. Direkte `latexmk`-Aufrufe verschmutzen den Repo-Root und brechen `make check-root-clean`.
- `make build` injiziert `\ZSFBuildStamp` und `\ZSFGitCommit` per `LATEX_DEFS` in das Dokument. Ohne diese Defs sind Build-Stempel und Commit-Referenz im PDF leer / undefiniert.
- `make build` kopiert das Resultat deterministisch nach `analysis2_fs2026_hliddal.pdf` (plus SyncTeX). Manuelle Builds erzeugen `main.pdf` im Root, was nicht der Release-Artefakt ist.

Verbindliche Befehle:
- `make build` — einziger erlaubter Weg, das PDF zu erzeugen.
- `make check` — vor jedem Commit ausführen (lint + Strukturtests + PDF-Identität).
- `make clean` — vor Pull/Branch-Wechsel oder bei verschmutztem Root.

Falls direkte `latexmk`-Artefakte im Root auftauchen (`main.aux`, `main.log`, `main.pdf`, …), ist das ein Fehler — `make clean` ausführen und nur noch `make build` verwenden.

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

## Layout-Overrides (Escape Hatches)

Lokale Spacing-Hacks in Kapiteln (`\vspace`, `\columnbreak`, `\nopagebreak`, etc.) sind verboten. Aktuell existiert kein zentraler Override-Marker. Wenn ein Layout-Sonderfall wiederholt auftritt, wird ein neuer benannter Marker im `styles/`-Modul ergänzt — **niemals** ein roher `\vspace`/`\nopagebreak`/`\columnbreak` ins Kapitel.

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

### 4. Aussagen & Verfahren (`statementbox`, `procedure`)

Für textlastige Stellen gibt es zwei semantische Primitive, die `defbox` (Titelleiste, schwerer) ergänzen:

**`statementbox`** — dezente Box mit linkem Farbbalken in Kapitelfarbe. Für Sätze, Bemerkungen oder kompakte Definitionen, bei denen eine volle Titelleiste zu viel wäre. Optionaler Titel wird fett in Kapitelfarbe gesetzt.

```tex
\begin{statementbox}[Satz des Maximums]
Für eine beschränkte Fläche $A \subseteq D(f) \subseteq \R^2$ ...
\end{statementbox}

\begin{statementbox} % ohne Titel
Bemerkung: ...
\end{statementbox}
```

**`procedure`** — nummerierte Schritt-Liste in einer `statementbox`. Jeder Schritt besteht aus fettem Titel und einer Beschreibung in eigener Zeile. Verwendung statt einer langen `enumerate`, wenn jeder Schritt mehrere Wörter Erklärung braucht.

```tex
\begin{procedure}[Vorgehen: Extremalstellen finden]
  \ProcStep{Definitionsgebiet}{Skizze des Bereichs zeichnen.}
  \ProcStep{Inneres}{$f_x = 0$, $f_y = 0$ setzen und nach $x,y$ auflösen.}
  \ProcStep{Rand}{Parametrisieren, $f$ einsetzen, nach $t$ ableiten.}
  \ProcStep{Eckpunkte}{Separat untersuchen.}
  \ProcStep{Vergleich}{Funktionswerte aller Kandidaten berechnen und vergleichen.}
\end{procedure}
```

**`factlist`** — rahmenlose Liste für Stapel von Definitions-/Eigenschaftsfakten im Fließtext. Farbiger Bullet (Kapitelfarbe), fetter Lead-in, em-dash, Beschreibung. Für Stellen, wo mehrere kurze Fakten hintereinander als Prosa erschlagend wirken.

```tex
\begin{factlist}
  \ZSFFact{Grad}{Größter Exponent eines Polynoms.}
  \ZSFFact{Nullstellen}{Polynom vom Grad $n$ hat $n$ Nullstellen.}
  \ZSFFact{Vielfachheit}{Eine NS kann einfach, doppelt, …, $n$-fach vorkommen.}
\end{factlist}
```

**`propertylist`** — gruppierte Charakterisierungen / Eigenschaften unter optionalem Titel, eingefasst in eine `statementbox`. Wie `procedure`, aber unnummeriert (Eigenschaften sind nicht sequenziell). Items entweder als rohes `\item` oder mit `\ZSFFact{Lead}{Body}`.

```tex
\begin{propertylist}[Charakterisierungen konservativer Felder]
  \item Arbeit entlang aller geschlossenen Wege $\oint \vec v\,d\vec r=0$.
  \item Vektorfeld ist ein \ZSFkeyword{Potentialfeld}.
\end{propertylist}
```

**Faustregel**:
- Aussage / Satz / Definition (kompakt) → `statementbox`
- Definition mit Hervorhebung im Inhaltsfluss → weiterhin `defbox`
- Schritt-für-Schritt-Anleitung → `procedure`
- Gruppierte Eigenschaften / Charakterisierungen → `propertylist`
- Stapel kurzer Fakten im Fluss → `factlist`
- Wenn-dann-Vergleich (Bedingung → Konsequenz) → `fulltablebox` mit zwei Spalten
- Reine Aufzählung ohne Erklärungstext pro Item → normales `enumerate`/`itemize`

Tokens (`30_layout_spacing.tex`): `\ZSFstatementBarWidth`, `\ZSFstatementLeftPad`, `\ZSFprocStepGap`, `\ZSFprocItemSep`. Farben (`40_colors_structure.tex`): `\StatementBarColor`, `\StatementTitleColor` — beide an `\chaptercolor` gebunden, also automatisch pro Kapitel passend.

### 5. Text-Box-Bindungen (Spacing)
Um zu definieren, ob ein Textabschnitt zur Box darüber/darunter oder zu einer abgesetzten Formel gehört, existieren semantische Spacing-Makros. Sie berechnen Layout-Abstände deterministisch, blockieren Seitenumbruche und erfordern keine manuellen `\vspace`-Hacks.

- `\textVorBox{...}` & `\textNachBox{...}`: Ziehen erklärenden Text untrennbar (`1pt` Abstand) an das zugehörige UI-Element (Boxen, Custom-Umgebungen).
- `\textVorFormel{...}` & `\textNachFormel{...}`: Analog verwendbar *innerhalb* von Boxen für abgesetzte Formeln.

**Architektonische Besonderheiten (Best Practices):**
- **Decoupling von Margin & Padding:** Die Innenabstände (Padding) von Boxen nutzen globale Layout-Tokens (z.B. `\ZSFspaceS = 2pt`). Um Textblock-Ränder davon zu entkoppeln, wird für den vertikalen **Aussenabstand** weg von der Box das eigenständige Token `\ZSFspaceOuter` (z.B. `3pt`) genutzt.
- **Sicheres Unskip (`\ZSFRobustUnskip`):** `\textNachBox` verwendet das zentale Tool `\ZSFRobustUnskip`, um den intern generierten `after skip` einer vorangegangenen Box zu tilgen, ohne in unvorhergesehenes Verhalten zu rennen.

> **Rollout abgeschlossen:** Das Text-Box-Bindungssystem ist in allen Kapiteln (ausser Anhang) ausgerollt. Die Farben sind als semantische Token `TextVorBoxColor` (sehr dunkles Blau) und `TextNachBoxColor` (sehr dunkles Grün) in `40_colors_structure.tex` definiert.

### 6. Typografie & Vermeidung von Text-Lücken (Anti-Stretching)

Da das Dokument ein extrem schmales 4-Spalten-Layout nutzt, kommt es bei normalem Blocksatz schnell zu unschönen, riesigen Lücken zwischen Wörtern. Um dies zu verhindern, gelten folgende Regeln:

- **Telegrammstil:** Schreibe so kompakt und stichwortartig wie möglich. Vermeide lange, ausformulierte Schachtelsätze.
- **`babel` für Silbentrennung:** Das Paket `babel` mit Option `ngerman` ist zwingend erforderlich, damit LaTeX lange deutsche Fachbegriffe (z. B. *Gleichgewichtspunkt*) korrekt trennen kann.
- **Inline-Formeln schützen:** Wenn LaTeX eine Formel im Text (z. B. am `=`) umbricht, entstehen riesige Lücken. Schütze kurze, wichtige Inline-Formeln durch Klammerung: `${\dot{\vec x}=A\vec x}$` oder `\mbox{$\dot{\vec x}=A\vec x$}`.
- **Saubere Absatzenden vor Boxen:** Nutze **immer** `\textVorBox{...}` vor einer Box/Tabelle. Steht normaler Text direkt vor einer Box (ohne Leerzeile oder `\textVorBox`), interpretiert LaTeX dies nicht als Absatzende und dehnt die Zeile im Blocksatz über die volle Breite.

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

## Anhang-Sonderregelung (PFLICHT)

**Der Anhang (`chapters/11_anhang.tex`) wird ab jetzt NUR auf expliziten Befehl des Nutzers verändert.** Solange der Nutzer nicht ausdrücklich "Anhang", "11_anhang" oder eine konkrete Anhang-Stelle nennt, darf der Anhang weder inhaltlich noch im Header (`% ANHANG-SCOPE: SEPARATE REGELN`) angefasst werden — auch nicht "im Vorbeigehen" bei globalen Style-Refactorings.

**Bei globalen Änderungen** (Spacing-Skala, Box-Definitionen, Bar-Skips, Typografie etc.) gilt:

1. Globale Änderung im jeweiligen `styles/`-Modul vornehmen.
2. Sicherstellen, dass der Anhang-Header in `chapters/11_anhang.tex` die Änderung lokal kompensiert (Spacing-Reset, breakable-Override etc. sind dort bereits etabliert).
3. Anhang nach dem Build **visuell verifizieren**: Spaltenfüllung, Box-Umbrüche über Spalten/Seiten, enge Pack-Dichte müssen erhalten bleiben.
4. **Falls der Anhang regressiert:** zurück zur globalen Änderung, nicht den Anhang umschreiben. Lieber globale Änderung anpassen oder eine neue lokale Kompensation in den Anhang-Header (oben in `11_anhang.tex`) ergänzen — niemals die Anhang-Inhalte verändern.

### Verbindliche Anhang-Regeln (technisch):

1. **Boxen müssen über Spalten-/Seitengrenzen brechen können.** Im Rest des Dokuments sind Boxen unbreakable (Blöcke nicht zerschnitten). Im Anhang gilt das Gegenteil — `\tcbset{breakable}` am Kapitel-Anfang.
2. **Keine `\BreakIfNotEnoughSpace`-Reserven** im Anhang (kein Whitespace am Spaltenende, dichter Satz erwünscht). `\renewcommand{\BreakIfNotEnoughSpace}{}` am Kapitel-Anfang.
3. **Spacing-Skala lokal auf dichte Originalwerte zurücksetzen** (`ZSFspaceS=2pt`, `ZSFspaceM=4pt`, `ZSFspaceL=8pt`). Wenn die globalen Werte für die Theoriekapitel angepasst werden, ändert sich der Anhang **nicht** mit.
4. **Manuelle Page-/Column-Breaks sind im Anhang erlaubt** (z. B. `\clearpage` vor "Hliddal's Anhang"); im Rest des Dokuments sind sie verboten.
5. `\allowdisplaybreaks[4]` für freie Display-Math-Umbrüche.

Diese Regeln sind als Kommentar oben in `chapters/11_anhang.tex` dokumentiert. **Bei Refactorings am Style-System: Anhang nach jedem Build visuell verifizieren** — Spaltenfüllung, Box-Umbrüche und enge Pack-Dichte müssen erhalten bleiben.

## Hinweis für neue Chats (AI Agents)
Bei Rückfragen oder neuen Aufgaben immer zuerst diese Datei und die relevanten Module in `styles/` beachten. Die modulare Struktur hat höchste Priorität vor kurzfristigen Einzel-Hacks.

**Anhang-Sonderregelung (siehe oben) ist verbindlich:** `chapters/11_anhang.tex` wird ausschliesslich auf expliziten Befehl des Nutzers angefasst. Bei globalen Style-Änderungen NIE den Anhang "mit-refaktorieren" — stattdessen nach dem Build visuell verifizieren und ggf. nur den Header (Kompensations-Block) erweitern.
