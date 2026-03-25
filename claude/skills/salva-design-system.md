---
name: salva-design-system
description: Salva il design system estratto di un cliente nel vault in formato strutturato. Usare quando si chiede di "salvare il design system", "salvare i token", "salvare colori e font di [cliente]", "mettere il design system nel vault", o dopo aver estratto un design system con ui-designer o qualsiasi altro tool. Produce un file tokens.md nella cartella design-system/ del cliente, e aggiorna il CLAUDE.md del cliente con un riferimento.
allowed-tools: Vault Digital On MCP
---

# Skill: salva-design-system

## Obiettivo

Salvare il design system di un cliente nel vault in modo strutturato e riutilizzabile, così che ogni progetto futuro possa accedervi senza doverlo riestrarre.

## Prerequisiti

- Design system già estratto (colori, font, spaziature, componenti)
- Nome del cliente noto (per trovare il path corretto nel vault)
- Accesso al vault tramite connettore Vault Digital On

## Struttura nel vault

```
clients/[nome-cliente]/
└── design-system/
    ├── tokens.md        ← colori, font, spaziature, border radius
    ├── components.md    ← componenti UI identificati (se disponibili)
    └── notes.md         ← note su uso, do/don't, riferimenti (opzionale)
```

## Processo

### Step 0 — Verifica stato attuale ⚠️ OBBLIGATORIO

Prima di scrivere qualsiasi cosa, controlla cosa esiste già nel vault:

1. Verifica se esiste `clients/[cliente]/design-system/` con `list_files`
2. Se esiste `tokens.md`, leggilo e mostra all'utente un riepilogo di cosa c'è già:
   ```
   ✅ tokens.md esistente — ultima estrazione: [data]
      Colori: [n] definiti | Font: [font] | Spaziature: [sì/no]
      Componenti: [sì/no]
   ```
3. Chiedi esplicitamente:
   - **"Vuoi aggiornare solo le sezioni mancanti o sovrascrivere tutto?"**
   - Se aggiornamento parziale → procedi solo sulle sezioni mancanti
   - Se sovrascrittura → aggiungi nota in cima al file con data e motivo
4. Non procedere mai senza conferma esplicita dell'utente se il file esiste già

### Step 1 — Raccogli i dati

Se l'output del design system è già nella conversazione, estrai:
- Tutti i colori (hex, nome, utilizzo)
- Font families e scala tipografica
- Spaziature e border radius
- Componenti UI identificati (bottoni, card, navbar, ecc.)
- URL sorgente e data estrazione

Se mancano informazioni, chiedi all'utente prima di procedere.

### Step 2 — Scrivi tokens.md

Crea o aggiorna `clients/[cliente]/design-system/tokens.md` con questo formato:

```markdown
# Design System — [Nome Cliente]
<!-- estratto da: [URL] — [data] -->
<!-- tool usato: [es. ui-designer / estrazione manuale] -->
<!-- ultimo aggiornamento: [data] — [motivo aggiornamento] -->

## Colori

### Palette primaria
| Nome | Hex | Utilizzo |
|------|-----|----------|
| Primary | #XXXXXX | CTA, bottoni, link |
| Primary Light | #XXXXXX | Hover, sfondi accent |
| Primary Dark | #XXXXXX | Testo su sfondo chiaro |

### Palette neutra
| Nome | Hex | Utilizzo |
|------|-----|----------|
| Text Primary | #XXXXXX | Testo principale |
| Text Secondary | #XXXXXX | Testo muted, label |
| Background | #XXXXXX | Sfondo pagina |
| Surface | #XXXXXX | Card, container |
| Border | #XXXXXX | Bordi, divisori |

### Colori semantici (se presenti)
| Nome | Hex | Utilizzo |
|------|-----|----------|
| Success | #XXXXXX | |
| Warning | #XXXXXX | |
| Error | #XXXXXX | |

## Tipografia

| Stile | Font | Size | Weight | Line Height |
|-------|------|------|--------|-------------|
| H1 | | px | | |
| H2 | | px | | |
| H3 | | px | | |
| Body | | px | | |
| Small | | px | | |
| Label | | px | uppercase | |

**Google Fonts import** (se applicabile):
```
[link import]
```

## Spaziature

- **Unità base**: Xpx
- **Border radius standard**: Xpx
- **Border radius pill**: Xpx
- **Spaziature ricorrenti**: Xpx, Xpx, Xpx, Xpx

## Ombre

```css
/* Shadow standard */
box-shadow: ...;
/* Shadow elevata */
box-shadow: ...;
```

## Note

<!-- Anomalie, colori inconsistenti, font misti, ecc. -->
```

### Step 3 — Scrivi components.md (se disponibile)

Se il design system include componenti UI, crea `clients/[cliente]/design-system/components.md`.
Verifica prima se esiste già — stessa logica dello Step 0.

```markdown
# Componenti UI — [Nome Cliente]

## [Nome Componente]
- **Varianti**: primary, secondary, ghost
- **Border radius**: Xpx
- **Colori**: bg #XXXXXX, text #XXXXXX, border #XXXXXX
- **Note**: ...
```

### Step 4 — Aggiorna il CLAUDE.md del cliente

Aggiungi nella sezione `Ecosistema tecnico condiviso` del `clients/[cliente]/CLAUDE.md`:

```markdown
**Design System**: `clients/[cliente]/design-system/tokens.md` — estratto da [URL] il YYYY-MM-DD
**Colori principali**: primary #XXXXXX | bg #XXXXXX | text #XXXXXX
**Font**: [nome font principale]
```

### Step 5 — Aggiorna il log

Aggiungi una riga al `clients/[cliente]/log.md`:

```
| DS-XXX | YYYY-MM-DD | Design System | Salvataggio design system — [motivo/tool usato] | Strategia | 0.5 | Claude | Completato | |
```

## Output atteso

- `clients/[cliente]/design-system/tokens.md` — creato o aggiornato (mai sovrascritto senza conferma)
- `clients/[cliente]/design-system/components.md` — creato se disponibile
- `clients/[cliente]/CLAUDE.md` — aggiornato con riferimento al design system
- `clients/[cliente]/log.md` — aggiornato con voce attività

## Note operative

- **Non sovrascrivere mai senza conferma esplicita** — se il file esiste, mostra sempre cosa c'è già
- Se i dati sono parziali (es. solo colori senza font), salva quello che c'è e lascia le sezioni mancanti con `<!-- DA COMPLETARE -->`
- Il formato tokens.md è pensato per essere leggibile da Claude in future sessioni — usa nomi chiari e hex espliciti, non variabili CSS
- Dopo il salvataggio, conferma all'utente i path esatti dei file creati o aggiornati

## Fuori scope

- Estrarre il design system dal sito (usa ui-designer)
- Creare componenti su Figma (usa figma-design-system)
- Generare codice CSS/Tailwind dai token (richiedi skill separata)
