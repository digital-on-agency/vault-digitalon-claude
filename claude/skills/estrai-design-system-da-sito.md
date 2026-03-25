---
name: estrai-design-system-da-sito
description: Estrae un design system completo partendo da un sito web esistente di un cliente. Usare quando si chiede di "estrarre il design system dal sito", "creare il design system partendo dal sito web", "analizzare i colori/font/stile del sito", "replicare lo stile del sito su Figma", o "costruire il design system di [cliente]". Il processo analizza il sito live, estrae colori, tipografia, spaziature e componenti visivi, poi li formalizza in un file Figma strutturato pronto per essere esteso.
allowed-tools: Figma MCP, web_fetch, web_search
---

# Skill: estrai-design-system-da-sito

## Obiettivo

Analizzare un sito web esistente di un cliente e costruire un design system formale su Figma — colori, tipografia, spaziature, componenti — fedele all'identità visiva già presente online, pronto per essere esteso e usato in nuovi progetti.

## Prerequisiti

- URL del sito web del cliente (trovalo nel CLAUDE.md del cliente se non fornito)
- Connettore Figma MCP attivo
- Accesso web per fetch del sito

## Processo

### Step 1 — Leggi il contesto cliente

1. Leggi il `clients/[cliente]/CLAUDE.md` per estrarre:
   - URL del sito (`Domini`)
   - Nome brand e prodotti principali
   - Note su identità visiva già note
2. Se il cliente ha già un file Figma esistente, usa `Figma:get_metadata` per verificarne il contenuto prima di creare da zero.

### Step 2 — Analisi del sito web

Usa `web_fetch` sull'URL del sito per estrarre il codice HTML/CSS. Analizza e documenta:

**Colori** — estrai tutti i valori hex/rgb presenti nei CSS:
- Colore primario (bottoni, CTA, link)
- Colore secondario / accent
- Colori di testo (principale, secondario, muted)
- Colori di sfondo (pagina, sezioni, cards)
- Colori semantici (success, warning, error) se presenti
- Crea una palette strutturata con nomi coerenti

**Tipografia** — estrai:
- Font families usati (Google Fonts, Adobe, system)
- Scale dimensioni (px o rem) usata per H1, H2, H3, body, small
- Font weight usati (300, 400, 500, 600, 700)
- Line height e letter spacing rilevanti

**Spaziature** — identifica:
- Unità base (es. 4px, 8px)
- Padding/margin ricorrenti (es. 16px, 24px, 40px, 80px)
- Border radius usati (es. 4px, 8px, 999px per pill)

**Ombre e bordi**:
- Box shadow ricorrenti
- Border color e spessore standard

**Componenti visivi rilevati** — cataloga i pattern UI presenti:
- Bottoni (colori, size, border radius)
- Cards e container
- Navbar / header
- Footer
- Form inputs (se presenti)
- Badge / tag / chip
- Hero section pattern

> Se il fetch restituisce solo HTML minimo (es. SPA React/Next.js), usa `web_search` per cercare "[nome sito] brand colors font" oppure fetch su pagine specifiche come `/about`, `/menu`, `/book`.

### Step 3 — Documenta l'analisi

Prima di toccare Figma, presenta all'utente un riepilogo strutturato dell'analisi:

```
## Design system estratto da [URL]

### Colori
- Primary: #XXXXXX — usato per [CTA / bottoni]
- Secondary: #XXXXXX — usato per [accent / hover]
- Text primary: #XXXXXX
- Text secondary: #XXXXXX
- Background: #XXXXXX
- Surface: #XXXXXX

### Tipografia
- Font principale: [nome font]
- Font secondario: [nome font o "none"]
- Scale: H1 [Xpx/Xrem], H2 [...], Body [...]
- Weight usati: [lista]

### Spaziature
- Unità base: Xpx
- Border radius standard: Xpx

### Componenti identificati
- [lista componenti trovati]

### Note / Anomalie
- [colori inconsistenti, font misti, ecc.]
```

Chiedi conferma prima di procedere su Figma. L'utente potrebbe voler correggere o integrare.

### Step 4 — Crea il file Figma

1. Usa `Figma:create_new_file` con nome: `[Nome Cliente] — Design System`
2. Struttura in 4 pagine:
   - `Cover` — nome progetto, URL sorgente, data estrazione
   - `Styles` — palette colori + scala tipografica
   - `Components` — componenti UI estratti
   - `Guidelines` — note d'uso, do/don't, esempi layout

### Step 5 — Popola Styles

**Palette colori** — crea rettangoli con label:
- Organizza in righe per famiglia: `Primary`, `Neutral`, `Semantic`
- Per ogni colore: rettangolo 80×80px + etichetta nome + hex
- Se il brand ha varianti (es. primary 100/500/900), creale tutte

**Scala tipografica** — crea text frame per ogni stile:
- Mostra font name, size, weight, line height
- Esempio di testo reale per ogni livello (non solo "H1 Heading")

### Step 6 — Crea i componenti

Basandoti sui componenti identificati nello Step 2, crea su Figma i pattern UI del sito replicati fedelmente:

**Sempre da creare:**
- Button (varianti: primary, secondary, ghost — con colori estratti)
- Badge / tag
- Card base

**Da creare se identificati nel sito:**
- Navbar con logo + voci menu
- Hero section con headline + CTA
- Footer
- Form input
- Qualsiasi pattern ricorrente specifico del brand

Ogni componente deve usare i colori e font estratti — non valori di default Figma.

### Step 7 — Guidelines page

Crea una pagina `Guidelines` con:
- Regole d'uso del colore primario (quando usarlo, quando no)
- Coppie tipografiche raccomandate
- Esempi di layout (card grid, hero, sezione con testo)
- Do / Don't visivi se ci sono pattern da preservare

### Step 8 — Salva nel vault

Aggiorna il `clients/[cliente]/CLAUDE.md` con:

```markdown
**Figma Design System**: [link file Figma] — estratto da [URL] il YYYY-MM-DD
**Colori principali**: primary #XXXXXX, secondary #XXXXXX, bg #XXXXXX
**Font**: [nome font principale]
```

Aggiorna anche il log del cliente:

```
| DS-001 | YYYY-MM-DD | Design System | Estrazione design system da [URL] e creazione file Figma | Strategia | X.X | Claude | Completato | |
```

## Output atteso

- Analisi documentata del sito (colori, font, spaziature, componenti)
- File Figma con 4 pagine: Cover, Styles, Components, Guidelines
- Palette colori fedele al sito, con naming strutturato
- Scala tipografica reale estratta dal codice
- Componenti UI principali replicati in Figma
- Link file e sintesi salvati nel vault

## Note operative

- Se il sito usa un CSS framework (Tailwind, Bootstrap) cerca le classi ricorrenti per inferire il sistema di spaziatura
- Se i colori sono in variabili CSS (`:root { --primary: ... }`), quelli sono la fonte di verità — priorità assoluta
- Per siti con poco CSS accessibile (SPA, SSR), fai screenshot mentale dalle descrizioni HTML e completa con buon senso visivo
- Non inventare colori o font non presenti nel sito — se non riesci a estrarli, segnalalo all'utente e chiedi un riferimento visivo
- Se il cliente ha già una brand guide PDF o Figma file, leggilo prima di fare il fetch — potrebbe contenere valori più precisi

## Fuori scope

- Redesign o miglioramento dell'identità visiva (questa skill estrae, non ridisegna)
- Analisi UX o audit di usabilità
- Export asset per sviluppatori
- Animazioni
