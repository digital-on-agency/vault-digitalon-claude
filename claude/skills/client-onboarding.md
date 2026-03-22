---
name: client-onboarding
description: Crea la struttura completa per un nuovo cliente nel vault. Usa questa skill ogni volta che si menziona l'aggiunta di un nuovo cliente, un onboarding, o la creazione della scheda cliente — anche se la richiesta è vaga come "aggiungi cliente X" o "crea la cartella per Y". La skill guida la raccolta delle informazioni, crea tutti i file necessari e prepara il commit.
---

# Client Onboarding — Digital On Agency

Questa skill crea la struttura completa per un nuovo cliente nel vault a partire dal template in `clients/_template/`.

## Struttura
clients/[slug]/
├── CLAUDE.md
├── secrets.md (gitignored)
├── log.md
├── calls/
│   └── YYYY-MM-DD-[tema].md
└── projects/
    └── _template/
        └── CLAUDE.md

## Step 1 — Raccogli info (prima di creare qualsiasi file)
**Base:** ragione sociale, slug, settore, dimensione, contratto, priorità
**Comunicazione:** referente, canale, frequenza, tono, note relazionali
**Tecnico (se disponibile):** domini, GA4, account Ads, repo, integrazioni
**Progetti attivi (se disponibile):** nome, tipo, stato

## Step 2 — Slug
Minuscolo, spazi→trattini, no caratteri speciali. "Acme S.r.l."→`acme`

## Step 3 — Crea struttura
`cp -r clients/_template clients/[slug]`

## Step 4 — Compila i file
**CLAUDE.md** — compila con le info raccolte. Campi mancanti → `<!-- DA COMPLETARE -->`
**log.md** — solo titolo: `# Log attività — [Nome Cliente]`
**secrets.md** — solo titolo: `# Accessi — [Nome Cliente]`
**calls/YYYY-MM-DD-[tema].md** — template invariato

## Step 5 — Commit
`git add clients/[slug]/`
`git commit -m "onboarding: [Nome Cliente]"`
Non includere mai secrets.md (già in .gitignore)

## Regole
- Verifica che lo slug non esista già in clients/
- Non creare file fuori da clients/[slug]/
- Progetti interni (Global x Connect, Bid House, Trovapulizie) → stessa struttura clienti esterni
- Al termine comunica i campi DA COMPLETARE e i prossimi passi
- Report mensile: Claude legge log.md, filtra per mese/categoria, produce tabella per Softr
