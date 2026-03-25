---
name: resoconto-sessione
description: Fa un resoconto delle attività svolte durante la sessione, le sincronizza con Airtable e aggiorna il log del vault. Usare quando l'utente dice "resoconto", "fine sessione", "wrap up", "cosa abbiamo fatto oggi", "chiudiamo la sessione". NON aggiorna mai il log senza prima aver creato o verificato il task in Airtable. NON crea mai task aperte — solo completate.
allowed-tools: Vault Digital On MCP, Airtable MCP
---

# Skill: resoconto-sessione

## Obiettivo

Al termine di una sessione di lavoro, produrre un recap strutturato delle attività svolte, sincronizzarle con Airtable e aggiornare il log del vault — usando sempre il Record ID di Airtable come identificativo.

## Riferimenti Airtable

**Base:** `appHtzPRdNURXVvgo` — DigitalOn App

**Tabella Task:** `tblhrxCxAzWKOaKCW`
- Titolo: `fldswLgF1Yohk2WOK`
- Descrizione: `fldOLPGIECXPdeiq4`
- Stato: `fldzSIQ7vjVsPfxrg` → valori: `Da iniziare` · `In corso` · `Da Revisionare` · `Completato`
- Categoria: `fldLkHgbTurLRQXGn` → valori: `Sviluppo` · `CRM` · `Chatbot` · `Ads` · `SEO` · `Analytics` · `Call` · `Strategia` · `Supporto`
- Priorità: `fld7rTopKaduH38fb` → valori: `Bassa` · `Media` · `Alta`
- Ore: `fldaIkJ2o32T9FOff`
- Operator: `fldE8F4pewEKrwewc` (link a Users — cercare per nome)
- Progetto: `fldbCZdpMKBDsrPcW` (link a Progetti)
- Business: `fldC2qNiQf4pnCMgy` (link a Clienti/Business)
- Deadline: `fld2Ze39cTWjkxjk5`

**Tabella Progetti:** `tblylhAgyc47wEal2`
- Nome: `fldhGdGhIRk8Op4uL`

**Tabella Users:** `tblUZSu2Goo77rTf5`
- Nome: `fldgSde4cXK4QEzAh`

**Tabella Clienti/Business:** `tbldMv8I4Wlo9s9BM`
- Nome: `fldu9MFlYRd2XQyuB`

## Processo

### Step 1 — Recap attività

Leggi la conversazione corrente e identifica tutte le attività svolte. Producile come lista strutturata raggruppata per cliente e progetto:

```
## Attività svolte

### [Nome Cliente]
**Progetto:** [nome progetto]
- [descrizione attività 1] — categoria: [X] — ore stimate: [X]
- [descrizione attività 2] — categoria: [X] — ore stimate: [X]
```

Mostra la lista all'utente e chiedi: **"È corretto? Manca qualcosa?"**
Aspetta conferma prima di procedere.

### Step 2 — Chi ha lavorato

Chiedi: **"Chi ha svolto queste attività?"**
Se più persone hanno lavorato su attività diverse, chiedi per ciascuna.
Cerca il nome nella tabella Users di Airtable per ottenere il Record ID dell'operatore.

### Step 3 — Verifica in Airtable

Per ogni attività, cerca in Airtable se esiste già un task con titolo simile collegato a quel cliente/progetto:

```
Airtable:list_records_for_table con filterByFormula:
SEARCH(LOWER("[parola chiave]"), LOWER({fldswLgF1Yohk2WOK}))
```

Mostra il risultato per ogni attività:
- ✅ **Trovata** → mostra titolo, stato attuale, Record ID
- ❌ **Non trovata** → segnala che va creata

### Step 4 — Crea task mancanti

Per ogni attività senza task in Airtable:

1. Mostra all'utente la task che sta per creare con tutti i campi
2. Chiedi conferma
3. Crea il record in Airtable con:
   - Titolo: descrizione sintetica dell'attività
   - Descrizione: dettaglio di cosa è stato fatto
   - Stato: **"Completato"** direttamente — non creare mai task aperte in questo flusso
   - Categoria: quella identificata nel recap
   - Ore: quelle stimate/dichiarate
   - Operator: Record ID dell'utente trovato nello Step 2
   - Business: Record ID del cliente
   - Progetto: Record ID del progetto (se disponibile)
4. Salva il Record ID restituito da Airtable

> ⚠️ Non creare mai task aperte (Da iniziare / In corso) in questo flusso — solo Completato.

### Step 5 — Verifica task esistenti

Per le task già presenti in Airtable (Step 3 ✅):
- Se stato = "Completato" → procedi direttamente al log
- Se stato ≠ "Completato" → chiedi: **"Questa task è ora completata?"**
  - Sì → aggiorna stato a "Completato" in Airtable, poi procedi al log
  - No → non aggiungere al log, salta

### Step 6 — Aggiorna il log del vault

Per ogni task completata (nuova o già esistente), aggiorna il log del cliente nel vault.

**Formato riga:**
```
| [Record ID Airtable] | [GG-MM-AAAA] | [nome progetto] | [descrizione attività] | [Categoria] | [ore] | [Operatore] | Completato | |
```

**Regole:**
- Leggi sempre il log esistente prima di scrivere — non sovrascrivere le righe precedenti
- Aggiungi le nuove righe in fondo alla tabella
- Usa il Record ID di Airtable (formato `recXXXXXXXXXXXXXX`) come ID Task
- Il campo Data è la data odierna in formato GG-MM-AAAA

### Step 7 — Conferma finale

Mostra un riepilogo di tutto quello che è stato fatto:

```
## Resoconto completato

### Task create in Airtable
- [Record ID] — [Titolo] — [Cliente]

### Task aggiornate in Airtable
- [Record ID] — [Titolo] — [nuovo stato]

### Log aggiornati
- clients/[cliente]/log.md → [N] righe aggiunte
```

## Regole operative

- **Mai aggiornare il log senza Record ID Airtable** — il Record ID è obbligatorio
- **Mai creare task aperte** — solo Completato in questo flusso
- **Sempre chiedere conferma** prima di creare o aggiornare record in Airtable
- **Sempre leggere il log esistente** prima di scrivere per non sovrascrivere
- **Non aggiornare CLAUDE.md o prossimi passi** — questo flusso è solo log e Airtable
- Se un'attività non è completata, non va nel log — punto

## Fuori scope

- Creare task aperte o pianificazione futura → usa airtable-task-manager
- Aggiornare stato progetto o CLAUDE.md → flusso separato
- Generare report mensile → usa genera-report
