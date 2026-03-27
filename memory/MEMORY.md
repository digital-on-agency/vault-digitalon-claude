# Memory — Routing Document

Ultimo aggiornamento: 2026-03-23

Questo file è l'indice centrale della memoria del vault. Max 200 righe.
Non scrivere contenuti qui — solo link e riferimenti sintetici.

## Clienti attivi

→ Leggi sempre `clients/` direttamente per la lista clienti aggiornata.
Non elencare clienti qui — la directory `clients/` è la fonte di verità.

## Progetti in corso

→ Per i progetti attivi leggi `clients/[cliente]/CLAUDE.md` di ogni cliente.

## Stato infrastruttura

- **Server VPS** — Hostinger, hosting principale per i siti clienti
- **Claude Code** — CLI attiva sul vault, con hook git (task-start.sh, task-end.sh) per sincronizzazione automatica
- **SilverBullet** — notes.bravebaboon.com, interfaccia web per navigare e editare il vault
- **Vault MCP** — mcp.bravebaboon.com, connettore MCP per claude.ai browser
- **MCP attivi** — GitHub, Google Workspace (workspace-google, workspace-trovapulizie), GA4 (Stape, token da riautenticare), Airtable

## File importanti

- `CLAUDE.md` — istruzioni operative root, struttura vault, regole pre-task
- `claude/agents/memory-agent.md` — regole complete gestione memoria, conservazione, compressione
- `claude/agents/memory-manager.md` — sub-agent per gestione memoria, invoca le skill appropriate
- `claude/hooks/task-start.sh` — git pull all'inizio di ogni task
- `claude/hooks/task-end.sh` — git add + commit + push a fine task
- `claude/compression-log.md` — log e contatore compressioni automatiche
- `claude/scripts/notify-discord.sh` — invia notifiche nel canale #sistema Discord
- `claude/scripts/cron-manutenzione.sh` — script cron manutenzione vault (07:30 ora italiana)
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

## Decisioni architetturali clienti

- [Landing trovapulizie.it](../../../home/guido/.claude/projects/-opt-vault-digitalon/memory/project_landing_trovapulizie.md) — split subdomain trovapulizie.it (landing) + app.trovapulizie.it (SPA)

## Feedback operativi

- [Figma: mai rimuovere nodi](../../../home/guido/.claude/projects/-opt-vault-digitalon/memory/feedback_figma_no_cleanup.md) — non fare cleanup orfani su pagine Figma, rischio cancellare schermate esistenti

## Note globali

<!-- Annotazioni trasversali che non rientrano nelle sezioni sopra -->
