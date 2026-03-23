---
name: carica-fattura
description: Carica una fattura PDF su Google Drive e crea il record nella tabella Pagamenti di Airtable, collegandolo al cliente giusto e rendendolo visibile sul portale Softr. Usa questa skill ogni volta che l'utente dice "carica fattura", "aggiungi pagamento", "registra fattura", "nuova fattura" o simili. Legge automaticamente i dati dal PDF allegato. Chiede sempre conferma prima di creare.
---

# Carica Fattura — Digital On Agency

Questa skill legge il PDF della fattura, estrae i dati automaticamente, carica il file su Google Drive, crea il record su Airtable nella tabella Pagamenti e lo collega al cliente e all'utente giusto per il filtro Softr.

## Riferimenti Airtable

**Base:** appHtzPRdNURXVvgo — DigitalOn App

**Tabella Pagamenti:** tblALppB73JC9g8Lh
- Nome: fldkFAX4ozpFB4Qkk
- Importo: fldtPZPPxZEUlO1bl (currency)
- Data Emissione: fld7dqatZMmqdP5SC (YYYY-MM-DD)
- Data Scadenza: fldxrhoKwWp1v9l6b (YYYY-MM-DD — opzionale)
- Data Pagamento: fldgeStgEoJCA5q1O (YYYY-MM-DD — opzionale)
- Stato: fldbrV6Gc3ZUGKOt3
- Fattura: fldUJvh4k37e8hOQT (attachment — URL pubblico)
- Metodo di Pagamento: fldMlClLOOhvWCXfi
- Cliente: fldA9qFTOwhaUxQBi (link a Clienti/Business)
- Progetto: fldTAPKBWEIG1RjtN (link a Progetti/Servizi)
- Users: fld3sk1hDxOnLzZMf (link a Users — per filtro Softr)

**Valori Stato:** Da pagare · Pagata
**Valori Metodo:** Bonifico · Cash · Link Stripe · PayPal

**Tabella Clienti/Business:** tbldMv8I4Wlo9s9BM
**Tabella Progetti/Servizi:** tblylhAgyc47wEal2
**Tabella Users:** tblUZSu2Goo77rTf5

---

## Processo

### Step 1 — Leggi il PDF e estrai i dati automaticamente

Se l'utente allega un PDF, leggerlo e estrarre:
- Nome/numero fattura
- Ragione sociale cliente
- Importo totale in euro
- Data emissione
- Data scadenza (se presente)
- Metodo di pagamento (se indicato)

Presentare i dati estratti per conferma prima di procedere.
Se alcuni dati non sono leggibili, chiedere conferma.
Se non c'e PDF allegato, chiedere i dati manualmente.

---

### Step 2 — Carica il PDF su Google Drive

Usa il connettore workspace-digitalon per caricare in:
Fatture/[slug-cliente]/[YYYY-MM]-fattura-[cliente].pdf

Dopo l'upload ottieni il link pubblico del file.

---

### Step 3 — Trova i Record ID

1. Cerca il cliente in Clienti/Business (tbldMv8I4Wlo9s9BM) per nome
2. Se specificato, cerca il progetto in Progetti/Servizi (tblylhAgyc47wEal2) per nome
3. Cerca l'utente in Users (tblUZSu2Goo77rTf5) per email — serve per filtro Softr

---

### Step 4 — Mostra riepilogo e chiedi conferma

Mostrare: Nome, Cliente, Progetto, Importo, Date, Metodo, Stato, link PDF
Procedere SOLO dopo conferma esplicita.

---

### Step 5 — Crea il record su Airtable

Usa create_records_for_table sulla tabella Pagamenti con tutti i campi.
Per il campo Fattura (attachment): [{"url": "link-drive", "filename": "fattura-cliente-mese.pdf"}]
Per campi multipleRecordLinks: ["recXXXXXXXXXXXXXX"]

---

### Step 6 — Aggiorna lo storico

1. Comunica: "Fattura caricata su Airtable e visibile sul portale per [cliente]"
2. Aggiorna Storico attivita nel CLAUDE.md cliente

---

## Regole

- MAI creare senza conferma esplicita
- Estrarre sempre i dati dal PDF — non chiedere dati che si possono leggere dalla fattura
- Caricare PDF su Drive PRIMA di creare il record su Airtable
- Cartella Drive: Fatture/[slug-cliente]/
- Collegare sempre il campo Users — senza questo la fattura non e visibile su Softr
- Non modificare mai record esistenti — solo creazione
