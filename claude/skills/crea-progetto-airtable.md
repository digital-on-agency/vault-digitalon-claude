---
name: crea-progetto-airtable
description: Crea un progetto su Airtable (DigitalOn App) e lo collega al cliente. Usa questa skill ogni volta che l'utente dice "crea progetto", "aggiungi progetto", "nuovo progetto su Airtable" o simili. Chiede sempre conferma prima di creare. Non crea mai in autonomia senza approvazione esplicita. Da usare insieme a crea-task-airtable per il flusso completo onboarding progetto.
---

# Crea Progetto su Airtable — Digital On Agency

Questa skill crea un record nella tabella Progetti/Servizi di Airtable, lo collega subito al cliente e aggiorna il CLAUDE.md del cliente.

## Riferimenti Airtable (NON cercare, usa questi ID direttamente)

**Base:** appHtzPRdNURXVvgo — DigitalOn App

**Tabelle:**
- Progetti / Servizi: tblylhAgyc47wEal2
- Clienti / Business: tbldMv8I4Wlo9s9BM

**Campi Progetti / Servizi:**
- Nome: fldhGdGhIRk8Op4uL
- Business (link cliente): fld1WwX7YCdV6l9U0
- Tipo: fld7eBDF9WFSvJomu
- Stato: flddScFxwGYbDEY8O
- Website Domain: fldpttTkufY08b67y

**Campi Clienti / Business:**
- Nome: fldu9MFlYRd2XQyuB

**Valori Tipo:** Sito Web · CRM · Chatbot · Ads · SEO · Misto
**Valori Stato:** Da Iniziare · In Lavorazione · Attivo · Chiuso

## Processo

### Step 1 — Raccogli le informazioni
**Obbligatori:** nome progetto, cliente, tipo
**Opzionali:** stato (default: Da Iniziare), dominio

### Step 2 — Trova il Record ID del cliente
Usa list_records_for_table su Clienti/Business (tbldMv8I4Wlo9s9BM) cercando per nome.
Se il cliente non esiste su Airtable: crearlo prima con create_records_for_table usando solo il campo Nome (fldu9MFlYRd2XQyuB).

### Step 3 — Mostra riepilogo e chiedi conferma
📁 Nome / 👤 Cliente / 🏷️ Tipo / 📊 Stato / 🌐 Dominio
Procedere SOLO dopo conferma esplicita.

### Step 4 — Crea e collega
Usa create_records_for_table su Progetti/Servizi includendo subito il campo Business: ["recXXXXXXXXXXXXXX"]
Non creare mai il progetto senza collegarlo al cliente nella stessa chiamata.

### Step 5 — Aggiorna il vault
1. Comunica: "Progetto creato su Airtable ✓ (ID: [record ID])"
2. Aggiorna tabella ## Progetti nel CLAUDE.md del cliente
3. Suggerisci di usare crea-task-airtable per aggiungere i primi task

## Regole
- Mai creare senza conferma esplicita
- Se cliente non trovato, crearlo prima di procedere
- Non lasciare mai un progetto scollegato dal cliente
- Non modificare mai record esistenti — solo creazione
- MAI eseguire operazioni su Airtable (create, update) senza conferma esplicita dell'utente nella stessa conversazione. Mostrare sempre il riepilogo e attendere "sì", "confermo" o simile. Se l'utente cambia argomento o non risponde: non fare nulla.
