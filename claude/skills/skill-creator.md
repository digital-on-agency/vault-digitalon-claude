---
name: Skill Creator
description: Crea o aggiorna una skill nel vault di Digital On. Usare quando si chiede di "creare una skill", "aggiungere una skill", "scrivere una skill per X" o "aggiornare la skill Y". Guida la raccolta dei requisiti, mostra la bozza e chiede conferma prima di scrivere.
---

# Skill Creator

## Obiettivo
Creare una nuova skill nel vault seguendo il formato standard Anthropic, mostrandola all'utente per approvazione esplicita prima di salvarla.

## Regole fondamentali
- **Mai scrivere nel vault senza approvazione esplicita dell'utente**
- Mostrare sempre la bozza completa in chat prima di salvare
- Le skill devono essere generiche e riutilizzabili — nessun dato specifico di cliente
- Dati cliente vanno in `clients/[cliente]/CLAUDE.md`, non nelle skill
- Chiedere sempre "Posso salvare nel vault?" prima di scrivere

## Processo

### Step 1 — Raccogli i requisiti
Prima di scrivere qualsiasi cosa, chiedere:
- Qual è il task specifico e ripetibile che la skill deve risolvere?
- Quando deve essere invocata? (trigger precisi)
- Quali tool MCP o risorse servono?
- Ci sono esempi di input/output attesi?

### Step 2 — Scrivi la bozza
Struttura obbligatoria (formato Anthropic):

```
---
name: Nome Skill (max 64 caratteri)
description: Descrizione precisa di cosa fa e quando usarla. Includere verbi d'azione e trigger espliciti. (max 200 caratteri)
allowed-tools: [lista tool necessari]
---

# [Nome Skill]

## Obiettivo
Una riga: cosa produce come output finale.

## Prerequisiti
- Prerequisito 1
- Prerequisito 2

## Processo
1. Azione imperativa concreta
2. Azione imperativa concreta
...

## Output atteso
Descrizione precisa di file prodotti, formato, dove vengono salvati.

## Fuori scope
- Caso X (usa invece: [altra skill])
- Caso Y
```

### Step 3 — Mostra e chiedi approvazione
Presentare la bozza completa in chat con:
- Spiegazione delle scelte fatte
- Eventuali dubbi o alternative
- Domanda esplicita: "Posso salvare nel vault?"

### Step 4 — Salva solo dopo ok esplicito
Path: `claude/skills/[nome-kebab-case].md`

Dopo aver salvato, confermare all'utente cosa è stato scritto e dove.

## Checklist qualità prima di proporre
- [ ] La skill risolve un task specifico e ripetibile?
- [ ] La description è chiara su QUANDO invocarla (max 200 char)?
- [ ] Il processo è scritto con verbi imperativi concreti?
- [ ] Nessun dato cliente hardcoded?
- [ ] È chiaro cosa NON fa la skill (fuori scope)?
- [ ] La skill è generica e riutilizzabile per qualsiasi cliente?

## Fuori scope
- Modificare skill esistenti senza mostrare diff e chiedere conferma
- Creare skill con dati specifici di cliente (vanno in `clients/`)
- Scrivere nel vault senza approvazione esplicita
- Creare skill che sovrapponendosi a skill già esistenti (verificare prima con `list_files claude/skills/`)
