---
name: svuota-inbox
description: Classifica il materiale presente in inbox/ nei posti giusti del vault. Autonomo — chiede all'utente solo se non riesce a classificare un file.
allowed-tools: bash, read, write, edit, glob
---

# Skill: svuota-inbox

## Obiettivo
Processare tutto il materiale in `inbox/` classificandolo nella struttura corretta del vault, mantenendo il vault ordinato e la inbox sempre pulita.

## Comportamento
Autonomo — agisce senza chiedere conferma. Chiede all'utente solo se non riesce a determinare la classificazione corretta di un file.

## Quando viene invocata
- **Inizio sessione**: se inbox/ contiene file, Claude segnala all'utente quanti file ci sono e chiede se processarli subito o dopo. Non processa automaticamente senza indicazione.
- **Invocazione esplicita dall'utente**: processa tutto immediatamente senza chiedere
- **Invocazione da altra skill** (es. comprimi-memoria): processa tutto immediatamente senza chiedere

## Come arriva il materiale in inbox/
- Inserito manualmente dall'utente
- Inserito da Claude durante una sessione quando ritiene opportuno salvare qualcosa temporaneamente
- Inserito tramite Discord da Claude o dall'utente

## Formato atteso
- File sempre in markdown (.md)
- Se il file referenzia altri tipi di file (immagini, PDF, ecc.), questi sono descritti e linkati dentro il markdown

## Processo

### Per ogni file in inbox/
1. Leggi il contenuto del file
2. Determina la classificazione:
   - Info su un cliente → `clients/[cliente]/CLAUDE.md`
   - Info su un progetto specifico → `clients/[cliente]/projects/[progetto]/CLAUDE.md`
   - Attività/log da registrare → `clients/[cliente]/log.md`
   - Riassunto di una call → `clients/[cliente]/calls/YYYY-MM-DD-[tema].md`
   - Conoscenza operativa riutilizzabile → invoca skill `aggiungi-knowledge`
   - Info sull'agenzia → invoca skill `aggiorna-agency`
   - Decisione trasversale globale → `memory/decisions.md`
   - Pattern operativo trasversale → `memory/patterns.md`
3. Se il contenuto riguarda più destinazioni: divide il contenuto e lo mette nei posti appropriati
4. Se non riesci a classificare: chiedi all'utente dove mettere il file prima di procedere
5. Integra il contenuto nel file di destinazione (non sovrascrivere — aggiungere in coda o nella sezione appropriata)
6. Elimina il file da inbox/ dopo averlo classificato
7. Aggiorna `memory/MEMORY.md` se la classificazione ha impatto globale (es. nuovo cliente, nuovo progetto)

### Al termine
- Se inbox/ è ora vuota: conferma "inbox/ svuotata — N file classificati"
- Se inbox/ ha ancora file non classificati: elenca i file rimasti e il motivo

## Output atteso
- inbox/ svuotata (o con solo i file non classificabili)
- Contenuto distribuito nei posti giusti
- MEMORY.md aggiornato se necessario
- Commit con messaggio `inbox: classificati N file — [destinazioni]`

## Fuori scope
- Creare nuove cartelle fuori dalla struttura definita
- Modificare file in knowledge/ direttamente (usa aggiungi-knowledge)
- Modificare file in agency/ direttamente (usa aggiorna-agency)
- Archiviare invece di eliminare i file processati
