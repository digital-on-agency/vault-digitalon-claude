---
name: aggiorna-progetto
description: Aggiorna lo stato e le informazioni di un progetto esistente nel vault. Autonomo — capisce dal contesto quale progetto aggiornare, chiede solo se non è chiaro.
allowed-tools: bash, read, write, edit, glob
---

# Skill: aggiorna-progetto

## Obiettivo
Mantenere aggiornato il CLAUDE.md di un progetto con le ultime informazioni, decisioni e stato di avanzamento.

## Comportamento
Autonomo — deduce cliente e progetto dal contesto della conversazione. Chiede esplicitamente solo se non è chiaro.

## Struttura del file progetto
Segui sempre la struttura di `clients/_template/projects/_template/CLAUDE.md`:
- Obiettivo
- Stato attuale (stato + data ultimo aggiornamento)
- Stack tecnologico
- Decisioni prese
- Prossimi passi
- Problemi aperti
- Storico
- Note operative

## Dati sensibili
Se durante l'aggiornamento emergono credenziali, password, token o accessi:
- NON scriverli in CLAUDE.md
- Scrivili in `clients/[cliente]/projects/[progetto]/secrets.md`
- In CLAUDE.md scrivi solo il riferimento (es. "credenziali in secrets.md")
- secrets.md è escluso da git — rimane solo sul server

## Processo

### Identificazione cliente e progetto
1. Deduce cliente e progetto dal contesto della conversazione
2. Se non è chiaro: chiedi esplicitamente prima di procedere
3. Verifica che esista `clients/[cliente]/projects/[progetto]/CLAUDE.md`
4. Se il progetto non esiste: chiedi all'utente cosa fare
   - Se il cliente esiste: puoi creare il progetto (chiedi conferma)
   - Se il cliente non esiste: rimanda a skill `onboarding-cliente` prima di procedere
   - Eccezione: se l'utente specifica esplicitamente che il progetto può essere "orfano", procedi senza cliente

### Aggiornamento del file
1. Leggi il file esistente
2. Identifica le sezioni da aggiornare in base alle nuove informazioni
3. Aggiorna le sezioni pertinenti aggiungendo in coda (non sovrascrivere)
4. Aggiorna lo stato se dal contesto è chiaro il cambiamento (es. "abbiamo completato il progetto" → stato: completato)
5. Aggiorna la data in cima al file e la data in "Stato attuale"
6. Se il file supera 50KB: sposta decisioni vecchie e prossimi passi completati in "Storico" riassumendoli

### Aggiornamenti trasversali al cliente
Se le nuove informazioni non sono direttamente legate al progetto ma si applicano al cliente in generale (es. nuovo referente, cambiamento accordi, nuova info di contatto):
- Aggiorna anche `clients/[cliente]/CLAUDE.md`
- Avvisa l'utente di cosa hai aggiornato nel file cliente

### Commit
- Se aggiornato solo il progetto: `update: [cliente]/[progetto] - [descrizione]`
- Se aggiornato anche il cliente: `update: [cliente] e [progetto] - [descrizione]`

## Output atteso
- CLAUDE.md del progetto aggiornato
- CLAUDE.md del cliente aggiornato se necessario
- secrets.md creato/aggiornato se ci sono dati sensibili
- Commit pushato

## Fuori scope
- Creare nuovi clienti (usa onboarding-cliente)
- Modificare knowledge o agency
- Aggiornare MEMORY.md (lo fa il memory-manager)
