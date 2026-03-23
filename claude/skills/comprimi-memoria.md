---
name: comprimi-memoria
description: Comprime i file di memoria quando superano 50KB o ogni 20 commit. Autonomo, notifica su Discord al termine tramite notify-discord.sh. Tiene log in claude/compression-log.md.
allowed-tools: bash, read, write, edit, glob
---

# Skill: comprimi-memoria

## Obiettivo

Mantenere i file di memoria snelli e leggibili comprimendo le informazioni più vecchie.

## Comportamento

Autonomo — nessuna conferma richiesta.

## Trigger

Questa skill viene eseguita se almeno una delle seguenti condizioni è vera:

- Un file soggetto supera 50KB
- Il numero di commit totali meno il numero salvato in `claude/compression-log.md` (sezione "Ultimo commit compressione") è ≥ 20

## File soggetti a compressione

- memory/MEMORY.md
- memory/patterns.md
- memory/decisions.md
- clients/[cliente]/CLAUDE.md
- clients/[cliente]/projects/[progetto]/CLAUDE.md
- daily-notes/

## File esclusi

- knowledge/
- claude/
- research/
- agency/

## Gestione inbox/

Se trova materiale in `inbox/` durante l'esecuzione, invoca la skill `svuota-inbox` prima di procedere con la compressione.

## Processo

1. Leggi `claude/compression-log.md` per il numero dell'ultimo commit di compressione
2. Esegui `git log --oneline | wc -l` per il numero attuale di commit
3. Verifica le dimensioni dei file soggetti con `du -b [file]`
4. Se nessun trigger è attivo: termina senza fare nulla
5. Se almeno un trigger è attivo:

   a. Se c'è materiale in inbox/: invoca skill `svuota-inbox`

   b. Per ogni file soggetto che supera 50KB o è coinvolto dal trigger commit:
      - Mantieni complete le decisioni/informazioni degli ultimi 3 mesi
      - Riassumi le decisioni più vecchie nel formato: `- [YYYY-MM-DD] [cliente/contesto] — [decisione in una riga]`
      - Mantieni sempre traccia degli errori e come sono stati corretti
      - Non eliminare mai informazioni senza riassumerle

   c. Aggiorna `claude/compression-log.md`:
      - Sezione "Ultimo commit compressione": scrivi il numero attuale di commit
      - Sezione "Storico compressioni": appendi un nuovo blocco con data, trigger, file compressi e sintesi di cosa è stato riassunto e dove

   d. Invia notifica su Discord: `bash ~/vault-digitalon/claude/scripts/notify-discord.sh "Compressione memoria: [lista file] — [sintesi modifiche]"`

   e. Commit con messaggio `compress: compressa memoria - [lista file] - [sintesi]`

## Formato aggiornamento compression-log.md

```
# YYYY-MM-DD

* Trigger: [50KB su [file] / 20 commit]
* File compressi: [lista file]
* Sintesi: [cosa è stato riassunto in ogni file]
```

## Output atteso

- File compressi e aggiornati
- compression-log.md aggiornato
- Notifica Discord inviata
- Commit pushato

## Fuori scope

- Comprimere file esclusi
- Eliminare informazioni senza riassumerle
- Chiedere conferma all'utente
