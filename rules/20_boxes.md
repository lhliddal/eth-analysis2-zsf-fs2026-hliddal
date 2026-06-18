---
description: "Box-Auswahl (Decision Tree), Struktur-Makros (StartChapter, SubsectionBar), Inline-Marker (ZSFkeyword, ZSFdanger, ZSFconclusion), Kapitel-Skeleton"
globs: ["chapters/**/*.tex", "styles/60_boxes.tex", "styles/40_colors_structure.tex", "styles/50_typography_semantics.tex"]
alwaysApply: false
decisionOwner: ai
decisionStatus: final
lastUpdatedBy: loris
lastUpdatedAt: 2026-06-10
---

Für inhaltliche Darstellungen müssen die vordefinierten Umgebungen genutzt werden. Das Layout- und Formel-System ist strikt modular.

## Box-Auswahl (Decision Tree)

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

## Nutzungsregeln

- **defbox vs. statementbox:** Im Zweifel `defbox` für gewichtige Sätze und Definitionen (Titel **und** beliebiger Inhalt). `statementbox` (dezenter linker Farbbalken) für kleinere Aussagen oder kompakte Sätze.
- **Formel-Grouping:** Mehrere verwandte Formeln gehen in **eine** `formulabox` mit `\formulasep` (graue Trennlinie) und optionalen Beschreibungen via `\formulanote`. Für gleichwertige Fälle: `\ZSFItemHeading{Fall A}`.
- **Bilder:** Ausschließlich über `figbox` + `\ZSFfig{path}`. Niemals nackte `\includegraphics`-Befehle in Kapiteln.

## Struktur-Makros

| Makro | Verwendung |
|---|---|
| `\StartChapter[label]{Titel}` | Hauptkapitel mit auto-Nummerierung + Farbpalette (Index) |
| `\StartFrontChapter{Titel}` | Unnummeriertes Kapitel (Front-Matter, ETH-Rot) |
| `\SubsectionBar[label]{Titel}` | Nummerierter Abschnitt mit farbigem Balken |
| `\SubsectionBar*{Titel}` | Unnummerierter Abschnitt |

Niemals `\section` / `\subsection` / `\chapter` direkt verwenden.

## Inline-Marker

- `\ZSFkeyword{Fachbegriff}` — zentrale Fachbegriffe als **primäre Scan-Anker**, im Fließtext und direkt in Box-Inhalten. Sparsam pro Block (1–3 pro `runintext`, ca. 8–14 pro Kapitel). Nicht in Formeln, Notizen oder Überschriften.
- `\ZSFdanger{Achtung-Text}` — Inline-Pill für Stolperfallen / kritische Ausnahmen.
- `\ZSFconclusion{Folgerung}` — leitet eine Folgerung ein (gerendert als $\Rightarrow$).
- `\ZSFref{label}` — Querverweis, gerendert als `(→ 6.6)` in der Farbe des Zielkapitels. **Neue** Querverweise nur, wenn ein Schritt ein Verfahren aus einem **anderen** Kapitel delegiert — nicht für elementare Operationen. Hartcodierte Abschnittsnummern (z. B. `[9.8]`) sind verboten — jeder Nummern-Verweis läuft über `\ZSFref`, auch innerhalb desselben Kapitels. Ziel-Label via `\SubsectionBar[sec:...]{Titel}`.
- **Formatierungs-Verbot:** Niemals `\textbf{}` / `\textit{}` zur semantischen Hervorhebung — immer die obigen Marker.

## Semantisches Formel-Highlighting

Experimentelles System, um Zusammenhänge über mehrere Formeln oder Verfahrensschritte hinweg sichtbar zu machen. Es ist bewusst klein gehalten und kann nach praktischer Nutzung noch verbessert werden.

| Makro | Rolle |
|---|---|
| `\ZSFmhlA{...}` | Quelle / gegeben / erster Strang |
| `\ZSFmhlB{...}` | Gegenstück / abgeleitet / zweiter Strang |
| `\ZSFmhlD{...}` | dritter paralleler Strang, nur wenn wirklich nötig |
| `\ZSFmhlC{...}` | Ziel / Endform / Resultat |

Nur einsetzen, wenn die farbliche Verbindung mathematisch eindeutig stimmt. `\ZSFmhlD` ist kein Standardmarker; nur verwenden, wenn drei gleichwertige Stränge gleichzeitig verfolgt werden müssen und `\ZSFmhlC` weiterhin als Ziel/Resultat gebraucht wird. Nicht zur allgemeinen Betonung oder Dekoration verwenden; bei Zweifel lieber keine Farbe setzen.

## Farb-Palette

- 20 Slots (`ChapterColor0..19` + `*Light`-Varianten), perzeptuell sortiert (CIEDE2000).
- Slot 0 reserviert für `\StartFrontChapter` (ETH-Rot).
- Kapitelfarben niemals hardcoden — nur `\chaptercolor` / `\chaptercolorlight`.

## Kapitel-Skeleton

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
