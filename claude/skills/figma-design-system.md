---
name: figma-design-system
description: Crea o aggiorna un design system base su Figma per un cliente. Usare quando si chiede di "creare il design system", "impostare colori/font su Figma", "creare componenti base Figma" o "preparare le schermate per il video". Produce: pagina Styles con colori e tipografia, componenti base (button, card, badge, input, navbar), frame schermate pronte per animazione.
allowed-tools: Figma MCP
---

# Skill: figma-design-system

## Obiettivo

Creare un design system base su Figma partendo dall'identità visiva del cliente, con stili, componenti e frame schermate pronti per essere animati o consegnati a un freelancer.

## Prerequisiti

- Connettore Figma MCP attivo
- Identità visiva del cliente disponibile (colori primari, font, nome app)
- Eventuale file Figma esistente (se assente, si crea da zero)

## Processo

### Step 1 — Ricognizione

1. Usa `Figma:whoami` per verificare che l'autenticazione sia attiva.
2. Se l'utente ha fornito un link Figma, usa `Figma:get_metadata` per leggere il file esistente.
3. Se non esiste un file, usa `Figma:create_new_file` con nome `[Cliente] — Design System`.
4. Leggi il CLAUDE.md del cliente nel vault per estrarre: colori, font, nome app, stack.

### Step 2 — Definisci gli stili (Styles)

Crea una pagina chiamata `Styles` nel file Figma con:

**Colori** — organizzati in gruppi:
- `Primary/500` — colore principale brand
- `Primary/100`, `Primary/900` — varianti chiare/scure
- `Neutral/50`, `Neutral/200`, `Neutral/600`, `Neutral/900` — grigi
- `Success/500`, `Warning/500`, `Error/500` — semantici
- `Background/Primary`, `Background/Secondary` — sfondi

**Tipografia** — stili testo:
- `Heading/H1` — 28px, 500
- `Heading/H2` — 22px, 500
- `Heading/H3` — 18px, 500
- `Body/Regular` — 15px, 400
- `Body/Small` — 13px, 400
- `Label/Default` — 11px, 500, uppercase, letter-spacing 0.5px
- `Code/Mono` — 13px, monospace

### Step 3 — Crea i componenti base

Crea una pagina chiamata `Components` con i seguenti componenti. Ogni componente deve avere varianti (states/sizes dove indicato):

**Button**
- Varianti: `Primary`, `Secondary`, `Ghost`
- Size: `SM` (32px), `MD` (40px), `LG` (48px)
- States: `Default`, `Hover`, `Disabled`

**Badge / Chip**
- Varianti: `Default`, `Success`, `Warning`, `Error`, `Info`
- Con e senza icona dot

**Input**
- States: `Default`, `Focus`, `Error`, `Disabled`
- Con label sopra e helper text sotto

**Card**
- Varianti: `Default` (border), `Elevated` (shadow leggero), `Filled` (bg secondario)

**Avatar**
- Size: `SM` (28px), `MD` (40px), `LG` (56px)
- Con iniziali testo

**Bottom Navigation Bar**
- 4 tab con icone e label
- State: `Active`, `Inactive`

**AI Chat Bubble**
- Bubble assistant (colore primario light)
- Bubble utente (neutro)

### Step 4 — Crea i frame schermate

Crea una pagina chiamata `Screens — [nome progetto]` con frame in formato **Mobile** (390×844, iPhone 14).

Per ogni schermata del progetto corrente (es. video demo trovapulizie):

| Frame | Contenuto |
|---|---|
| `01 — Home / Dashboard` | Saluto, AI bubble, lista lavori del giorno |
| `02 — Matchmaking AI` | Lista cleaner con score di compatibilità, barra match, tag preferenze |
| `03 — Assistant + Reminder` | Chat bubble AI, lista reminder pronti da inviare, CTA "Invia tutti" |
| `04 — Checklist lavoro` | Checklist contestuale, nota allergie/preferenze cliente |
| `05 — Riepilogo giornata` | Metric cards guadagni, lavori completati, recensioni |

Usa gli stili e componenti creati negli step precedenti.

### Step 5 — Naming e organizzazione

- Tutti i layer nominati in modo descrittivo (no "Rectangle 23")
- Componenti con Auto Layout attivo
- Raggruppare i frame per sezione con section labels
- Aggiungere una pagina `Cover` con nome progetto, data, versione

### Step 6 — Salva nel vault

Al termine, salva nel vault il link del file Figma:

```
clients/[cliente]/projects/[progetto]/CLAUDE.md
```

Aggiungere nella sezione "Ecosistema tecnico" o "Note operative":
```
**Figma Design System**: [link file Figma] — creato YYYY-MM-DD
```

## Output atteso

- File Figma con 4 pagine: `Cover`, `Styles`, `Components`, `Screens — [progetto]`
- Stili colori e tipografia definiti e applicati
- Componenti base con varianti e Auto Layout
- Frame schermate (almeno 5) pronti per animazione o consegna freelancer
- Link file salvato nel CLAUDE.md del progetto

## Note operative

- Se il cliente ha già un brand definito (es. palette Figma esistente), leggi prima i colori dal file esistente invece di crearne di nuovi
- Per Trovapulizie: colore primario `#534AB7` (purple), font system default (SF Pro / Inter)
- I frame schermate devono rispecchiare lo storyboard approvato — non inventare schermate non pianificate
- Dopo ogni step complesso, conferma all'utente prima di procedere al successivo

## Fuori scope

- Progettazione di flussi UX complessi o wireframe navigabili (fuori scope, richiede briefing dedicato)
- Export asset per sviluppatori (usa `Figma:get_design_context` separatamente)
- Animazioni Figma (Protopie/After Effects per quello)
