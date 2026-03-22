# Istruzioni operative per Claude

## Struttura del vault

- `agency/` — identità, stack, workflow, tono e info commerciali di Digital On. File statici, mai modificare senza istruzione esplicita
- `clients/` — un sottofolder per cliente, ognuno con CLAUDE.md e projects/. Template in `_template/`
- `claude/` — agenti, skill, hook git. Infrastruttura Claude Code
- `daily-notes/` — note giornaliere, solo quando ci sono info rilevanti da conservare
- `inbox/` — area staging per materiale non ancora classificato
- `knowledge/` — conoscenza riutilizzabile, best practice, guide tecniche. Mai comprimere
- `memory/` — MEMORY.md (routing), patterns, decisions, preferences. Gestito dal memory agent
- `research/` — ricerche temporanee, da elaborare e poi eventualmente eliminare

## Prima di ogni task

1. Leggi `memory/MEMORY.md` per avere il contesto globale
2. Se trovi materiale in `inbox/`, processalo e classificalo nei posti giusti prima di iniziare il task
3. Carica i CLAUDE.md del cliente/progetto su cui lavorerai

## Memoria

Le regole complete sulla gestione della memoria sono in `claude/agents/memory-agent.md`. Quello è il documento di riferimento per: quando scrivere, dove scrivere, principio di conservazione, compressione automatica.

## Lavorare su un progetto cliente

Quando inizi a lavorare su un progetto specifico, spostati nella directory del progetto. I CLAUDE.md si caricano automaticamente in gerarchia e ti danno il contesto giusto senza dover caricare tutto il vault.

## Aggiornare la memoria dopo una sessione

Al termine di ogni sessione di lavoro su un cliente o progetto:

1. Aggiorna il CLAUDE.md del progetto con lo stato attuale, decisioni prese, prossimi step
2. Se ci sono aggiornamenti trasversali al cliente (nuovo referente, cambiamento di accordi), aggiorna il CLAUDE.md del cliente
3. Non lasciare sezioni con informazioni superate — riassumi il vecchio, aggiungi il nuovo

## Compilare sezioni DA COMPLETARE

Quando un CLAUDE.md contiene sezioni `<!-- DA COMPLETARE -->`, chiedere all'utente le informazioni mancanti prima di procedere con task che dipendono da quelle informazioni.

## Aggiungere nuovo contenuto al vault

- Nuovo cliente → segui @skills/onboarding-cliente.md
- Nuova competenza → segui @skills/aggiungi-knowledge.md
- Non creare file o cartelle al di fuori della struttura definita senza indicazione esplicita

## Formato commit git

I commit automatici usano il formato `session: YYYY-MM-DD HH:MM`. Per commit manuali su azioni specifiche usare formato descrittivo: `onboarding: cliente X`, `knowledge: aggiunto GTM avanzato`, `fix: aggiornato stato progetto Y`.

## Hook git

- **Inizio task:** eseguire `bash ~/vault-digitalon/claude/hooks/task-start.sh`
- **Fine task:** generare un messaggio di commit nel formato definito nel memory agent ed eseguire `bash ~/vault-digitalon/claude/hooks/task-end.sh "messaggio"`
- Se `task-end.sh` restituisce errori, segnalarli senza bloccare il flusso di lavoro
