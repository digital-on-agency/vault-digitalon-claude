---

name: aggiorna-agency

description: Aggiorna le informazioni sull'agenzia Digital On. Guidato — chiede cosa aggiornare e il nuovo contenuto prima di modificare. Rispetta la struttura esistente di ogni file.

allowed-tools: bash, read, write, edit

---

# Skill: aggiorna-agency

## Obiettivo

Mantenere aggiornati i file in `agency/` con le informazioni correnti sull'agenzia, senza rompere la struttura esistente di nessun file.

## Comportamento

Guidato — chiede sempre cosa aggiornare e il nuovo contenuto prima di modificare.

## File disponibili e loro struttura

### agency/identity.md

Chi è Digital On: collettivo, team, servizi, posizionamento, acquisizione clienti.

### agency/commercial.md

Modello commerciale: pricing, canoni, formule per tipo di servizio, nomenclatura documenti.

### agency/stack.md

Strumenti e tecnologie per area: marketing/analytics, CRM/automazioni, siti web, gestionali, sviluppo.

### agency/tone.md

Tono e comunicazione: lingua, formalità, stile per contesto, priorità rispetto ai CLAUDE.md dei clienti.

### agency/workflow.md

Processi operativi: onboarding, project management, modello di lavoro. File parziale, in evoluzione.

## Processo

1. Chiedi: quale file aggiornare e cosa modificare

2. Leggi il file selezionato e mostra la sezione rilevante

3. Se la modifica aggiunge contenuto a una sezione esistente: integra senza sovrascrivere

4. Se la modifica aggiunge una nuova sezione: chiedi conferma della struttura proposta prima di procedere

5. Se la modifica impatta altri file: avvisa l'utente (non aggiornare autonomamente gli altri file)

6. Aggiorna la data di ultimo aggiornamento in cima al file (solo data, nessun commento)

7. Commit con messaggio `agency: aggiornato [nome-file] - [descrizione modifica]`

## Formato data ultimo aggiornamento

Ogni file agency/ deve avere in cima:

<!-- ultimo aggiornamento: YYYY-MM-DD -->

## Output atteso

- File agency aggiornato con nuova data

- Utente avvisato se ci sono impatti su altri file

- Commit pushato

## Fuori scope

- Modificare file agency senza conferma esplicita dell'utente

- Eliminare sezioni o contenuto esistente

- Aggiornare autonomamente più file in cascata
