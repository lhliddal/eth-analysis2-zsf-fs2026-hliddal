# Style Modules

Modulares Style-System, geladen von `preamble.tex` in dieser Reihenfolge:

| Modul | Inhalt |
| --- | --- |
| `00_packages.tex` | Immer aktive Basispakete und deren Setup (fontspec+Carlito, unicode-math+NewCMSansMath, mathtools, siunitx, xcolor[table], tabularx, tabularray, tcolorbox, ulem, hyperref, ...) |
| `10_math.tex` | Math-Macros: `\R \C \N \Z \Q`, `\dd`, `\norm \abs`, `\sgn \grad \divg \rot`, `\vect`, ZSFsumMode/ZSFlimMode |
| `11_math_advanced.tex` | **OPT-IN** (LinAlg/Analysis): Operatoren (`\Ker \rang \Spur \diag \spanop \eig \proj` ...), aufrechtes `\Im`/`\Re`, Klammern über Zellgrenzen (`\tikzmark`/`\drawbrace`/`\annote` + `\ZSFbraceRoom`) |
| `12_plots.tex` | **OPT-IN**: lädt `pgfplots` und setzt die zentrale Kompatibilitätsversion |
| `20_tables.tex` | Semantisches Table-System: Spaltentypen `L/C/R/Y/Z/Q/F`, `ZSFtable` mit den Reglern `header`/`zebra`/`font`/`rows`/`colsep`/`grid`, `\ZSFheaderRow`, `\ZSFhead`, Zellverbund `\ZSFspan` |
| `30_layout_spacing.tex` | Spacing-Skala XS/S/M/L, Block- und Balken-Folgeabstände (`\ZSFBoxBeforeSkip`, `\ZSFbarAfterGap`), Formel-Innenmasse (`\ZSFmathRowSep`/`\ZSFmathColSep`), Spaltenkopf (`\ZSFcolumnTopSkip`), samt den globalen Stellschrauben `\ZSFDensityFactor` (Abstände) und `\ZSFLeadingFactor` (Zeilenhöhe), `\ZSFInterlude`, horizontale Innenabstände (`\ZSFboxPadX`, `\ZSFboxPadXBar`, `\ZSFtableEdgePad`), Break-Schwellwerte, `\textVorBox`/`\textNachBox` (schalten in der `formulabox` selbst um), `\ZSFRobustUnskip`, `\ZSFgap` |
| `40_colors_structure.tex` | 18-Slot-Index-Palette, semantische Farben, aktive Kapitelfarben, Flag-System, `\StartChapter`/`\StartFrontChapter`, Ink-Vertrag (`\ZSFInk`/`\ZSFInkOwned`), Grössenfarben-Palette + `\ZSFDeclareQuantity` |
| `50_typography_semantics.tex` | Schriftmakros (`\ZSFfontChapter` etc., inkl. `\ZSFfontDiagramLabel`), die Auszeichnungs-Hooks der Bausteine (`\ZSFfontTableHead`, `\ZSFfontBlockLabel`, `\ZSFfontBoxBinding`, `\ZSFfontDangerTag`), die dezente Anmerkung `\ZSFBoxNote`, `\ZSFkeyword`, `\ZSFlabel`, `\ZSFconclusion` |
| `55_readability.tex` | Flattersatz + TeX-Penalties für schmale Spalten (`\ZSFReadableOn`, `ZSFReadable` env, `\ZSFbreak`/`\ZSFnobreak`) |
| `60_boxes.tex` | Box-Grundvertrag (`zsfbox` → `zsfboxcontract` → `zsfboxshape` → `zsftitlebox`, siehe unten), Instanz-Regler (`tone`/`weight`/`padx`/`pady`/`align`/`frame`/`atomic`/`split`/`splitalign`/`grid`), `chapterbar`/`subsectionbar`/`subsubsectionbar` (+ `\ZSFNewColumn`), `defbox`/`tablebox`/`figbox`/`warnbox`, `formulabox` + `\ZSFsep`/`\formulanote`, `runintext`, `\ZSFimage`/`\ZSFfig`/`\ZSFfigside`, `splitbox`, `ZSFlist` + `\ZSFItem`, `valuegrid`, Boxgruppe (`ZSFboxgroup` + `\ZSFgroupcols`), Blockpolsterung (`ZSFinset`), Goal-System (`\GoalCondition`/`\GoalTarget`/`\ZSFDerivationCase`), Pack-Modus (`\ZSFBoxesBreakableOn`/`\ZSFBreakReservesOff`), `\ZSFdanger` |
| `65_code_style.tex` | **OPT-IN** (Informatik): lädt `listings` samt tcolorbox-Library; Style `CodeExpert`, `codebox[Titel][part=…]` (whole/first/mid/last) |
| `66_index.tex` | **OPT-IN**: lädt `makeidx`; Stichwortverzeichnis mit `\ZSFkeyword`-Auto-Indexierung, `\ZSFindex`/`\ZSFindexsee`, `x.x`-/`x.x.x`-Locator und `zsfindex.ist` |
| `67_code_comments.tex` | **OPT-IN** (Informatik, nach 65): Smart Code-Kommentare `\CodeLine{code}[comment]`, `\InlineComment`/`\OverlineComment` |
| `75_pdf_identity.tex` | PDF-Metadata (`\ZSFOwnerNameASCII`, `\ZSFSubjectTitle`, `\ZSFReleaseID`, `\ZSFBuildID`), pdfinfo + hyperref + XMP |
| `70_document_settings.tex` | wird wegen der Release-ID nach `75_pdf_identity` geladen; Linkfarben, Math-Display-Skips, Listen, Tabellen-Zellabstand sowie Footer-Overlay samt gemessenem Satzspiegel-Freiraum (`\ZSFfooterClearance`) |

Kapitel bleiben inhaltsfokussiert; Layout/Styling läuft komplett über diese Module.

## Öffentliche Kapitel-API

Diese Liste ist die Quelle für den **Lebenszyklusstatus** der exportierten
Kapitelbefehle. Die Implementierungen stehen in
`60_boxes.tex`,
`40_colors_structure.tex`, `20_tables.tex`, `10_math.tex`
und `66_index.tex`.

### Stabil — für neue Kapitel vorgesehen

- Struktur: `\StartChapter`, `\StartFrontChapter`, `\SubsectionBar`,
  `\SubsubsectionBar`, `\ZSFNewColumn`.
- Inhaltsboxen: `defbox`, `tablebox`, `figbox`, `formulabox`, `warnbox`,
  `ZSFlist`, `goalbox`, `valuegrid`, `splitbox`, `runintext`.
- Boxgruppe (mehrere Boxen als ein Block): `ZSFboxgroup`, `\ZSFgroupcols`.
  Ihre drei Regler (cols, head, font) gelten fuer Kopfzeile UND Mitglieder
  gemeinsam — siehe `60_boxes.tex`.
- Block innerhalb einer Box: `ZSFinset`.
- Tabellen: `ZSFtable`, Spaltentypen
  `L`, `C`, `R`, `Y`, `Z`, `Q`, `F`, `\ZSFheaderRow`, `\ZSFhead`, `\ZSFspan`.
- Bilder: `\ZSFimage`, `\ZSFfig`, `\ZSFfigside`, `\ZSFfigcaption`.
- Semantik und Navigation: `\ZSFkeyword`, `\ZSFlabel`, `\ZSFdanger`,
  `\ZSFconclusion`, `\ZSFhl`, `\ZSFref`, `\ZSFsectionref`, `\ZSFTitleTag`,
  `\ZSFsep`, `\ZSFItem`, `\ZSFfontDiagramLabel`,
  `\ZSFfontDiagramLabelSmall`.
- Abstände in Kapiteln: `\ZSFgap`, `\ZSFSectionGap`.
- Punktuelle Umbruchsteuerung in Kapiteln: `\ZSFbreak`, `\ZSFnobreak`,
  `\ZSFallowbreak`.
- Dokumentkopf und Skriptverweis: `\ZSFTitleHeader`, `\ZSFScriptRef`.
- Globale Stellschrauben (in `preamble.tex`, nicht in Kapiteln):
  `\ZSFBodyFontSize` (Grundgrösse des Satzes, siehe `30_layout_spacing.tex`),
  `\ZSFContentScale` (Rollen-Faktor für den Bausteininhalt — Boxtext,
  Tabellenzelle, Formel; Balken und Titel bleiben, siehe `30_layout_spacing.tex`),
  `\ZSFFlowTextScale` (Rollen-Faktor für freien Fliesstext und Register,
  siehe `30_layout_spacing.tex`),
  `\ZSFDensityFactor`, `\ZSFLeadingFactor`,
  Bereichsfaktoren `\ZSFDensityBoxes`, `\ZSFDensityText`, `\ZSFDensityTables`,
  `\ZSFDensityStructure`, `\ZSFBreakReserveFactor`,
  `\ZSFBarGapFactor` (Abstand nach einem Titelbalken, siehe `30_layout_spacing.tex`),
  `\ZSFDiagramLabelScale` (beide Diagramm-Beschriftungsstufen gemeinsam,
  siehe `60_boxes.tex`),
  `\SetZSFsumMode`, `\SetZSFlimMode`, `\SetZSFzebraBG`,
  `\ZSFReadableBodyOn`, `\ZSFReadableBodyOff`, `\ZSFIndexShowPageNumber`
  (Index-Locator mit oder ohne Seitenzahl, siehe `66_index.tex`),
  `\ZSFkeywordStyle`, `\ZSFlabelStyle`, `\ZSFhlStyle` (Darstellung der drei Marker),
  `\ZSFDeclareQuantity` (Grössenfarben des Fachs vergeben),
  `\ZSFDeclareTone` (einen Ton anlegen, siehe `40_colors_structure.tex`),
  `\ZSFQuantityColorsOn` / `\ZSFQuantityColorsOff` (Hauptschalter dafür).
- Grössenfarben in Kapiteln: die per `\ZSFDeclareQuantity{<Name>}{<Slot>}`
  erzeugten `\ZSFq<Name>`.
- Pack-Modus für Anhang-artige Kapitel (am Kapitelanfang):
  `\ZSFBoxesBreakableOn`, `\ZSFBoxesBreakableOff`, `\ZSFBreakReservesOff`.
- Dichte für ein einzelnes Kapitel (am Kapitelanfang):
  `\ZSFChapterDensity`, `\ZSFChapterDensityReset` (siehe `30_layout_spacing.tex`).
- Formel-API: `\R`, `\C`, `\N`, `\Z`, `\Q`, `\dd`, `\vect`, `\abs`,
  `\norm`, `\ZSFsumAuto`, `\ZSFlimAuto`, `\ZSFbraceunder`,
  `\ZSFbraceover`, `\ZSFmhlA`, `\ZSFmhlB`, `\ZSFmhlC`, `\ZSFmhlD`,
  `\formulanote`,
  `\ZSFformulaline`,
  `\textVorBox`, `\textNachBox`.
- Goal-System: `\GoalCondition`, `\GoalStep`, `\GoalTarget`,
  `\ZSFDerivationCase`.
- Optionale Module: die in `11_math_advanced`, `12_plots`, `65_code_style`,
  `66_index` und `67_code_comments` dokumentierten Exporte.

#### Abweichungen dieses Forks vom Template

Drift ist Normalbetrieb (`../README.md`). Was diese ZSF zusätzlich hat oder
anders macht, steht hier zusammen — damit ein späterer Abgleich mit dem
Template weiss, wo er hinschauen muss.

- **Vier Analysis-Operatoren in `11_math_advanced`** — `\Grad` (Polynomgrad,
  gross geschrieben; `\grad` aus `10_math` ist der Gradient und eine andere
  Sache) sowie `\Arsinh`, `\Arcosh`, `\Artanh` für die Areafunktionen. Ohne sie
  stünde an jeder der 14 Fundstellen ein rohes `\operatorname`, das der Linter
  zu Recht meldet: Ein mehrfach gebrauchter Operator gehört einmal nach
  `styles/`. Kandidaten für den Rückfluss ins Template, sobald ein zweites Fach
  sie braucht (`../README.md` → Rückfluss).
- **Zwei Grössenfarben** (`preamble.tex`): `\ZSFqParameterA` / `\ZSFqParameterB`
  für die freien Parameter `a` und `b` der Integraltabelle im Anhang. Das ist
  keine Style-Abweichung, sondern die vorgesehene Verwendung von
  `\ZSFDeclareQuantity` — hier notiert, weil die Namen fachneutral sind und
  ihre Bedeutung sonst nirgends steht.

Sonst ist `styles/` identisch mit dem Template-Stand vom 12.08.2026.

### Entwicklungsrichtung

Diese Liste soll **kürzer** werden, nicht länger — und die Regler-Tabelle
weiter unten **länger**. Zwei Sätze, die unabhängig voneinander gelten:

1. **Bausteine werden nach Ermessen weiter zusammengelegt.** Ein Name muss
   eine eigene, nicht ableitbare Absicht tragen. Wo zwei Namen dieselbe
   Absicht bedienen, verschwindet einer — zuletzt `statementbox` (jetzt
   `weight=quiet`) und `procedure`/`factlist` (jetzt `ZSFlist[ordered]`).
2. **Variabilität wird ausgebaut, bedingungslos.** Jede in `styles/` fest
   verdrahtete Eigenschaft, die pro Stelle sinnvoll anders sein könnte, wird
   zu einem benannten Regler — auch ohne anstehende Zusammenlegung.

Wer hier etwas einträgt, prüft zuerst, ob ein Regler an einem vorhandenen
Baustein denselben Fall trägt (`60_boxes.tex`).

Zwei Testfragen entscheiden den Einzelfall:

- **Vereinigungstest:** Müsste eine Verbesserung an Baustein A anschliessend an
  Baustein B nachgezogen werden? Dann sind A und B ein Baustein mit einem Regler.
- **Reglertest:** Drückt der Regler eine Entscheidung aus, die der Autor pro
  Stelle tatsächlich trifft? Oder folgt sie zwingend aus der Inhaltsart? Nur im
  ersten Fall ist es ein Regler; im zweiten gehört sie in eine Vorbelegung.

### Bewusst getrennt gehaltene Bausteine

Diese vier haben die Prüfung bestanden und bleiben **absichtlich** eigene Namen.
Wer sie zusammenlegen will, argumentiert gegen die hier genannte Absicht — nicht
gegen ein Versehen.

`warnbox` ist dabei die einzige Box, die einen **Ton** als eigenen Namen führt.
Das ist eine benannte Ausnahme, kein Muster: Ein weiterer Ton bekommt keine
eigene Umgebung, solange er nicht beides mitbringt — eigene Semantik **und**
eine sinnvolle Vorbelegung.

### Kompatibilität — bereinigt

Die früher hier geführten Namen sind **entfernt**. Die Nutzungsanalyse über
Showcase und alle Fach-ZSF zeigte durchweg Redundanz oder Nullnutzung; jede
Funktion bleibt über einen stabilen Baustein erreichbar:

| entfernt | Ersatz |
| --- | --- |
| `valuegridtwo` … `valuegridseven`, `valuegridcustom` | `valuegrid[Titel]{n}` |
| `compactgridbox` | intern geworden — Zugriff über `valuegrid` |
| `fulltablebox`, `fulllessbox` | `tablebox` + `ZSFtable` |
| `longformula` | `\[ \begin{aligned} … \end{aligned} \]` in `formulabox` |
| `\GoalCard`, `\GoalPair` | `goalbox` + `\GoalCondition`/`\GoalStep`/`\GoalTarget` |
| `\PlaceholderGraphic` | `\ZSFfig` |
| `\ZSFmanualColumnBreak` | `\ZSFNewColumn` |
| `\ZSFtabColGap`, `\ZSFrowColor`, `\SetZSFtableRule*`, `\ZSF*TableRuleStyle` | zentrale `ZSFtable`-Stile |
| `ZSFtableFlat`, `ZSFtablePlain` | `ZSFtable[header=false]`, `ZSFtable[header=false, zebra=false]` |
| `codeboxfirst`, `codeboxmid`, `codeboxlast` | `codebox[Titel][part=first\|mid\|last]` |
| `\ZSFfigrow` | `\ZSFfig` mit einer Pfadliste |
| `\StartChapterOnNewColumn`, `\SubsectionBarOnNewColumn`, `\SubsubsectionBarOnNewColumn` | `\ZSFNewColumn` vor dem Strukturmakro |
| `\ZSFDerivationInlineCase` | `\ZSFDerivationCase*` |
| `\ZSFgapXS`, `\ZSFgapS`, `\ZSFgapM`, `\ZSFgapL` | `\ZSFgap[XS\|S\|M\|L]` |
| `\textVorFormel`, `\textNachFormel` | `\textVorBox`/`\textNachBox` (schalten in der `formulabox` selbst um) |
| `statementbox` | `defbox[Titel][weight=quiet]` |
| `procedure` + `\ProcStep` | `ZSFlist[Titel][ordered]` + `\ZSFItem` |
| `factlist` + `\ZSFFact` | `ZSFlist[Titel]` + `\ZSFItem` |
| `split ratio=…` | `split=…` (gilt jetzt auf jeder Box, nicht nur `splitbox`) |
| `\ZSFfig[<Anteil>]`, `\ZSFfigside[<Anteil>]` | `\ZSFfig[width=…, height=…]`, `\ZSFfigside[width=…]` |
| `\formulasep`, `\ZSFItemHeading` | `\ZSFsep` bzw. `\ZSFsep[Beschriftung]` |
| `pady=quiet` | `pady=tight` — beide Werte ergaben dasselbe Mass; die Skala hat drei unterscheidbare Stufen, also drei Namen. `quiet` war zudem ein Gewichtswort neben `weight=quiet` mit anderer Bedeutung |

Fach-Forks mit eigenen Style-Kopien sind davon nicht betroffen; sie behalten,
was sie mitgebracht haben (siehe `../README.md` → Verhältnis zu Forks).

### Intern

**Die Stabil-Liste oben ist abschliessend: Was dort nicht steht, ist intern** —
unabhängig vom Namen. Das `ZSF@`-Präfix markiert nur einen Teil der Internas;
viele heissen schlicht `ZSF…` und sehen dadurch öffentlich aus. Beispiele für
Internas ohne Präfix: die Farb-Tokens (`\BoxTitleColor`, `\SubsectionBarColor`,
`\ZSFtoneEmphasisBack*`, …), die Balken-Hooks
(`\ZSFConsumeAfterSubsectionBar`, `\ZSFMarkAfterSubsectionBar`), die
Spacing-Register (`\ZSFboxPadX`, `\ZSFbarPadY`, …), die Schrift- und
Auszeichnungs-Hooks (`\ZSFfontBoxTitle`, `\ZSFfontTableHead`,
`\ZSFfontBlockLabel`, `\ZSFfontBoxBinding`, `\ZSFfontDangerTag`,
`\ZSFBoxNote`) und die Eintritts-Sequenzen (`\ZSFBoxSetup`, `\ZSFBoxEnter`).

Die Auszeichnungs-Hooks sind die Antwort auf eine Prüffrage, die vorher mit
Nein zu beantworten war: *Box-Titel, Tabellenkopf und Listenmarke gemeinsam
entfetten — reicht eine Zeile je Rolle?* Vorher stand an jeder dieser Stellen
ein rohes `\bfseries` im jeweiligen Baustein, und wer eine Rolle umstellte,
erwischte die anderen nicht.

Ebenfalls intern: die tcolorbox-Basisstile (`zsfbox`, `zsfboxshape`,
`zsftitlebox`, `zsfbar`, die `preset/*`-Stile, …) und die Environments
`chapterbar`, `subsectionbar`, `subsubsectionbar`.

Kapitel dürfen sich auf nichts davon stützen. Style-Module dürfen und sollen es.

### Der Box-Grundvertrag (für Style-Autoren)

Jede Inhaltsbox steht auf **vier** Schichten in `60_boxes.tex` und setzt danach
nur noch, worin sie sich wirklich unterscheidet:

| Schicht | Verantwortung |
| --- | --- |
| `zsfbox` | Fluss — Skips (`\ZSFBoxBeforeSkip`/`\ZSFBoxAfterSkip`) und Eintritts-Hook (Balken-Bindung). Auch rahmenlose Boxen laufen hierüber. |
| `zsfboxcontract` | Vertrag — Breakability (`ZSF@breakability`), Ton, Justierung, Absatzabstand, Eintritts-Sequenz, Hook-Reset und das Zurücksetzen der verzögert aufgelösten Wahlen (`frame`, `ZSF@surface`, `ZSF@titlefill`, `splitalign`). Gilt auch für Boxen mit eigener Form. |
| `zsfboxshape` | Form — Rahmenstärke, Ecken, `boxsep`, Innenabstand. **Die eine Stelle für die Geometrie geschlossener Boxen.** |
| `zsftitlebox` | Titelbox — Form plus Titelbalken (`zsftitlebar`). Zwei Zeilen, mehr ist sie nicht. |

`defbox`, `tablebox`, `figbox`, `warnbox`, `formulabox`, `goalbox`, `valuegrid`
und `codebox` sind Ableitungen von `zsftitlebox`; `preset/quiet` (via
`weight=quiet`) und `preset/split` leiten von `zsfboxshape` ab und nehmen Rahmen
und Ecken zurück.

**Warum der Vertrag eine eigene Schicht ist.** Drei Stile bestimmen ihre Form
selbst und können deshalb nicht von `zsfboxshape` erben: `preset/quiet`,
`preset/split` und die offenen Kanten der `codebox`
(`zsf@codebox@split@base` in `65_code_style`). Sie zählten den halben Vertrag
jeweils erneut auf — und jede dieser Zeilen war irgendwann in einem der drei
vergessen worden, jedes Mal stumm (grauer Titelbalken statt Kapitelfarbe;
`align` und `bodyparskip` gemerkt, aber nie ausgeführt). Die Prüffrage
*„Titelbalken aller Boxen entfetten — reicht eine Zeile?"* war hier als
einziger Stelle im System mit Nein zu beantworten. Wer eine Box mit eigener
Form anlegt, erweitert deshalb `zsfboxcontract` und schreibt ihn nicht ab.

#### Die zwei Mechaniken, die die Reihenfolge-Zusage tragen

`60_boxes.tex` sagt zu, dass die Reihenfolge in der Optionsliste
bedeutungslos ist. Diese Zusage hält nicht von selbst — sie steht auf zwei
Mechaniken, die beide aus **einer** tcolorbox-Eigenschaft folgen: `colback`,
`colbacktitle` und `colframe` werden beim Setzen der Option **sofort** per
`\colorlet` aufgelöst und gehören damit dem letzten Schreiber. Wer eine dieser
Farben früh in der Liste festlegt, verliert sie an jede spätere Option, die
dieselbe Farbe schreibt.

**1 — Verzögerte Auflösung.** Ton, Rahmenstärke und Flächen-Rolle legen nur
Makros ab; gesetzt werden die Farben von zwei Resolvern als **letzte** Optionen
jeder Box (`ZSF@resolveframe`, `ZSF@resolvesurface`). Zu dem Zeitpunkt stehen
alle Wahlen fest, gleichgültig wer sie getroffen hat.

- **Rahmen:** der Regler wählt die *Stärke*, der Ton die *Farbe*
  (`\ZSFtoneFrameSoft/Strong/Hard`).
- **Der Rahmen ist zugleich die Aussenkante des Tabellengitters.** `ZSFtable`
  und `valuegrid` zeichnen ihre Linien nur *zwischen* Zeilen und Spalten —
  eine Tabellenlinie ist gerade und endete an den vier runden Ecken im
  Nichts, der Rahmen läuft entlang `\ZSFboxArc` mit. Damit die beiden
  zusammengehen, teilen sie das Mass (`boxrule` = `\arrayrulewidth` =
  `\ZSFboxRuleWidth`) und die Tinte (`\ZSFtoneFrameHard` = `\arrayrulecolor`
  bzw. tabularrays `fg`); `preset/table` und `preset/valuegrid` stehen
  deshalb auf `frame=hard`. Die tabularray-Seite erreicht das über
  `hline{2-Y}`/`vline{2-Y}` statt `hlines`/`vlines`, die tabularx-Seite über
  einen Scanner, der nur *zwischen* den Spalten ein `|` einsetzt
  (`20_tables`).
- **Fläche:** der Baustein wählt die *Rolle*, der Ton die *Farbe*. Vier Rollen
  über den internen Schlüssel `ZSF@surface`: `auto` (laut oder ruhig — das
  Gewicht entscheidet), `plain` (ungetönt; Basis für Zebra, Gitterlinien,
  Syntaxfarben), `quiet` (immer die ruhige Fläche) und `emphasis` (betont,
  Formelbox). `ZSF@titlefill` beantwortet dieselbe Frage für die Kopfzeile:
  `tone` gibt ihr den Titelbalken, `surface` setzt sie auf die Fläche der Box.
- Die Töne stehen in `40_colors_structure`, je einer als **eine**
  `\ZSFDeclareTone`-Deklaration. **Jede Rolle muss in jedem Ton besetzt sein**,
  sonst fällt eine Kombination auf die Farbe eines fremden Tons zurück — das
  ist keine Bitte mehr, sondern geprüft: Eine offene Rolle bricht mit einer
  Meldung ab, die den Ton und die Rolle nennt. Vorher stand die Zusage als
  Kommentar über 21 Einzeltokens, und der `tone`-Regler zählte sie in drei
  wortgleichen Blöcken erneut auf; ein vierter Ton kostete neun Tokens plus
  einen abgeschriebenen Block, und eine vergessene Rolle fiel niemandem auf.
- Ein Preset setzt `colback` deshalb **nie** direkt. Täte es das, verlöre es
  die Fläche an jede spätere Tonwahl des Aufrufers — und ein ausgeschriebenes
  `tone=chapter` sähe anders aus als ein weggelassenes, obwohl es dieselbe
  Wahl ist. Genau das war auf `tablebox`, `goalbox`, `valuegrid`, `splitbox`
  und `formulabox` der Fall.

`\ZSFtoneAccent` braucht diese Behandlung **nicht**: `borderline` liest seine
Farbe erst beim Zeichnen aus und funktioniert deshalb als reines Makro.

#### Abstand hat genau einen Schreiber — waagrecht wie senkrecht

Die Mechaniken oben halten *Farbe* an einer Stelle. Für *Abstand* gilt dasselbe,
und beide Achsen hatten hier je einen Defekt, den kein Blick auf eine einzelne
Box findet: Jede Zahl für sich war gültig, falsch war erst ihr Verhältnis.

**Senkrecht — der Abstand ist ein optischer, kein Leim.** Zwischen zwei Blöcken
im vertikalen Satz liegt nicht nur die gesetzte Glue, sondern zusätzlich die
Zeilenschaltung; der sichtbare Abstand ist `Wert + (\baselineskip − Höhe der
folgenden Zeile)`. Solange alle Zeilen gleich hoch sind, fällt das nicht auf —
sobald die Höhen wechseln (Pillen einer Zielkette, Displaymathe, ein Bild),
wird der Rhythmus zum Nebenprodukt der Tinte. `\ZSFInterlude`
(`30_layout_spacing`) nimmt die Zeilenschaltung deshalb mit
`\nointerlineskip` heraus; danach ist der Abstand von Unterkante zu Oberkante
genau der gesetzte, unabhängig vom Inhalt. Wer einen neuen vertikalen Einschub
baut, geht durch dieses Makro und nicht durch `\vspace`.

Dieselbe Frage eine Ebene tiefer, in der Tabellenzelle. Ein Streben ist ein
**Mindestmass**: `\arraystretch` und `\extrarowheight` skalieren es, und Inhalt,
der höher ist als es — ein `\dfrac`, ein `\includegraphics` —, bleibt davon
unberührt. Die Zeilentiefe ist zudem `max(Strebe, Zellinhalt)`, und die
`m`-Ausrichtung von `array.sty` senkt einen hohen Block genau so weit, dass die
Zelle diese Tiefe bestimmt: Die verbleibende Luft landet vollständig **oben**,
unten steht der Inhalt bündig. Deshalb meldet `\ar@align@mcell` (überschrieben
in `20_tables`) einen hohen Zellinhalt um `\ZSFtableCellPadY` höher und tiefer,
ohne ihn zu verschieben. Kurzer Text läuft weiter über die
Grundlinien-Ausrichtung und ist unberührt.

Das ist zugleich der Grund, warum es **kein** eigenes Bild-Register für den
*Abstand* gibt: „Ein Bild hält Abstand zur Zeilenkante" und „ein Bruch hält
Abstand zur Zeilenkante" sind derselbe Satz (Vereinigungstest). Der Regler
`rows` entscheidet ihn.

#### Die Bild-HÖHE gehört dem Container

Anders als der Abstand ist die maximale Bildhöhe **nicht** eine Frage, sondern
zwei — und welche gilt, weiss nur der Baustein, in dem das Bild steht:

| Container | Budget |
|---|---|
| `ZSFtable`, `valuegrid` | `\ZSFimageMaxHeight` (1.1 cm) — muss in eine Zeile passen |
| `figbox`, `splitbox` | `\ZSFfigMaxHeight` (2.6 cm) — füllt einen Block |

Technisch läuft das über die Indirektion `\ZSF@imgBudget`, die der Default von
`\ZSFimage` liest und die jeder dieser Bausteine auf sein Mass umbindet. Ein
fester Default wäre an einem der beiden Orte **still** falsch: Ein `\ZSFimage`
in einer `figbox` wurde vorher auf Zellenhöhe gestaucht — ohne Fehler, ohne
Warnung, ohne Linter-Treffer. Ein zu klein gesetztes Bild sieht nicht nach
einem Defekt aus, sondern nach einer Absicht.

Die Umbindung ist auf die jeweilige Umgebung begrenzt. Nach ihrem Ende gilt
wieder das Budget des umgebenden Containers; kein Bild-Baustein darf seine
Höhenentscheidung in einen folgenden Block mitnehmen.

Aufgefallen ist das erst im ersten grossen Fach-Fork, und der Grund ist
lehrreich: Die Living Showcase führte `\ZSFimage` nur in einer `tablebox` vor —
in *seinem* Kontext. Die Kreuzprobe (Baustein A im Container B) fehlte. Seither
steht sie in `ch05_palette_slot.tex`.

> **Vorsicht bei `@` ausserhalb `\makeatletter`:** `figbox` und `splitbox` sind
> ausserhalb der `\makeatletter`-Klammer definiert. `\begin{ZSF@box}` geht dort,
> weil ein Umgebungsname reiner Text ist — `\ZSF@imgBudget` geht **nicht** und
> zerfällt still in `\ZSF` und `@imgBudget`. Beide Definitionen sind deshalb
> eigens geklammert.

**Der Abstand VOR einem Block** gehört `\ZSFBoxBeforeSkip`, gesetzt in
`\ZSF@blockBefore` (`60_boxes`) — und zwar für jede Box *und* für `runintext`.
Er war lange herrenlos: `zsfbox` setzte `before skip` und danach `before`, und
in tcolorbox ist `before skip` kein eigener Schlüssel, sondern ein Stil, der
`before` schreibt (`before skip/.style={before={…}}`). Der spätere gewann, der
Wert war wirkungslos, und der Abstand vor jeder Box kam allein aus `\parskip`.
Mit ihm lagen zwei weitere Zusagen brach: die Kollaps-Mechanik nach einem
Balken rechnete einen Wert aus, den niemand las, und `ZSFboxgroup` schloss
seine Zwischenräume nicht. Wer hier etwas ändert, prüft es am Satz — ein
Register, das keiner liest, sieht im Code korrekt aus.

**Der Abstand NACH einem Titelbalken** gehört `\ZSFbarAfterGap`. Der Balken
setzt ihn nicht vorab, sondern markiert mit `\ifzsfTitleBarPending`, dass der
erste sichtbare Follower ihn noch verbrauchen muss. Box, Fliesstext und ein
direkt folgender Balken laufen dadurch alle über denselben
`\ZSFTitleBarGapConsume`; unsichtbare Index-Writes verbrauchen den Zustand
nicht. Direkt vor dem positiven Abstand erneuert der Verbraucher zugleich das
Umbruchverbot, damit ein Write die Bindung Titel → erster Block nicht auftrennt.

Während der Zustand offen ist, steht `\parskip` vorübergehend auf null. Beim
ersten freien Absatz verbraucht ihn der LaTeX-Hook `para/before`, stellt den
Dokumentwert noch vor dem Inhalt wieder her und setzt genau
`\ZSFbarAfterGap`. Boxen und der nächste Balken rufen denselben Verbraucher
direkt. So schreibt an dieser Grenze weder ein automatischer Absatzabstand noch
ein zweites tcolorbox-`after skip` mit; insbesondere braucht es keine negative
Gegenverschiebung. Der Hook koexistiert mit Paket-Hooks und ersetzt nicht mehr
das globale `\everypar`-Register.

Der frühere Aufbau hatte zwei Register (`\ZSFchapterBarAfterSkip`,
`\ZSFsubsectionAfterGap`) plus impliziten `\parskip` und eine eigene
Kapitel→Abschnitt-Korrektur. Dadurch entstanden für denselben sichtbaren Ort
drei verschiedene Abstände. `\ZSFPostChapterSpacing`, der zweite
Kapitel-Merker und die negative Kollaps-Korrektur sind deshalb entfallen.

**Die Inventur ist vollständig gemacht worden**, nicht angenommen: Alle
TeX- und LaTeX-Abstandsparameter wurden im laufenden Dokument ausgelesen und
gegen die Registerliste gehalten. Auf Klassenvorgaben standen zuletzt nur
noch `\jot` und `\arraycolsep` — der Zeilen- und Spaltenabstand *innerhalb*
einer Formel, also ausgerechnet in den zwei Konstrukten, in die
`30_layout_spacing.tex` Autoren schickt. Beide hängen jetzt als `\ZSFmathRowSep`
und `\ZSFmathColSep` an der Skala und werden in `\ZSFApplyDisplaySkips`
gesetzt. Ohne Besitzer bleiben nur Parameter, die dieses System nicht
benutzt (Floats, `\fbox`, `\smallskip`-Familie) oder die bewusst draussen
sind (`\columnsep`, siehe `30_layout_spacing`).

#### Der Ink-Vertrag — wem gehört die Farbe an dieser Stelle?

Die beiden Mechaniken oben sorgen dafür, dass eine Box ihre Farben aus Rolle
und Ton bekommt. Der Ink-Vertrag beantwortet die Gegenfrage: Was passiert mit
**Inline**-Farbe, die auf einer bereits gefärbten Fläche landet?

Farbtragende Inline-Makros (`\ZSFkeyword`, `\ZSFref`, `\ZSFsectionref`,
`\ZSFmhl*`, die Grössenfarben) setzen `\color` nicht selbst, sondern gehen
durch **`\ZSFInk{<Farbe>}{<Inhalt>}`** (`40_colors_structure`). Ist die Fläche
ink-besitzend, setzt `\ZSFInk` die Farbe der Fläche erneut — der Marker trägt
damit genau deren Kontrastfarbe und bleibt lesbar.

**Erneut setzen, nicht bloss weglassen.** Der Unterschied ist kein Detail:
Nichts zu setzen erbt die Flächenfarbe nur, solange zwischen Fläche und Marker
niemand sonst färbt. `\hyperref` tut aber genau das — es legt in jedem Link
seine `linkcolor` an. Ein `\ZSFref` im Titel eines Kapitelbalkens stand deshalb
**blau auf gesättigtem Grund**, also genau die Unlesbarkeit, gegen die der
Vertrag geschrieben wurde, und ohne Fehler oder Warnung. `\ZSFInkOwned` hält
den Farbwert (`\current@color`) fest, weil die Flächen ihre Kontrastfarbe über
verschiedene Wege setzen (`\textcolor`, `\color`, tcolorbox' `coltitle`) und
nur der Wert an allen dreien derselbe ist — deshalb braucht keine Aufrufstelle
ein Argument.

Das Kriterium ist bewusst **eines** und aus dem Code ablesbar:

> Jede Fläche, die ihre eigene Kontrast-Textfarbe setzt, besitzt die Farbe.

Deshalb steht `\ZSFInkOwned` immer **direkt neben** dem `\color`/`\textcolor`,
das den Kontrast setzt — nicht an einer entfernten Stelle, wo es beim nächsten
Eingriff vergessen wird. Heute sind das: `\ChapterBar`, `\ZSFTitleHeader`,
Abschnitts- und Unterabschnittsbalken, `\ZSFhead` (Tabellenkopfzelle), der
Titelbalken jeder Box (`zsftitlebar`) und die Titelzeile der leisen Fassung
(`\ZSF@emitQuietTitle`).

Die leise Titelzeile gehört ausdrücklich dazu, obwohl ihre Fläche nicht
gesättigt ist: Ein Titel darf sich nicht je nach `weight` anders verhalten.
Ohne sie behielte ein Marker im Titel seine Farbe in der leisen Fassung und
verlöre sie in der lauten — ein Regler, der die Bedeutung eines anderen
Bausteins verschiebt.

Belegt wird der Vertrag als **Zustandsabfrage**, nicht als Bildvergleich: eine
Probe, die `OWNED`/`FREE` als Text ausgibt, unterscheidet die beiden Zustände
eindeutig; ein Bild sagt nur, dass etwas anders aussieht.

Wer eine neue gefärbte Fläche anlegt, setzt `\ZSFInkOwned` mit. Wer eine neue
farbtragende Inline-Auszeichnung anlegt, führt sie über `\ZSFInk`.

#### Warum `\ZSFspan` als einziger Baustein Pflichtargumente hat

`\ZSFspan{<L|C|R>}{<n>}{<Inhalt>}` weicht von der Schlüsselkonvention ab. Der
Grund ist gemessen, nicht ästhetisch, und steht hier, damit ihn niemand
„geradezieht":

- TeX setzt am Zellenanfang die Spaltenvorlage ein, sofern das erste
  **nicht-expandierbare** Token nicht `\omit` ist — das `\multicolumn` als
  erstes ausführt. Jede Form mit optionalem Argument (xparse `O{…}` ebenso wie
  `\newcommand[3][…]`) führt vorher eine Zuweisung aus; die Vorlage steht dann
  bereits und der Verbund bricht mit „Misplaced \omit". Beide Formen wurden
  gegengeprüft.
- Der Spaltenbuchstabe muss **literal** bei `\multicolumn` ankommen: Der
  Preamble-Parser von `array` vergleicht Tokens und expandiert nicht, ein
  Makro dort meldet „Illegal pream-token". Deshalb steht die Auswahl als
  `\if`-Kette **vor** `\multicolumn` und übergibt ein echtes `l`/`c`/`r`.
- Der Fehlerfall für einen unbekannten Buchstaben läuft in den Zellinhalt —
  dort ist `\omit` schon gesetzt und eine Meldung unschädlich.

Dieselbe Nicht-Expansion ist der Grund, warum `ZSFtable` ihre
Spaltenaufteilung per `\edef` auflöst, bevor sie `\tabularx` ruft: Nur so kann
ein Gruppenmitglied `\ZSFgroupcols` als colspec verwenden, statt die
Aufteilung in jedem Block zu wiederholen.

**2 — Vor-Lauf für Regler, die einen Basisstil wählen.** `weight` und `part`
wählen keinen *Wert*, sondern eine *Basis* — und eine Basis bringt
Vorbelegungen mit (`padx=bar`, `frame=none`, Skips). Stünden sie wie die
übrigen Regler in der Aufrufer-Liste, liefen ihre Vorbelegungen **nach** den
Wahlen des Aufrufers und überschrieben sie: `[tone=warn, weight=quiet]` verlor
den Ton, `[padx=bar, part=first]` den Innenabstand — stumm, weil jeder Wert
für sich gültig ist. Beide werden deshalb per `pgfkeys`-Vorlauf aus dem Aufruf
gelesen, und die fertige Basis (`ZSF@weightBase` in `60_boxes`,
`ZSF@partBase` in `65_code_style`) steht **vor** den Aufrufer-Optionen. Der
öffentliche Schlüssel bleibt daneben als No-op bestehen, damit tcolorbox ihn
nicht als unbekannt meldet.

#### Zwei Sequenzen beim Eintritt in eine Box

`\ZSFBoxSetup` und `\ZSFBoxEnter` sehen aus wie eine Verdopplung, sind aber
zwei verschiedene Häufigkeiten:

| Makro | läuft | Inhalt |
| --- | --- | --- |
| `\ZSFBoxSetup` | in **jedem** Textblock der Box — auch in der unteren Hälfte des `split`-Reglers | Absatzabstand, Justierung, Kontext-Flag |
| `\ZSFBoxEnter` | **einmal** beim Eintritt in die Box | `\ZSFBoxSetup` + Titelzeile der leisen Fassung |

Wer eine neue Box anlegt, erweitert eine dieser Schichten und zählt ihre
Schlüssel **nicht** erneut auf (Begründung: `../preamble.tex` → „Beim
Editieren von `styles/*.tex`"). Prüffrage: *Eckenradius aller Boxen ändern —
reicht eine Zeile?*

Alle Titelboxen laufen über die Fabrik `ZSF@box`. Sie schaltet bei leerem Titel
auf `notitle` um — deshalb braucht keine Box mehr eine titellose Zweitfassung.

#### Box-Optionen (zweites optionales Argument)

Diese Schlüssel sind Teil der stabilen API, aber keine Makros — sie stehen
deshalb nicht in der Token-Liste oben:

| Schlüssel | Boxen | Werte (Default zuerst) |
| --- | --- | --- |
| `tone` | alle Boxen | `chapter`, `neutral`, `warn` |
| `weight` | alle Boxen mit Titel | `loud`, `quiet` |
| `padx` | alle Boxen | `normal`, `bar`, `none` |
| `pady` | alle Boxen | `normal`, `tight`, `none` |
| `align` | alle Boxen | `left`, `center` |
| `frame` | alle Boxen | `soft`, `strong`, `hard`, `none` |
| `atomic` | alle Boxen | Flag |
| `split` | alle Boxen | Anteil der linken Hälfte |
| `splitalign` | alle Boxen | `top`, `center`, `bottom` |
| `ordered` | `ZSFlist` | Flag |
| `grid` | `ZSFtable`, `valuegrid` | `both`, `horizontal`, `none` |
| `bodyparskip` | alle Boxen | `box` (eigener Absatzabstand), `inherit` (Dokumentwert) |
| `part` | `codebox` | `whole`, `first`, `mid`, `last` |
| `header` | `ZSFtable` | `true`, `false` |
| `zebra` | `ZSFtable` | `true`, `false` |
| `font` | alle Boxen, `ZSFtable` | `normal`, `dense` |
| `rows` | `ZSFtable`, `valuegrid` | `normal`, `roomy`, `tight` |
| `colsep` | `ZSFtable`, `valuegrid` | `normal`, `tight` |

Darüber hinaus sind tcolorbox' eigene Schlüssel erlaubt (`breakable`, …) — das
zweite optionale Argument geht an tcolorbox weiter.

Drei Boxen erzwingen ihr Umbruchverhalten mit dem Regler `atomic` **nach**
`zsftitlebox` (`figbox`, `goalbox`, `valuegrid`), damit der Pack-Modus
(`\ZSFBoxesBreakableOn`) sie nicht aufbricht.

Der Pack-Modus selbst ersetzt genau den Zwischenstil `ZSF@breakability` im
gemeinsamen `zsfboxcontract`. Er hängt keine weiteren Optionen an Presets an;
damit gibt es zu jedem Zeitpunkt nur einen aktuellen Wert, und auch
`preset/quiet` sowie `preset/split` folgen derselben Wahl. `atomic` bleibt der
bewusste spätere Gegenentscheid. Für den ersten Teil einer Box verwendet der
Pack-Modus in `multicols*` eine Sicherheitsreserve von einer `\baselineskip`;
sonst kann die Resthöhen-Schätzung von `tcolorbox` wenige Punkte zu gross sein
und die intern bereits geteilte Box wird vom Spalten-Output trotzdem komplett
in die nächste Spalte verschoben. Folgeteile nutzen wieder die volle natürliche
Spaltenhöhe (`break at=-\baselineskip/0pt`).

## Readability-System (55_readability.tex)

Fliesstext (`runintext`, `defbox`, `warnbox`) ist im **Flattersatz**, damit
LaTeX in den schmalen 4-Spalten-Zeilen lieber frueh umbricht als zu trennen
oder Leerraum aufzublaehen.

Globaler Schalter:
```latex
\ZSFReadableBodyOff  % zurück zu Blocksatz
\ZSFReadableBodyOn   % wieder an (Standard)
```

Lokal:
```latex
\begin{ZSFReadable}
  ... Text im Flattersatz ...
\end{ZSFReadable}
```

Punktuelle Steuerung:
- `\ZSFbreak` — weicher bevorzugter Umbruch
- `\ZSFnobreak` — gebundenes Leerzeichen (`5\ZSFnobreak kg`)
- `\ZSFallowbreak` — erlaubt Umbruch an sonst fester Stelle

### Der Lua-Filter: erkennen und gestalten sind getrennt

`styles/zsf_filter.lua` läuft über `chapters/` und `main.tex` und bindet drei
Stellen automatisch: kurze Inline-Formeln, die Zahl-Einheit-Fuge und den
Doppelpunkt einer Variablenbeschreibung. **Der Filter erkennt nur die Stelle;
wie stark dort gebunden wird, steht in `55_readability.tex`** — sonst stünde
eine typografische Entscheidung in einer `.lua`-Datei und damit ausserhalb von
`styles/` (`60_boxes.tex`).

| Marke | Bindung | wofür |
|---|---|---|
| `\ZSFunitbind` | hart (`\penalty10000`) | Zahl und Einheit sind ein Wort — `10 m/s` |
| `\ZSFcolonbind` | weich (`\ZSFcolonBindPenalty`, 9000) | nach dem Doppelpunkt einer Variablenbeschreibung |

Der Unterschied ist nicht kosmetisch. Eine **harte** Bindung nach dem
Doppelpunkt erzwingt in den ~50 mm schmalen Spalten eine Overfull-Zeile, sobald
dahinter eine lange Formel steht — die Zeile läuft sichtbar in den
Spaltensteg. Die hohe Penalty ergibt dasselbe Satzbild, lässt den Bruch aber
zu, wenn die Alternative schlechter ist.

Dazu die **Längengrenze** im Filter (`COLON_MAX_IDENT`, 4 Zeichen): Gebunden
wird nur nach einem kurzen Bezeichner (`m:`, `$r$:`), nicht nach jedem
Satzdoppelpunkt. Regel 4 des Filters hatte diese Grenze von Anfang an, Regel 5
nicht — und ohne sie klebte die Regel ganze Sätze an ihre Folgeformel.
