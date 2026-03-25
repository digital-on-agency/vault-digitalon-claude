---
name: client-onboarding
description: Crea la struttura completa per un nuovo cliente nel vault E su Airtable. Usa questa skill ogni volta che si menziona l'aggiunta di un nuovo cliente, un onboarding, o la creazione della scheda cliente — anche se la richiesta è vaga come "aggiungi cliente X" o "crea la cartella per Y". La skill guida la raccolta delle informazioni, crea tutti i file necessari nel vault e sincronizza cliente e progetti su Airtable.
---

# Client Onboarding — Digital On Agency

Questa skill crea la struttura completa per un nuovo cliente nel vault a partire dal template in `clients/_template/`, e lo sincronizza su Airtable.

## Struttura vault
```
clients/[slug]/
├── CLAUDE.md
├── secrets.md (gitignored)
├── log.md
├── calls/
│   └── YYYY-MM-DD-[tema].md
└── projects/
    └── _template/
        └── CLAUDE.md
```

## Riferimenti Airtable
**Base:** `appHtzPRdNURXVvgo` — DigitalOn App
**Tabella Clienti/Business:** `tbldMv8I4Wlo9s9BM` — campo Nome: `fldu9MFlYRd2XQyuB`
**Tabella Progetti:** `tblylhAgyc47wEal2` — campo Nome: `fldhGdGhIRk8Op4uL`, Business: `fld1WwX7YCdV6l9U0`, Tipo: `fld7eBDF9WFSvJomu`, Stato: `flddScFxwGYbDEY8O`
**Valori Tipo progetto:** Sito Web · CRM · Chatbot · Ads · SEO · Misto
**Valori Stato progetto:** Da Iniziare · In Lavorazione · Attivo · Chiuso

---

## Step 1 — Raccogli info (prima di creare qualsiasi file)
**Base:** ragione sociale, slug, settore, dimensione, contratto, priorità
**Comunicazione:** referente, canale, frequenza, tono, note relazionali
**Tecnico (se disponibile):** domini, GA4, account Ads, repo, integrazioni
**Progetti attivi (se disponibile):** nome, tipo, stato

## Step 2 — Slug
Minuscolo, spazi→trattini, no caratteri speciali. "Acme S.r.l."→`acme`

## Step 3 — Crea la struttura nel vault

Esegui in ordine — NON usare cp -r sulla cartella template intera, copia solo i file necessari:
```bash
mkdir -p clients/[slug]
cp clients/_template/CLAUDE.md clients/[slug]/CLAUDE.md
cp clients/_template/log.md clients/[slug]/log.md
cp clients/_template/secrets.md clients/[slug]/secrets.md
mkdir -p clients/[slug]/calls
cp clients/_template/calls/YYYY-MM-DD-[tema].md clients/[slug]/calls/
mkdir -p clients/[slug]/projects/_template
cp clients/_template/projects/_template/CLAUDE.md clients/[slug]/projects/_template/CLAUDE.md
```

## Step 4 — Compila i file vault
**CLAUDE.md** — compila con le info raccolte. Campi mancanti → `<!-- DA COMPLETARE -->`
**log.md** — solo titolo: `# Log attività — [Nome Cliente]`
**secrets.md** — solo titolo: `# Accessi — [Nome Cliente]`
**calls/YYYY-MM-DD-[tema].md** — template invariato

## Step 5 — Cerca il cliente su Airtable

1. Cerca il cliente nella tabella Clienti/Business (`tbldMv8I4Wlo9s9BM`) per nome
2. Tre scenari possibili:

**✅ Cliente trovato**
→ Mostra all'utente: `"Ho trovato '[Nome]' su Airtable (ID: recXXX). Lo associo a questo cliente?"`
→ Se sì → salva il Record ID nel CLAUDE.md e procedi allo Step 6
→ Se no → chiedi quale record associare o se crearne uno nuovo

**❌ Cliente non trovato**
→ Chiedi all'utente: `"[Nome] non esiste ancora su Airtable. Lo creo ora o vuoi associarlo a un record esistente?"`
→ Se crea → usa `Airtable:create_records_for_table` con il nome del cliente → salva Record ID → procedi
→ Se associa → chiedi di cercare per nome alternativo e ripeti la ricerca

**⚠️ Più risultati trovati**
→ Mostra la lista e chiedi all'utente quale associare

3. Salva il Record ID nel CLAUDE.md nella sezione Ecosistema tecnico:
   ```
   **Airtable Record ID (Business):** rec[XXXXXXXXXXXXXXXX]
   ```

## Step 6 — Sincronizza i progetti su Airtable

Per ogni progetto attivo identificato nello Step 1, cerca prima se esiste già su Airtable:

1. Cerca il progetto nella tabella Progetti (`tblylhAgyc47wEal2`) per nome
2. Tre scenari:

**✅ Trovato**
→ Chiedi: `"Ho trovato '[Nome progetto]' su Airtable (ID: recXXX). Lo associo?"`
→ Se sì → salva il Record ID nel CLAUDE.md

**❌ Non trovato**
→ Chiedi: `"[Nome progetto] non esiste su Airtable. Lo creo ora?"`
→ Se sì → crea con: nome, Business (Record ID Step 5), Tipo, Stato
→ Salva il Record ID restituito

**Salta**
→ Se l'utente non vuole creare né associare → lascia `<!-- DA COMPLETARE -->` e segnala che resoconto-sessione non potrà collegare i task a questo progetto

3. Aggiorna la tabella `## Progetti` nel CLAUDE.md con il Record ID:
   ```
   | rec[XXXXXXXXXXXXXXXX] | Nome progetto | Tipo | Stato | path/progetto/ |
   ```

## Step 7 — Commit
```
git add clients/[slug]/
git commit -m "onboarding: [Nome Cliente]"
```
Non includere mai secrets.md (già in .gitignore)

## Regole
- Verifica che lo slug non esista già in `clients/`
- Non creare mai su Airtable senza conferma esplicita
- Non creare file fuori da `clients/[slug]/`
- Al termine comunica i campi DA COMPLETARE e avvisa se ci sono progetti senza Record ID Airtable
- Il Record ID Airtable di cliente e progetti è necessario per resoconto-sessione — segnalare sempre se mancante
