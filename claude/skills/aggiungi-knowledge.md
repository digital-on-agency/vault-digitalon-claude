---
name: aggiungi-knowledge
description: Aggiunge nuova conoscenza operativa riutilizzabile alla cartella knowledge/. Semi-autonomo — classifica autonomamente, chiede conferma solo se categoria o posizionamento è ambiguo.
allowed-tools: bash, read, write, edit, glob, web_search
---

# Skill: aggiungi-knowledge

## Obiettivo

Salvare conoscenza operativa riutilizzabile nel posto giusto dentro `knowledge/`, mantenendo la struttura esistente e i file aggiornati.

## Comportamento

Semi-autonomo — classifica e agisce autonomamente. Chiede conferma all'utente solo se:

- La categoria o il file di destinazione è ambiguo
- Non è chiaro se creare un nuovo file o integrare in uno esistente
- La conoscenza riguarda un tool non ancora presente in knowledge/

## Come riceve la conoscenza

- **Da prompt**: l'utente incolla direttamente il contenuto o la descrizione
- **Da inbox/**: la skill legge i file presenti in inbox/ e li processa

## Struttura knowledge/

Prima di classificare qualsiasi contenuto, leggi sempre la struttura attuale con:

```bash
ls -R ~/vault-digitalon/knowledge/
```

Non affidarti alla struttura scritta in questo file — potrebbe essere cambiata. La struttura reale sul filesystem è quella autoritativa.

La struttura attuale al momento della creazione di questa skill era:

```
knowledge/
├── analytics/         (google-analytics, google-tag-manager, meta-pixel)
├── advertising/       (google-ads)
├── web-development/   (react, expressjs, linux-server, wordpress)
├── automazioni/       (make)
├── strumenti-dev/     (bash-terminal, git, cursor, markdown, obsidian)
├── api-integrazioni/  (stripe, google-wallet, apple-wallet)
├── web-design/        (landing-page, directory-website)
└── support-tools/     (scraper, pdf-generator)
```

Questa è solo una reference storica, non la fonte di verità.

## Struttura standard di ogni file

```markdown
<!-- ultimo aggiornamento: YYYY-MM-DD -->

# [Nome Tool]

## Overview

## Setup

## Workflow

## Configurazioni standard

## Errori comuni

## Note e benchmark
```

Solo le sezioni per cui esiste contenuto reale.

## Processo

### Se il tool esiste già in knowledge/

1. Leggi la struttura attuale con ls -R
2. Leggi il file esistente
3. Identifica la sezione appropriata
4. Aggiungi il nuovo contenuto nella sezione corretta
5. Riorganizza il file se necessario per mantenere coerenza e leggibilità
6. Aggiorna la data in cima al file
7. Commit con messaggio `knowledge: aggiornato [tool] - [descrizione]`

### Se il tool non esiste ancora

1. Leggi la struttura attuale con ls -R
2. Determina la categoria appropriata
3. Se categoria ambigua: chiedi all'utente
4. Crea nuovo file con struttura standard
5. Popola solo le sezioni per cui esiste contenuto
6. Aggiorna la data
7. Commit con messaggio `knowledge: aggiunto [tool] in [categoria]`

### Se la conoscenza riguarda più tool

1. Identifica il file principale (il tool più rilevante o più completo per quell'argomento)
2. Aggiungi il contenuto nel file principale
3. Aggiungi in cima alla sezione:
   `<!-- integrazione con [altro-tool] -->`
4. Aggiungi in fondo alla sezione:
   `Vedi anche: knowledge/[categoria]/[altro-tool].md`
5. Commit con messaggio `knowledge: aggiunto [argomento] in [tool-principale] (integrazione con [altro-tool])`

## Ricerca online

Se durante l'aggiunta è necessario cercare informazioni online:

- Cerca sempre la versione più recente e aggiornata
- Non aggiungere mai informazioni su API, librerie o tool deprecati
- Verifica che la documentazione sia ufficiale o affidabile
- Specifica sempre la versione a cui si riferisce il contenuto quando rilevante

## Output atteso

- File knowledge creato o aggiornato
- Struttura del file mantenuta coerente
- Commit pushato

## Fuori scope

- Modificare file di clienti o agency
- Salvare informazioni specifiche di un cliente (vanno in clients/)
- Aggiornare MEMORY.md
