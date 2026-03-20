# Memory — Routing Document

Ultimo aggiornamento: 2026-03-20

Questo file è l'indice centrale della memoria del vault. Max 200 righe.
Non scrivere contenuti qui — solo link e riferimenti sintetici.

## Clienti attivi

<!-- Formato: - [[clients/nome-cliente/CLAUDE.md]] — breve descrizione stato -->

## Progetti in corso

<!-- Formato: - [[clients/nome-cliente/projects/nome-progetto/CLAUDE.md]] — breve descrizione stato -->

## Stato infrastruttura

- **Server VPS** — Hostinger, hosting principale per i siti clienti
- **Claude Code** — CLI attiva sul vault, con hook git (task-start.sh, task-end.sh) per sincronizzazione automatica
- **SilverBullet** — notes.bravebaboon.com, interfaccia web per navigare e editare il vault
- **MCP attivi** — GitHub, Google Workspace (workspace-google), GA4 (Stape, token da riautenticare)

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
- `clients/_template/CLAUDE.md` — template onboarding nuovo cliente

## Note globali

<!-- Annotazioni trasversali che non rientrano nelle sezioni sopra -->
