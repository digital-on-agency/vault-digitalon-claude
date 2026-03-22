---
name: crea-task-airtable
description: Crea un task su Airtable (DigitalOn App) a partire da informazioni fornite dall'utente o dal log.md del cliente. Usa questa skill ogni volta che l'utente dice "crea task", "aggiungi task", "metti su Airtable", "registra attività su Airtable" o simili. Chiede sempre conferma prima di creare. Non crea mai task in autonomia senza approvazione esplicita.
---

# Crea Task su Airtable — Digital On Agency

Questa skill crea un record nella tabella Task di Airtable (base DigitalOn App) collegato al progetto e al cliente giusto.

## Riferimenti Airtable (NON cercare, usa questi ID direttamente)

**Base:** appHtzPRdNURXVvgo — DigitalOn App

**Tabelle:**
- Task: tblhrxCxAzWKOaKCW
- Progetti / Servizi: tblylhAgyc47wEal2
- Clienti / Business: tbldMv8I4Wlo9s9BM

**Campi Task:**
- Titolo: fldswLgF1Yohk2WOK
- Descrizione: fldOLPGIECXPdeiq4
- Stato: fldzSIQ7vjVsPfxrg
- Progetto: fldbCZdpMKBDsrPcW
- Business: fldC2qNiQf4pnCMgy
- Deadline: fld2Ze39cTWjkxjk5 (YYYY-MM-DD)
- Priorità: fld7rTopKaduH38fb
- Operator: fldE8F4pewEKrwewc
- Categoria: fldLkHgbTurLRQXGn
- Ore: fldaIkJ2o32T9FOff

**Campo Business in Progetti/Servizi:** fld1WwX7YCdV6l9U0

**Valori Stato Task:** Da iniziare · In corso · Da Revisionare · Completata
**Valori Priorità:** Bassa · Media · Alta
**Valori Categoria Task:** Sviluppo · CRM · Chatbot · Ads · SEO · Analytics · Call · Strategia · Supporto
**Valori Tipo Progetto:** Sito Web · CRM · Chatbot · Ads · SEO · Misto
**Valori Stato Progetto:** Da Iniziare · In Lavorazione · Attivo · Chiuso

## Processo

### Step 1 — Raccogli le informazioni
**Obbligatori:** titolo, cliente, progetto, categoria
**Opzionali:** descrizione, deadline (YYYY-MM-DD), ore, priorità (default: Media), stato (default: Da iniziare), operatore

### Step 2 — Trova i Record ID
1. list_records_for_table su Clienti/Business (tbldMv8I4Wlo9s9BM) — cerca per nome cliente
2. list_records_for_table su Progetti/Servizi (tblylhAgyc47wEal2) — cerca per nome progetto

### Step 3 — Mostra riepilogo e chiedi conferma
Mostrare sempre prima di creare:
📋 Titolo / 👤 Cliente / 📁 Progetto / 🏷️ Categoria / ⏱️ Ore / 📅 Deadline / ⚡ Priorità / 📊 Stato / 📝 Descrizione
Procedere SOLO dopo conferma esplicita.

### Step 4 — Crea il record
Usa create_records_for_table sulla tabella Task.
Per campi multipleRecordLinks usa: ["recXXXXXXXXXXXXXX"]
Se il progetto non esiste su Airtable: crealo prima, poi collegalo subito al Business con update_records_for_table sul campo fld1WwX7YCdV6l9U0 — non lasciare mai un progetto scollegato dal cliente.

### Step 5 — Conferma e aggiorna log.md
1. Comunica: "Task creato su Airtable ✓"
2. Aggiungi riga in log.md del cliente con ID Airtable in Note portale

## Regole
- Mai creare senza conferma esplicita
- Se cliente o progetto non trovato, segnalare e non procedere
- Ore accetta decimali (es. 1.5 per 1h30m)
- Default Priorità: Media — Default Stato: Da iniziare
- Non modificare mai record esistenti — solo creazione
