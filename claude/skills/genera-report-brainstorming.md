---
name: genera-report-brainstorming
description: Genera un report delle idee di brainstorming salvate in agency/brainstorming/. Produce markdown e PDF, invia via email, svuota i file.
allowed-tools: bash, read, write, edit, glob
---

# Skill: genera-report-brainstorming

## Obiettivo
Raccogliere, organizzare e presentare tutte le idee di brainstorming in un documento strutturato.

## Comportamento
Autonomo — genera il report senza conferma. Chiede solo se non è chiaro il perimetro.

## Come viene invocata
- Con cliente/contesto specificato: genera report solo per quello (es. "genera report brainstorming trovapulizie")
- Senza specificare: genera report unico con tutte le idee di tutti i file, ben separato per sezioni

## Processo
1. Leggi i file in agency/brainstorming/ (tutti o solo quello specificato)
2. Se i file sono vuoti o non esistono: avvisa l'utente e termina
3. Organizza le idee per cliente/contesto, ordinate per data
4. Crea il documento markdown in research/report-brainstorming-YYYY-MM-DD.md con questa struttura:
   - Header con data e perimetro del report
   - Una sezione per ogni cliente/contesto con le sue idee
   - Ogni idea con autore, data, riferimento, testo
5. Genera il PDF usando pandoc o reportlab: research/report-brainstorming-YYYY-MM-DD.pdf
6. Invia il PDF via email a info@digital-on.com usando il MCP workspace-google
7. Svuota i file processati (mantieni solo l'header, rimuovi le idee)
8. Commit con messaggio: report-brainstorming: YYYY-MM-DD - [perimetro]

## Output atteso
- File markdown in research/
- PDF in research/ inviato via email
- File brainstorming svuotati

## Fuori scope
- Valutare o sviluppare le idee
- Eliminare i file (solo svuotarli)
