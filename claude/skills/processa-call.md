---
name: processa-call
description: Processa una trascrizione di call Meet e compila il riassunto nel vault. Usa questa skill ogni volta che l'utente dice "riassumi la call", "processa la trascrizione", "ho una call da registrare", "carica la riunione" o simili. Estrae decisioni, action item e note operative, aggiorna i CLAUDE.md coinvolti e propone i task su Airtable.
---

# Processa Call — Digital On Agency

Questa skill legge una trascrizione di call (da Google Meet, Otter, o testo incollato), produce un riassunto strutturato e aggiorna il vault con le informazioni emerse.

## Processo

### Step 1 — Ricevi la trascrizione
La trascrizione può arrivare in tre modi:
- File in calls/raw/ — l'utente ha già salvato il file nel vault
- File allegato — l'utente allega il file nella conversazione
- Testo incollato — l'utente incolla direttamente il testo

Chiedi se non è chiaro quale cliente o progetto è coinvolto.

### Step 2 — Estrai le informazioni chiave
Leggi tutta la trascrizione e identifica:
- Partecipanti e ruoli se deducibili
- Contesto — perché si è tenuta la call, in una riga
- Decisioni prese — solo decisioni concrete. Per ogni decisione: a quale progetto si riferisce, se è [BLOCCATO] o [DEFAULT]
- Action item — solo task concreti con responsabile: cosa fare, chi, entro quando
- Problemi emersi — blocchi, rischi, dipendenze
- Note interne — osservazioni utili ma non da comunicare

### Step 3 — Compila il template call
Crea clients/[cliente]/calls/YYYY-MM-DD-[tema].md con:
- Data, partecipanti, durata, progetti coinvolti
- Contesto (una riga)
- Decisioni prese con tag [PROGETTO] e tipo
- Action item in formato: [ ] cosa — chi — entro quando — ID task
- Problemi emersi
- Note interne

### Step 4 — Aggiorna i CLAUDE.md coinvolti
Mostrare sempre all'utente cosa cambierà prima di scrivere.
- Sempre: aggiorna Storico attività nel CLAUDE.md cliente
- Se decisioni trasversali: aggiorna Vincoli e decisioni trasversali nel CLAUDE.md cliente
- Se decisioni di progetto: aggiorna Decisioni, Stato attuale e Prossimi passi nel CLAUDE.md del progetto

### Step 5 — Proponi i task su Airtable
Per ogni action item di competenza Digital On mostrare riepilogo e chiedere conferma:
"Ho trovato questi action item da creare su Airtable: [lista]. Creo tutti, alcuni o nessuno?"
Usare la skill crea-task-airtable per la creazione effettiva.

### Step 6 — Archivia la trascrizione grezza
Salvare il testo grezzo in calls/raw/YYYY-MM-DD-[tema]-raw.md

## Regole
- Non inventare mai decisioni o action item — solo ciò che è esplicitamente detto
- Se ambiguo su chi è responsabile: segnalare con <!-- DA CHIARIRE -->
- Non aggiornare mai i CLAUDE.md senza prima mostrare cosa cambierà
- Task su Airtable solo per action item di competenza Digital On
- Se la call riguarda più clienti: creare un file separato per cliente
