---
name: figma-design-system
description: Crea o aggiorna un design system su Figma per un cliente. Usare SOLO quando l'utente specifica esplicitamente "su Figma", "in Figma", "apri Figma", "crea il file Figma" o "aggiorna Figma". NON usare per estrazioni da sito, salvataggio token o generazione UI — per quello usare salva-design-system o ui-ux-pro-max. Produce: file Figma con pagine Styles, Components, Screens.
allowed-tools: Figma MCP
---

# Skill: figma-design-system

## Obiettivo

Creare un design system base su Figma partendo dall'identità visiva del cliente, con stili, componenti e frame schermate pronti per essere animati o consegnati a un freelancer.

## Prerequisiti

- Connettore Figma MCP attivo
- Identità visiva del cliente disponibile (colori primari, font, nome app)
- Eventuale file Figma esistente (se assente, si crea da zero)
- ⚠️ Questa skill si attiva SOLO se l'utente menziona esplicitamente Figma

## Processo

### Step 0 — Verifica stato attuale ⚠️ OBBLIGATORIO

Prima di toccare Figma, verifica cosa esiste già:

1. Leggi `clients/[cliente]/design-system/tokens.md` nel vault — se esiste, usalo come fonte primaria per colori e font. Non reinventare valori già estratti.
2. Controlla se esiste già un file Figma nel CLAUDE.md del cliente (sezione Ecosistema tecnico):
   - Se esiste un link Figma → usa `Figma:get_metadata` per leggere il file esistente
   - Mostra all'utente: `✅ File Figma esistente: [nome] — pagine presenti: [lista]`
   - Chiedi: **"Vuoi aggiornare il file esistente o crearne uno nuovo?"**
3. Se non esiste nulla → procedi con la creazione da zero
4. Non creare mai un file nuovo se ne esiste già uno senza conferma esplicita

### Step 1 — Ricognizione

1. Usa `Figma:whoami` per verificare che l'autenticazione sia attiva.
2. Se l'utente ha fornito un link Figma, usa `Figma:get_metadata` per leggere il file esistente.
3. Se non esiste un file, usa `Figma:create_new_file` con nome `[Cliente] — Design System`.
4. Leggi il CLAUDE.md del cliente nel vault per estrarre: colori, font, nome app, stack.
5. Se esiste `clients/[cliente]/design-system/tokens.md`, leggilo — è la fonte di verità per colori e font da usare in Figma.

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

Crea una pagina chiamata `Screens — [nome progetto]` con frame in formato **Mobile** (390×844, iPhone 14). Basati sullo storyboard approvato — non inventare schermate non pianificate.

### Step 5 — Naming e organizzazione

- Tutti i layer nominati in modo descrittivo (no "Rectangle 23")
- Componenti con Auto Layout attivo
- Raggruppare i frame per sezione con section labels
- Aggiungere una pagina `Cover` con nome progetto, data, versione

### Step 6 — Salva nel vault

Al termine, salva nel vault il link del file Figma nel `clients/[cliente]/CLAUDE.md`:

```markdown
**Figma Design System**: [link file Figma] — creato/aggiornato YYYY-MM-DD
```

Aggiorna anche il log:

```
| DS-XXX | YYYY-MM-DD | Design System | Creazione/aggiornamento file Figma | Strategia | X | Claude | Completato | |
```

## Output atteso

- File Figma con pagine: `Cover`, `Styles`, `Components`, `Screens — [progetto]`
- Stili colori e tipografia definiti e applicati (da tokens.md se disponibile)
- Componenti base con varianti e Auto Layout
- Link file salvato nel CLAUDE.md del progetto

## Note operative

- **Leggi sempre tokens.md prima** — non reinventare colori o font già estratti
- **Non creare file duplicati** — verifica sempre se esiste già un file Figma
- I frame schermate devono rispecchiare lo storyboard approvato
- Dopo ogni step complesso, conferma all'utente prima di procedere al successivo

## Fuori scope

- Estrazione design system da sito web (usa ui-designer + salva-design-system)
- Generazione UI/landing page (usa ui-ux-pro-max)
- Progettazione di flussi UX complessi o wireframe navigabili
- Export asset per sviluppatori (usa `Figma:get_design_context` separatamente)
- Animazioni Figma
