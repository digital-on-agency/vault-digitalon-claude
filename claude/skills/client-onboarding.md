---
name: client-onboarding
description: Crea la struttura completa per un nuovo cliente nel vault E su Airtable. Usa questa skill ogni volta che si menziona l'aggiunta di un nuovo cliente, un onboarding, o la creazione della scheda cliente — anche se la richiesta è vaga come "aggiungi cliente X" o "crea la cartella per Y". La skill guida la raccolta delle informazioni, crea tutti i file necessari nel vault e crea il cliente e i progetti su Airtable.
---

# Client Onboarding — Digital On Agency

Questa skill crea la struttura completa per un nuovo cliente nel vault a partire dal template in `clients/_template/`, e lo sincronizza subito su Airtable.

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

## Step 5 — Crea il cliente su Airtable

1. Usa `Airtable:create_records_for_table` sulla tabella Clienti/Business (`tbldMv8I4Wlo9s9BM`)
2. Crea il record con il nome del cliente
3. Salva il Record ID restituito
4. Aggiorna il CLAUDE.md del cliente con il Record ID Airtable nella sezione Ecosistema tecnico:
   ```
   **Airtable Record ID (Business):** rec[XXXXXXXXXXXXXXXX]
   ```

## Step 6 — Crea i progetti su Airtable

Per ogni progetto attivo identificato nello Step 1:

1. Usa `Airtable:create_records_for_table` sulla tabella Progetti (`tblylhAgyc47wEal2`)
2. Crea il record con:
   - Nome progetto
   - Business: [Record ID cliente creato allo Step 5]
   - Tipo: tipo progetto
   - Stato: `Attivo` o `Da Iniziare`
3. Salva il Record ID restituito
4. Aggiorna la tabella `## Progetti` nel CLAUDE.md del cliente con il Record ID Airtable:
   ```
   | rec[XXXXXXXXXXXXXXXX] | Nome progetto | Tipo | Stato | path/progetto/ |
   ```

> ⚠️ Ogni progetto nel CLAUDE.md deve avere il suo Record ID Airtable — mai lasciare `<!-- DA COMPLETARE -->` per i progetti creati in questo step.

## Step 7 — Commit
```
git add clients/[slug]/
git commit -m "onboarding: [Nome Cliente]"
```
Non includere mai secrets.md (già in .gitignore)

## Regole
- Verifica che lo slug non esista già in `clients/`
- Non creare file fuori da `clients/[slug]/`
- Progetti interni (Global x Connect, Bid House, Trovapulizie) → stessa struttura clienti esterni
- Al termine comunica i campi DA COMPLETARE e i prossimi passi
- Il Record ID Airtable di cliente e progetti è obbligatorio — senza di esso resoconto-sessione non può collegare i task correttamente
