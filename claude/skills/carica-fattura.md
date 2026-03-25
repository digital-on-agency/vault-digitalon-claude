---
name: carica-fattura
description: Carica una fattura PDF su Google Drive e crea il record nella tabella Pagamenti di Airtable, collegandolo al cliente giusto e rendendolo visibile sul portale Softr. Usa questa skill ogni volta che l'utente dice "carica fattura", "aggiungi pagamento", "registra fattura", "nuova fattura" o simili. Legge automaticamente i dati dal PDF allegato. Chiede sempre conferma prima di creare.
---

# Carica Fattura — Digital On Agency

Questa skill legge il PDF, estrae i dati, carica su Google Drive e crea il record su Airtable via API REST diretta (curl) — non usa il connettore MCP Airtable per evitare problemi di autenticazione OAuth.

## Riferimenti Airtable

**Base:** appHtzPRdNURXVvgo
**Tabella Pagamenti:** tblALppB73JC9g8Lh
- Nome: fldkFAX4ozpFB4Qkk
- Importo: fldtPZPPxZEUlO1bl
- Data Emissione: fld7dqatZMmqdP5SC (YYYY-MM-DD)
- Data Scadenza: fldxrhoKwWp1v9l6b (YYYY-MM-DD)
- Data Pagamento: fldgeStgEoJCA5q1O (YYYY-MM-DD)
- Stato: fldbrV6Gc3ZUGKOt3
- Fattura: fldUJvh4k37e8hOQT (attachment)
- Metodo di Pagamento: fldMlClLOOhvWCXfi
- Cliente: fldA9qFTOwhaUxQBi
- Progetto: fldTAPKBWEIG1RjtN
- Users: fld3sk1hDxOnLzZMf

**Valori Stato:** Da pagare · Pagata
**Valori Metodo:** Bonifico · Cash · Link Stripe · PayPal

**Tabella Clienti/Business:** tbldMv8I4Wlo9s9BM (campo Name: fldu9MFlYRd2XQyuB)
**Tabella Progetti/Servizi:** tblylhAgyc47wEal2 (campo Name: fldhGdGhIRk8Op4uL)
**Tabella Users:** tblUZSu2Goo77rTf5 (campo Email: fldbBaFVRaRtb4ivM)

## Come leggere il token Airtable

```bash
AIRTABLE_TOKEN=$(cat /home/niccolo/vault-digitalon/.mcp.json | python3 -c "import sys,json; config=json.load(sys.stdin); print(config['mcpServers']['airtable']['headers']['Authorization'].replace('Bearer ',''))" 2>/dev/null || \
cat /home/niccolo/vault-digitalon/.mcp.json | python3 -c "import sys,json; config=json.load(sys.stdin); print(config['mcpServers']['airtable'].get('env',{}).get('AIRTABLE_TOKEN',''))" 2>/dev/null)
```

## Come fare chiamate Airtable via curl

```bash
# Cerca record per nome
curl -s "https://api.airtable.com/v0/appHtzPRdNURXVvgo/[TABLE_ID]" \
  -H "Authorization: Bearer $AIRTABLE_TOKEN" | python3 -c "import sys,json; data=json.load(sys.stdin); [print(r['id'], r['fields'].get('Name','')) for r in data.get('records',[])]"

# Crea record
curl -s -X POST "https://api.airtable.com/v0/appHtzPRdNURXVvgo/tblALppB73JC9g8Lh" \
  -H "Authorization: Bearer $AIRTABLE_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"records":[{"fields":{...}}]}'
```

---

## Processo

### Step 1 — Leggi il PDF e estrai i dati

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

Ottieni il link pubblico del file dopo l'upload.

---

### Step 3 — Trova i Record ID via curl

Leggi il token Airtable con il comando indicato sopra, poi:

1. Cerca cliente in Clienti/Business (tbldMv8I4Wlo9s9BM) per nome
2. Se specificato, cerca progetto in Progetti/Servizi (tblylhAgyc47wEal2) per nome
3. Cerca utente in Users (tblUZSu2Goo77rTf5) per email

---

### Step 4 — Mostra riepilogo e chiedi conferma

Mostrare: Nome, Cliente, Progetto, Importo, Date, Metodo, Stato, link PDF
Procedere SOLO dopo conferma esplicita.

---

### Step 5 — Crea il record su Airtable via curl

```bash
curl -s -X POST "https://api.airtable.com/v0/appHtzPRdNURXVvgo/tblALppB73JC9g8Lh" \
  -H "Authorization: Bearer $AIRTABLE_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "records": [{
      "fields": {
        "fldkFAX4ozpFB4Qkk": "Fattura [mese] [anno] — [cliente]",
        "fldtPZPPxZEUlO1bl": [IMPORTO],
        "fld7dqatZMmqdP5SC": "[YYYY-MM-DD]",
        "fldxrhoKwWp1v9l6b": "[YYYY-MM-DD]",
        "fldbrV6Gc3ZUGKOt3": "Da pagare",
        "fldMlClLOOhvWCXfi": "[METODO]",
        "fldUJvh4k37e8hOQT": [{"url": "[LINK_DRIVE]", "filename": "fattura.pdf"}],
        "fldA9qFTOwhaUxQBi": ["[REC_CLIENTE]"],
        "fldTAPKBWEIG1RjtN": ["[REC_PROGETTO]"],
        "fld3sk1hDxOnLzZMf": ["[REC_USER]"]
      }
    }]
  }'
```

---

### Step 6 — Aggiorna lo storico

1. Comunica: "Fattura caricata su Airtable e visibile sul portale per [cliente]"
2. Aggiorna Storico attivita nel CLAUDE.md cliente

---

## Regole

- MAI creare senza conferma esplicita
- Estrarre sempre i dati dal PDF — non chiedere dati che si possono leggere
- Usare SEMPRE curl per Airtable — non usare il connettore MCP Airtable
- Caricare PDF su Drive PRIMA di creare il record su Airtable
- Cartella Drive: Fatture/[slug-cliente]/
- Collegare sempre il campo Users — senza questo la fattura non e visibile su Softr
- Non modificare mai record esistenti — solo creazione
