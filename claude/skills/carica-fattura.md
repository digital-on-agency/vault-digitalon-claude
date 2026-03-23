---
name: carica-fattura
description: Carica una fattura PDF su Google Drive e crea il record nella tabella Pagamenti di Airtable, collegandolo al cliente giusto e rendendolo visibile sul portale Softr. Usa questa skill ogni volta che l'utente dice "carica fattura", "aggiungi pagamento", "registra fattura", "nuova fattura" o simili. Chiede sempre conferma prima di creare.
---

# Carica Fattura — Digital On Agency

Questa skill carica il PDF della fattura su Google Drive, crea il record su Airtable nella tabella Pagamenti e lo collega al cliente e all'utente giusto per il filtro Softr.

## Riferimenti Airtable

**Base:** `appHtzPRdNURXVvgo` — DigitalOn App

**Tabella Pagamenti:** `tblALppB73JC9g8Lh`
- Nome: `fldkFAX4ozpFB4Qkk`
- Importo: `fldtPZPPxZEUlO1bl` (currency)
- Data Emissione: `fld7dqatZMmqdP5SC` (YYYY-MM-DD)
- Data Pagamento: `fldgeStgEoJCA5q1O` (YYYY-MM-DD — opzionale)
- Stato: `fldbrV6Gc3ZUGKOt3`
- Fattura: `fldUJvh4k37e8hOQT` (attachment — URL pubblico)
- Metodo di Pagamento: `fldMlClLOOhvWCXfi`
- Cliente: `fldA9qFTOwhaUxQBi` (link a Clienti/Business)
- Progetto: `fldTAPKBWEIG1RjtN` (link a Progetti/Servizi)
- Users: `fld3sk1hDxOnLzZMf` (link a Users — per filtro Softr)

**Valori Stato:** Da pagare · Pagata
**Valori Metodo di Pagamento:** Bonifico · Cash · Link Stripe · PayPal

**Tabella Clienti/Business:** `tbldMv8I4Wlo9s9BM`
**Tabella Progetti/Servizi:** `tblylhAgyc47wEal2`
**Tabella Users:** `tblUZSu2Goo77rTf5`

---

## Processo

### Step 1 — Raccogli le informazioni

**Obbligatori:**
- PDF fattura (allegato o path su Discord)
- Cliente
- Importo (€)
- Data emissione (YYYY-MM-DD)

**Opzionali:**
- Progetto specifico
- Metodo di pagamento (default: Link Stripe)
- Stato (default: Da saldare)
- Data pagamento (solo se già saldata)

---

### Step 2 — Carica il PDF su Google Drive

Usa il connettore Google Drive (`workspace-digitalon`) per caricare il PDF in:
```
Fatture/[slug-cliente]/[YYYY-MM]-fattura-[cliente].pdf
```

Dopo l'upload ottieni il link pubblico del file (permesso: chiunque con il link può visualizzare).

---

### Step 3 — Trova i Record ID

1. Cerca il cliente in Clienti/Business (`tbldMv8I4Wlo9s9BM`) per nome
2. Se specificato, cerca il progetto in Progetti/Servizi (`tblylhAgyc47wEal2`) per nome
3. Cerca l'utente in Users (`tblUZSu2Goo77rTf5`) per email — serve per il filtro Softr

---

### Step 4 — Mostra riepilogo e chiedi conferma

```
Sto per creare questo record su Airtable:

📄 Nome: Fattura [mese] [anno] — [cliente]
👤 Cliente: [nome]
📁 Progetto: [nome o "—"]
💶 Importo: €[importo]
📅 Data emissione: [data]
💳 Metodo: [metodo]
📊 Stato: [stato]
🔗 PDF: [link Drive]

Confermo?
```

Procedere SOLO dopo conferma esplicita.

---

### Step 5 — Crea il record su Airtable

Usa `create_records_for_table` sulla tabella Pagamenti con tutti i campi compilati.

Per il campo **Fattura** (attachment), passa il link pubblico Drive nel formato:
```json
[{"url": "https://drive.google.com/...", "filename": "fattura-[cliente]-[mese].pdf"}]
```

Per i campi `multipleRecordLinks` usa: `["recXXXXXXXXXXXXXX"]`

---

### Step 6 — Aggiorna lo storico

Dopo la creazione:
1. Comunica: "Fattura caricata su Airtable ✓ — visibile sul portale per [cliente]"
2. Aggiorna `## Storico attività` nel CLAUDE.md cliente:
   `YYYY-MM-DD — fattura €[importo] caricata su portale — stato: [stato]`

---

## Regole

- MAI creare senza conferma esplicita
- Il PDF deve essere caricato su Drive PRIMA di creare il record su Airtable
- La cartella Drive deve seguire il pattern `Fatture/[slug-cliente]/`
- Se il cliente non esiste su Airtable, segnalarlo e non procedere
- Collegare sempre il campo Users all'utente del cliente — senza questo la fattura non è visibile su Softr
- Non modificare mai record esistenti con questa skill — solo creazione
