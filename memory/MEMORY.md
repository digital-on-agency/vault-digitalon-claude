# Memory — Routing Document

Ultimo aggiornamento: 2026-03-22

Questo file è l'indice centrale della memoria del vault. Max 200 righe.
Non scrivere contenuti qui — solo link e riferimenti sintetici.

## Clienti attivi

- [[clients/studio-legale-pompei/CLAUDE.md]] — SEO retainer 12 mesi, referente Michele, sito Webflow legalepompei.it

## Progetti in corso

- [[clients/studio-legale-pompei/projects/seo-legalepompei/CLAUDE.md]] — SEO legalepompei.it, Fase 1 fix tecnici, 8 task aperti entro 2026-03-31

## Stato infrastruttura

- **Server VPS** — Hostinger, hosting principale per i siti clienti
- **Claude Code** — CLI attiva sul vault, con hook git (task-start.sh, task-end.sh) per sincronizzazione automatica
- **SilverBullet** — notes.bravebaboon.com, interfaccia web per navigare e editare il vault
- **MCP attivi** — GitHub, Google Workspace (workspace-google, workspace-trovapulizie — da verificare autenticazione), GA4 (Stape, token da riautenticare)

## File importanti

- `CLAUDE.md` — istruzioni operative root, struttura vault, regole pre-task
- `claude/agents/memory-agent.md` — regole complete gestione memoria, conservazione, compressione
- `claude/hooks/task-start.sh` — git pull all'inizio di ogni task
- `claude/hooks/task-end.sh` — git add + commit + push a fine task
- `agency/identity.md` — chi è Digital On, team, aree di servizio
- `agency/stack.md` — stack tecnologico per tipo di progetto
- `agency/commercial.md` — modello pricing e documento commerciale
- `memory/preferences.md` — preferenze comunicazione trasversali (lingua, tono per tipo contenuto)
- `memory/patterns.md` — pattern operativi riutilizzabili
- `memory/decisions.md` — decisioni globali non legate a singolo cliente
- `clients/_template/CLAUDE.md` — template cliente con identità, comunicazione, ecosistema tecnico, progetti e storico
- `clients/_template/log.md` — template log attività per report mensili portale Softr
- `clients/_template/calls/` — template riassunti call con action item
- `clients/_template/projects/{sito-web,crm,chatbot,ads,seo}/CLAUDE.md` — template progetto per tipo con sezioni specifiche
- `claude/skills/client-onboarding.md` — skill onboarding nuovo cliente (raccolta info, creazione struttura, commit)
- `claude/agents/memory-manager.md` — sub-agent per gestione memoria, invoca le skill appropriate
- `claude/compression-log.md` — log e contatore compressioni automatiche

## Note globali

<!-- Annotazioni trasversali che non rientrano nelle sezioni sopra -->
