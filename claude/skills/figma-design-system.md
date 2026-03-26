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

## Knowledge base di riferimento

Prima di creare qualsiasi elemento, leggere i file pertinenti in `knowledge/ui-ux/`:

| File | Quando leggerlo |
|------|----------------|
| `design-system.md` | Sempre — token, scale, naming, sizing bottoni, componenti base |
| `componenti-ui.md` | Quando crei componenti — pattern card, form, table, navigation, modal, dashboard |
| `figma-to-code.md` | Per struttura file Figma, Auto Layout, Variables, naming layer |
| `responsive-design.md` | Quando crei frame a più breakpoint |
| `accessibilita.md` | Sempre — contrasti, focus state, ARIA, target area |
| `ux-patterns.md` | Quando crei schermate — empty state, loading, error handling, onboarding |

I valori nella knowledge base hanno priorità sui default indicati in questa skill. Se la knowledge base specifica un range di altezza bottoni (44-72px), una scala tipografica o regole di contrasto, usare quelli.

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

Leggi `knowledge/ui-ux/design-system.md` per la struttura completa dei token (colori, tipografia, spacing, shadow, border radius). Usa quei valori come base e adattali ai colori e font del cliente.

Crea una pagina chiamata `Styles` nel file Figma con:

**Colori** — organizzati in gruppi seguendo la struttura token della knowledge base:
- `Primary/500` — colore principale brand (da tokens.md del cliente)
- `Primary/100`, `Primary/900` — varianti chiare/scure
- `Neutral/50` → `Neutral/900` — scala grigi
- `Success/500`, `Warning/500`, `Error/500` — semantici
- `Background/Primary`, `Background/Secondary`, `Surface` — sfondi e superfici

Verificare che tutti i colori rispettino i rapporti di contrasto WCAG AA (vedi `knowledge/ui-ux/accessibilita.md`): 4.5:1 per testo normale, 3:1 per testo grande e componenti UI.

**Tipografia** — usare la scala tipografica dalla knowledge base (`xs` 12px → `4xl` 36px). Stili testo da creare:
- `Heading/H1` — `4xl` (36px), semibold 600
- `Heading/H2` — `3xl` (30px), semibold 600
- `Heading/H3` — `2xl` (24px), semibold 600
- `Body/Regular` — `base` (16px), regular 400
- `Body/Small` — `sm` (14px), regular 400
- `Label/Default` — `xs` (12px), medium 500, uppercase, letter-spacing 0.5px

**Spacing** — scala base-4 dalla knowledge base (4, 8, 12, 16, 24, 32, 40, 48, 64px).

### Step 3 — Crea i componenti base

Crea una pagina chiamata `Components` con i seguenti componenti. Ogni componente deve avere varianti (states/sizes dove indicato):

Per ogni componente, fare riferimento a `knowledge/ui-ux/design-system.md` (sezione componenti base e Button) e `knowledge/ui-ux/componenti-ui.md` per i pattern dettagliati.

**Button** (vedi knowledge base per sizing e accessibilità)
- Varianti: `Primary` (fill), `Secondary` (outline), `Tertiary` (testo sottolineato), `Danger`
- Size: `SM` (36px, padding 8/16px), `MD` (44px, padding 12/24px), `LG` (52px, padding 16/32px)
- States: `Default`, `Hover`, `Focus` (con ring visibile), `Disabled`, `Loading`
- Regola padding: orizzontale = 2x verticale
- Target area minima 48x48px, spaziatura tra bottoni 16px

**Badge / Chip**
- Varianti: `Default`, `Success`, `Warning`, `Error`, `Info`
- Con e senza icona dot

**Input** (vedi knowledge base per pattern form)
- States: `Default`, `Focus`, `Error`, `Disabled`
- Con label sopra (mai placeholder-as-label) e helper text sotto
- Messaggi errore sotto il campo con icona

**Card** (vedi knowledge base per pattern card e interattività)
- Varianti: `Default` (border), `Elevated` (shadow leggero), `Interactive` (hover state con shadow rialzato)
- Padding interno: 16px (mobile) / 24px (desktop)
- Border radius: 8-12px

**Avatar**
- Size: `SM` (28px), `MD` (40px), `LG` (56px)
- Con iniziali testo come fallback

**Navigation** (vedi knowledge base per pattern navigazione)
- Bottom Navigation Bar: max 5 tab con icone e label, state `Active`/`Inactive`
- Sidebar: icona + label, collapsabile, gruppi con divider

**Modal / Dialog**
- Size: `SM`, `MD`, `LG`
- Con overlay scuro, close button, focus trap
- Bottone annulla a sinistra, conferma a destra

**Empty State**
- Illustrazione/icona + titolo + descrizione + CTA primaria
- Varianti: primo utilizzo, nessun risultato, filtri vuoti

**Loading**
- Skeleton screen (stessa forma del contenuto finale, animazione pulse)
- Spinner inline con testo

### Step 4 — Crea i frame schermate

Leggi `knowledge/ui-ux/ux-patterns.md` per i flussi UX (onboarding, search, checkout, error/empty/loading state) e `knowledge/ui-ux/responsive-design.md` per breakpoint e pattern adattivi.

Crea una pagina chiamata `Screens — [nome progetto]` con frame in formato **Mobile** (390×844, iPhone 14). Basati sullo storyboard approvato — non inventare schermate non pianificate.

Ogni schermata deve includere gli stati rilevanti dalla knowledge base: empty state, loading (skeleton), errore. Non progettare solo il caso "pieno di dati".

### Step 5 — Naming e organizzazione

Seguire le convenzioni di naming dalla knowledge base (`knowledge/ui-ux/design-system.md` sezione naming e `knowledge/ui-ux/figma-to-code.md` sezione preparazione Figma):

- Tutti i layer nominati in modo semantico (no "Rectangle 23", no "Frame 427")
- Token come Figma Variables (colori, spacing) — non solo stili locali
- Componenti con Auto Layout attivo su tutti gli elementi
- Varianti come Component Set
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

- **Leggi sempre la knowledge base prima** — `knowledge/ui-ux/` contiene le regole di design. Non inventare valori già definiti lì.
- **Leggi sempre tokens.md del cliente prima** — non reinventare colori o font già estratti
- **Non creare file duplicati** — verifica sempre se esiste già un file Figma
- I frame schermate devono rispecchiare lo storyboard approvato
- Dopo ogni step complesso, conferma all'utente prima di procedere al successivo
- Quando un valore nella knowledge base e uno nel tokens.md del cliente confliggono, il tokens.md del cliente ha priorità per colori e font; la knowledge base ha priorità per sizing, spacing e regole di accessibilità

## Fuori scope

- Estrazione design system da sito web (usa ui-designer + salva-design-system)
- Generazione UI/landing page (usa ui-ux-pro-max)
- Progettazione di flussi UX complessi o wireframe navigabili
- Export asset per sviluppatori (usa `Figma:get_design_context` separatamente)
- Animazioni Figma
