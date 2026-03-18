# Istruzioni operative per Claude

## Come usare questo vault

### Lavorare su un progetto cliente

Quando inizi a lavorare su un progetto specifico, spostati nella directory del progetto. I CLAUDE.md si caricano automaticamente in gerarchia e ti danno il contesto giusto senza dover caricare tutto il vault.

### Aggiornare la memoria dopo una sessione

Al termine di ogni sessione di lavoro su un cliente o progetto:

1. Aggiorna il CLAUDE.md del progetto con lo stato attuale, decisioni prese, prossimi step
2. Se ci sono aggiornamenti trasversali al cliente (nuovo referente, cambiamento di accordi), aggiorna il CLAUDE.md del cliente
3. Non lasciare sezioni con informazioni superate — sovrascrivi, non accumulare

### Compilare sezioni DA COMPLETARE

Quando un CLAUDE.md contiene sezioni `<!-- DA COMPLETARE -->`, chiedere all'utente le informazioni mancanti prima di procedere con task che dipendono da quelle informazioni.

### Aggiungere nuovo contenuto al vault

- Nuovo cliente → segui @skills/client-onboarding.md
- Nuova competenza → segui @skills/new-competency-onboarding.md
- Non creare file o cartelle al di fuori della struttura definita senza indicazione esplicita

### Formato commit git

I commit automatici usano il formato `session: YYYY-MM-DD HH:MM`. Per commit manuali su azioni specifiche usare formato descrittivo: `onboarding: cliente X`, `knowledge: aggiunto GTM avanzato`, `fix: aggiornato stato progetto Y`.

## Hook git

- **Inizio task:** eseguire `bash ~/vault-digitalon/claude/hooks/task-start.sh`
- **Fine task:** generare un messaggio di commit nel formato definito nel memory agent ed eseguire `bash ~/vault-digitalon/claude/hooks/task-end.sh "messaggio"`
- Se `task-end.sh` restituisce errori, segnalarli senza bloccare il flusso di lavoro