# ZSF-Ideen (Scan-Design)

> Kompaktes Inventar: was diese ZSF für Scannbarkeit/Übersichtlichkeit tut.
> Neue Ideen unten eintragen. „Spezifisch" = Übernahme-Kandidaten fürs Template.

## Standard (alle ZSF)

- **Fett-Anker** (Ursprung: hier): `\ZSFkeyword` dicht als primäre Scan-Anker — auch direkt in Box-Inhalten (162×, bei fast null Fließtext).
- **Querverweise** (aus LinAlg): `\ZSFref{label}` → „(→ 6.6)" in Zielkapitel-Farbe. Label via `\SubsectionBar[sec:...]{...}`.

## Spezifisch (Template-Kandidaten)

- `fulltablebox` (40×): randlose Tabellen-Box, volle Breite für Formel-Tabellen.
- `\ZSFScriptRef` aktiv genutzt (24×): „(S.42)"-Verweise ins Skript für Notfall-Lookup.
- `formulabox`-Gruppen als Hauptmuster: `\formulasep`-Trennlinien + `\formulanote`.
- `longformula` (11×) für überbreite Formeln; `goalbox`/`compactgridbox` für Grids.
- Dicht gepackter Anhang (`11_anhang.tex`): breakable Boxen, verdichtetes Spacing, manuelle Breaks erlaubt — Schnell-Nachschlagteil.

## Ideen / TODO

- _(frei eintragen)_
