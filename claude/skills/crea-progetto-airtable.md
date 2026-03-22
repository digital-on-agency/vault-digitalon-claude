---
name: crea-progetto-airtable
description: Crea un progetto su Airtable (DigitalOn App) e lo collega al cliente. Usa questa skill ogni volta che l'utente dice "crea progetto", "aggiungi progetto", "nuovo progetto su Airtable" o simili. Chiede sempre conferma prima di creare. Non crea mai in autonomia senza approvazione esplicita. Da usare insieme a crea-task-airtable per il flusso completo onboarding progetto.
---

# Crea Progetto su Airtable — Digital On Agency

Questa skill crea un record nella tabella Progetti/Servizi di Airtable, lo collega subito al cliente e aggiorna la tabella Progetti nel CLAUDE.md del cliente.

## Riferimenti Airtable (NON cercare, usa questi ID direttamente)

**Base:** `appHtzPRdNURXVvgo` — DigitalOn App

**Tabelle:**
- Progetti / Servizi: `tblylhAgyc47wEal2`
- Clienti / Business: `tbldMv8I4Wlo9s9BM`

**Campi Progetti / Servizi:**
- Nome: `fldhGdGhIRk8Op4uL`
- Business (link cliente): `fld1WwX7YCdV6l9U0`
- Tipo: `fld7eBDF9WFSvJomu`
- Stato: `flddScFxwGYbDEY8O`
- Website Domain: `fldpttTkufY08b67y`
- Users (Softr): `fldFRHwtKtTdVnQa0` (link a tabella Users `tblUZSu2Goo77rTf5`)

**Tabella Users:** `tblUZSu2Goo77rTf5`
- Nome: `fldgSde4cXK4QEzAh`
- Email: `fldbBaFVRaRtb4ivM`

**Valori Tipo validi:** Sito Web · CRM · Chatbot · Ads · SEO · Misto
**Valori Stato validi:** Da Iniziare · In Lavorazione · Attivo · Chiuso

---

## Processo

### Step 1 — Raccogli le informazioni

**Obbligatori:**
- Nome progetto
- Cliente (per trovare il record in Business)
- Tipo (Sito Web / CRM / Chatbot / Ads / SEO / Misto)

**Opzionali:**
- Stato (default: Da Iniziare)
- Dominio (es. legalepompei.it)
- Utente Softr da collegare (nome o email del referente cliente)

---

### Step 2 — Trova il Record ID del cliente

Usa `list_records_for_table` sulla tabella Clienti/Business (`tbldMv8I4Wlo9s9BM`) cercando per nome cliente.

---

### Step 3 — Mostra riepilogo e chiedi conferma

```
Sto per creare questo progetto su Airtable:

📁 Nome: [nome]
👤 Cliente: [nome cliente]
🏷️ Tipo: [tipo]
📊 Stato: [stato]
🌐 Dominio: [dominio o "—"]

Confermo?
```

Procedere SOLO dopo conferma esplicita.

---

### Step 4 — Crea e collega

1. Usa `create_records_for_table` sulla tabella Progetti/Servizi con i campi compilati
2. Includi subito il campo Business nel record: `["recXXXXXXXXXXXXXX"]`

---

### Step 6 — Aggiorna il vault

Dopo la creazione con successo:
1. Comunica: "Progetto creato su Airtable ✓ (ID: [record ID])"
2. Aggiorna la tabella `## Progetti` nel `CLAUDE.md` del cliente aggiungendo la riga del nuovo progetto
3. Salva il record ID Airtable nella nota del progetto — serve alla skill `crea-task-airtable`

---

## Regole

- Non creare mai senza conferma esplicita
- Se il cliente non viene trovato su Airtable, segnalarlo e non procedere
- Non lasciare mai un progetto scollegato dal cliente — il campo Business va compilato nella stessa chiamata di creazione
- Dopo la creazione, suggerire all'utente di usare `crea-task-airtable` per aggiungere i primi task
