---
name: handle-daily-notes
description: Raggruppa le note giornaliere della settimana in un file settimanale e elimina i file dei singoli giorni. Autonomo.
allowed-tools: bash, read, write, edit, glob
---

# Skill: handle-daily-notes

## Obiettivo
Mantenere `daily-notes/` ordinata archiviando le note giornaliere in file settimanali, con un riassunto automatico generato da Claude.

## Comportamento
Autonomo — nessuna conferma richiesta.

## Trigger
- Ci sono 7 o più file giornalieri in `daily-notes/`
- L'utente lo richiede esplicitamente

## Formato file settimanale
Il file settimanale viene creato in `daily-notes/` con nome `YYYY-WXX.md`:
```
# Settimana WXX — YYYY (YYYY-MM-DD / YYYY-MM-DD)

## Riassunto settimana
[Riassunto generato da Claude leggendo tutte le note della settimana: attività principali, decisioni prese, task completati e aperti]

## Lunedì YYYY-MM-DD
[contenuto della nota giornaliera]

## Mercoledì YYYY-MM-DD
[contenuto della nota giornaliera]
```

I giorni senza nota vengono saltati — non viene inserita nessuna riga per i giorni senza attività.

## Processo
1. Elenca tutti i file `YYYY-MM-DD.md` in `daily-notes/`
2. Se non ci sono file da archiviare: termina senza fare nulla
3. Raggruppa i file per settimana ISO (lunedì-domenica)
4. Per ogni settimana da archiviare (settimane passate + settimane con trigger attivo):
   a. Leggi tutte le note della settimana
   b. Genera un riassunto sintetico delle attività principali, decisioni prese, task completati e aperti
   c. Crea `daily-notes/YYYY-WXX.md` con struttura:
      - Header con numero settimana e intervallo date
      - Sezione "Riassunto settimana" con il riassunto generato
      - Una sezione per ogni giorno con nota (solo i giorni con contenuto)
   d. Elimina i file giornalieri della settimana
5. Commit con messaggio `archive: archiviata settimana YYYY-WXX`

## Quale settimane archiviare
- **Settimane passate**: sempre, indipendentemente dal numero di giorni con note
- **Settimana corrente**: NON archiviare — aspettare che la settimana sia terminata
- Il calcolo della settimana corrente si basa sulla data di oggi

## Output atteso
- File settimanale creato per ogni settimana archiviata
- File giornalieri eliminati
- Commit pushato

## Fuori scope
- Archiviare la settimana corrente
- Modificare file settimanali già esistenti
- Creare file settimanali vuoti se non ci sono note
