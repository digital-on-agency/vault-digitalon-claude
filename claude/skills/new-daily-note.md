---
name: new-daily-note
description: Crea o aggiorna la nota giornaliera in daily-notes/ solo se ci sono informazioni rilevanti o task in sospeso. Autonomo.
allowed-tools: bash, read, write, edit
---

# Skill: new-daily-note

## Obiettivo
Documentare le attività rilevanti della giornata e i task in sospeso in un file giornaliero.

## Comportamento
Autonomo — crea o aggiorna la nota solo se necessario, non crea file vuoti o irrilevanti.

## Quando creare o aggiornare la nota
- Ci sono task rimasti in sospeso o non completati
- Sono state prese decisioni riguardanti: progetti, clienti, infrastruttura, agenzia, stack tecnologico usato o valutato
- Ci sono informazioni da ricordare per la sessione successiva
- L'utente lo richiede esplicitamente

## Quando NON creare la nota
- La sessione ha prodotto solo operazioni routinarie già documentate altrove
- Non ci sono task aperti né decisioni rilevanti

## Gestione file esistente
Se esiste già `daily-notes/YYYY-MM-DD.md` per oggi: aggiorna il file esistente aggiungendo in coda, non creare un secondo file.

## Struttura della nota

# YYYY-MM-DD
## Fatto oggi
* [sintesi delle attività rilevanti]
## Task in sospeso
* [task non completati o da riprendere]
## Decisioni prese
* [decisioni su progetti, clienti, infrastruttura, agenzia, stack]
## Note per la prossima sessione
* [contesto utile da ricordare]

## Processo
1. Valuta se la sessione ha prodotto contenuto che rientra nei criteri sopra
2. Se no: non fare nulla
3. Se sì:
   - Verifica se esiste già `daily-notes/YYYY-MM-DD.md`
   - Se esiste: aggiungi in coda le nuove informazioni
   - Se non esiste: crea il file con la struttura completa
4. Commit con messaggio `daily: nota giornaliera YYYY-MM-DD`

## Output atteso
- File daily note creato o aggiornato (solo se necessario)
- Commit pushato

## Fuori scope
- Creare note per giorni passati
- Duplicare informazioni già presenti nello stesso file
- Creare la nota se non ci sono informazioni rilevanti
