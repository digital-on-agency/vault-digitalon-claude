---
name: aggiorna-knowledge
description: Gestisce la knowledge base in knowledge/. Aggiunge nuovi tool/categorie, aggiorna contenuto esistente, verifica accuratezza via web search, review proattiva singola o bulk. Capisce dal contesto se aggiungere o aggiornare.
allowed-tools: bash, read, write, edit, glob, web_search
---

# Skill: aggiorna-knowledge

## Obiettivo

Mantenere la knowledge base in `knowledge/` completa e aggiornata: aggiungere nuova conoscenza, aggiornare contenuto esistente, rimuovere informazioni obsolete.

## Comportamento

Semi-autonomo — classifica, decide e agisce autonomamente. Chiede conferma all'utente solo se:

- La categoria di destinazione è ambigua o nessuna esistente sembra adatta
- Non è chiaro se creare un nuovo file o integrare in uno esistente
- Non è chiaro se aggiungere contenuto nuovo o sostituire contenuto esistente
- C'è dubbio su se un'informazione è obsoleta o ancora valida
- La modifica comporta la rimozione di una sezione intera

## Come riceve la conoscenza

- **Da prompt**: l'utente incolla direttamente contenuto o descrizione
- **Da inbox/**: legge i file in inbox/ e li processa
- **Da review**: l'utente chiede di verificare/rinfrescare un file o una categoria

## Struttura knowledge/

Prima di qualsiasi operazione, leggi sempre la struttura attuale con:

```bash
ls -R ~/vault-digitalon/knowledge/
```

Non affidarti alla struttura scritta in questo file — la struttura reale sul filesystem è quella autoritativa.

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

## Logica decisionale

Determina autonomamente dal contesto quale azione serve:

1. **Creare nuova directory + file** → l'argomento non rientra in nessuna categoria esistente
2. **Creare nuovo file in categoria esistente** → il tool non esiste ma la categoria sì
3. **Aggiungere a file esistente** → il tool esiste ma la sezione/informazione è nuova
4. **Aggiornare contenuto esistente** → il tool esiste e l'informazione aggiorna/sostituisce contenuto presente
5. **Review proattiva** → l'utente chiede esplicitamente di verificare/rinfrescare

## Processo

### Preparazione (sempre)

1. Leggi la struttura attuale con `ls -R ~/vault-digitalon/knowledge/`
2. Identifica il file o i file coinvolti
3. Se il file esiste, leggilo per intero prima di qualsiasi modifica

### Creare nuova directory + file

1. Proponi il nome della nuova directory all'utente e chiedi conferma
2. Crea la directory in `knowledge/`
3. Crea il nuovo file con struttura standard
4. Popola solo le sezioni per cui esiste contenuto
5. Aggiorna la data in cima al file
6. Commit: `knowledge: aggiunto [tool] in [nuova-categoria]`

### Creare nuovo file in categoria esistente

1. Se la categoria è ambigua, chiedi all'utente
2. Crea il file con struttura standard
3. Popola solo le sezioni per cui esiste contenuto
4. Aggiorna la data in cima al file
5. Commit: `knowledge: aggiunto [tool] in [categoria]`

### Aggiungere a file esistente

1. Leggi il file esistente
2. Identifica la sezione appropriata
3. Aggiungi il nuovo contenuto nella sezione corretta
4. Riorganizza la sezione se necessario per mantenere coerenza
5. Aggiorna la data in cima al file
6. Commit: `knowledge: aggiornato [tool] - aggiunta [descrizione]`

### Aggiornare contenuto esistente

1. Leggi il file esistente
2. Identifica le sezioni impattate
3. Aggiorna il contenuto, preservando la struttura del file
4. Se l'informazione rende obsoleto contenuto esistente, rimuovilo o segnalo come deprecato
5. Aggiungi numeri di versione dove rilevante (es. `React 19`, `Node.js 22 LTS`)
6. Aggiorna la data in cima al file
7. Commit: `knowledge: aggiornato [tool] - [cosa è cambiato]`

### Review proattiva (singolo file)

1. Leggi il file e identifica elementi potenzialmente datati: versioni, link, configurazioni, workflow
2. Cerca online la versione/stato corrente per ogni elemento dubbio
3. Produci un riepilogo delle differenze trovate e mostralo all'utente
4. Applica solo le modifiche confermate
5. Aggiorna la data in cima al file
6. Commit: `knowledge: aggiornato [tool] - review YYYY-MM-DD`

### Review bulk (categoria o tutto knowledge/)

1. Elenca i file da revisionare
2. Ordina per data di ultimo aggiornamento (più vecchi prima)
3. Per ogni file, esegui il processo di review proattiva
4. Tra un file e l'altro, mostra progresso: `[N/totale] Completato: [tool]. Prossimo: [tool]`
5. Al termine, mostra riepilogo complessivo delle modifiche
6. Commit unico per categoria: `knowledge: review [categoria] - YYYY-MM-DD`

### Conoscenza che riguarda più tool

1. Identifica il file principale (il tool più rilevante)
2. Aggiungi il contenuto nel file principale
3. Aggiungi in cima alla sezione: `<!-- integrazione con [altro-tool] -->`
4. Aggiungi in fondo alla sezione: `Vedi anche: knowledge/[categoria]/[altro-tool].md`
5. Commit: `knowledge: aggiornato [tool-principale] (integrazione con [altro-tool])`

## Regole di aggiornamento

- **Preserva la struttura**: non riorganizzare sezioni a meno che non sia necessario per coerenza
- **Non eliminare conoscenza valida**: se un'informazione è ancora corretta, lasciala
- **Segna le deprecazioni**: se un tool/API/metodo è deprecato, segnalo con `⚠️ Deprecato da [versione/data]` e indica l'alternativa
- **Versioni esplicite**: quando aggiorni informazioni legate a una versione, specifica sempre quale (es. `React 19`, `Stripe API 2024-12-18.acacia`)
- **Link rotti**: cerca il nuovo URL o rimuovi il link segnalando la rimozione

## Ricerca online

- Cerca sempre la versione più recente e aggiornata
- Fonte primaria: documentazione ufficiale
- Non aggiungere informazioni su API, librerie o tool deprecati senza segnalarli come tali
- Verifica changelog e release notes per identificare breaking changes
- Specifica sempre la versione a cui si riferisce il contenuto quando rilevante

## Output atteso

- File knowledge creato, aggiornato o verificato
- Struttura del file mantenuta coerente
- Data di ultimo aggiornamento corretta
- Commit pushato con messaggio descrittivo

## Fuori scope

- Modificare file di clienti o agency
- Salvare informazioni specifiche di un cliente (vanno in clients/)
- Aggiornare MEMORY.md
