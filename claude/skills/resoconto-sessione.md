---
name: resoconto-sessione
description: Chiude una sessione di lavoro producendo un recap strutturato delle attività svolte, verificando i task su Airtable, creando quelli mancanti e aggiornando il log del vault. Usare quando l'utente scrive "resoconto", "fine sessione", "wrap up", "cosa abbiamo fatto oggi", "chiudi la sessione" o simili. Non crea mai task aperte — solo completate o niente.
allowed-tools: Vault Digital On MCP, Airtable MCP
---

# Skill: resoconto-sessione

## Obiettivo

Chiudere una sessione di lavoro in modo strutturato: recap attività → verifica Airtable → creazione task mancanti (solo se confermato) → log vault. Tutto con conferma esplicita dell'utente prima di scrivere qualsiasi cosa.

## Principio fondamentale

**Non creare mai task aperte.** Se un'attività non è completata, non va né in Airtable né nel log. Meglio un log pulito che uno pieno di task fantasma.

## Riferimenti Airtable

**Base:** `appHtzPRdNURXVvgo` — DigitalOn App

**Tabella Task:** `tblhrxCxAzWKOaKCW`
- Titolo: `fldswLgF1Yohk2WOK`
- Descrizione: `fldOLPGIECXPdeiq4`
- Stato: `fldzSIQ7vjVsPfxrg` → valori: `Da iniziare` · `In corso` · `Da Revisionare` · `Completato`
- Categoria: `fldLkHgbTurLRQXGn` → valori: `Sviluppo` · `CRM` · `Chatbot` · `Ads` · `SEO` · `Analytics` · `Call` · `Strategia` · `Supporto`
- Priorità: `fld7rTopKaduH38fb` → valori: `Bassa` · `Media` · `Alta`
- Ore: `fldaIkJ2o32T9FOff`
- Operator: `fldE8F4pewEKrwewc` (link a Users — `tblUZSu2Goo77rTf5`)
- Progetto: `fldbCZdpMKBDsrPcW` (link a Progetti — `tblylhAgyc47wEal2`)
- Business: `fldC2qNiQf4pnCMgy` (link a Clienti — `tbldMv8I4Wlo9s9BM`)

**Tabella Users:** `tblUZSu2Goo77rTf5`
- Nome: `fldgSde4cXK4QEzAh`

**Tabella Progetti:** `tblylhAgyc47wEal2`
- Nome: `fldhGdGhIRk8Op4uL`

**Tabella Clienti:** `tbldMv8I4Wlo9s9BM`
- Nome: `fldu9MFlYRd2XQyuB`

---

## Processo

### Step 1 — Recap attività

Leggi la conversazione corrente e produci un elenco strutturato di tutto quello che è stato fatto. Raggruppa per cliente e progetto. Sii preciso — non inventare attività non avvenute.

Formato output:

```
📋 Resoconto sessione — [data]

**[Nome Cliente]**
  → [progetto]: [descrizione attività] (~X ore)
  → [progetto]: [descrizione attività] (~X ore)

**[Nome Cliente 2]**
  → ...
```

Mostra il recap e chiedi: **"È corretto? Vuoi aggiungere o rimuovere qualcosa?"**
Non procedere finché l'utente non conferma.

---

### Step 2 — Chi ha lavorato

Chiedi: **"Chi ha eseguito queste attività?"**

Se più persone hanno lavorato su attività diverse, chiedi per ciascuna.

Cerca il Record ID dell'operatore nella tabella Users di Airtable filtrando per nome. Se non trovato, chiedi all'utente di verificare.

---

### Step 3 — Verifica in Airtable

Per ogni attività nel recap, cerca in Airtable nella tabella Task se esiste già un task con titolo simile collegato a quel cliente/progetto.

Mostra il risultato in modo chiaro:

```
✅ [Titolo task] — trovata (stato: Completato / In corso)
❌ [Descrizione attività] — non trovata in Airtable
```

Per le task ✅ già esistenti e già "Completato" → vanno direttamente al log (Step 5).
Per le task ✅ esistenti ma non completate → chiedi: "Vuoi segnarla come Completato?"
Per le task ❌ non trovate → vai allo Step 4.

---

### Step 4 — Proponi creazione task mancanti

Per ogni attività senza task in Airtable, proponi la creazione mostrando i dettagli:

```
Proposta task da creare:
- Titolo: [titolo]
- Cliente: [nome cliente]
- Progetto: [nome progetto]
- Categoria: [categoria]
- Ore: [ore stimate]
- Operatore: [nome]
- Stato: Completato

Creo questa task? (sì / no / modifica)
```

**Attendi conferma esplicita per ogni task.** Non creare mai in batch senza conferma.

Se l'utente dice "no" → l'attività non viene loggata, niente task in Airtable.
Se l'utente dice "modifica" → chiedi cosa cambiare e ri-mostra la proposta.
Se l'utente dice "sì" → crea il record in Airtable con `typecast: true` e salva il Record ID.

---

### Step 5 — Aggiorna il log del vault

Solo per le task con stato **Completato** (nuove o già esistenti in Airtable), aggiungi una riga nel log del cliente usando il Record ID di Airtable come ID task.

Leggi prima il log esistente con `list_files` e `read_file` per:
1. Verificare che il Record ID non sia già presente (evita duplicati)
2. Aggiungere in coda senza sovrascrivere

Formato riga:

```
| [Record ID Airtable] | [GG-MM-AAAA] | [nome progetto] | [descrizione attività] | [Categoria] | [ore] | [Operatore] | Completato | |
```

Dopo aver scritto, mostra all'utente le righe aggiunte e conferma i file aggiornati.

---

## Regole operative

- **Mai creare task aperte** — stato sempre `Completato` o non si crea
- **Sempre typecast: true** per campi singleSelect in Airtable
- **Conferma esplicita** prima di creare qualsiasi task o scrivere nel log
- **No duplicati** — verificare sempre che il Record ID non sia già nel log
- **Un cliente alla volta** — se ci sono più clienti, processa uno per volta
- **Se Airtable non risponde** — segnalarlo e procedere solo con il log vault usando una nota temporanea invece del Record ID, da aggiornare nella sessione successiva

## Fuori scope

- Creare task aperte o pianificare prossimi passi
- Aggiornare il CLAUDE.md del progetto
- Inviare notifiche o report al cliente
