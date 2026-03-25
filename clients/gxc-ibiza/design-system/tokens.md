# Design System — GXC Ibiza
<!-- estratto da: https://gxcibiza.com/ — 2026-03-25 -->
<!-- tool usato: design-system-extractor -->
<!-- ultimo aggiornamento: 2026-03-25 — prima estrazione completa -->
<!-- nome estetico: "Midnight Teal" -->

## Essence

A bold, high-contrast nightlife-meets-Mediterranean aesthetic that balances deep blacks and near-whites with vivid teal accents. The system communicates exclusivity and energy — luxury travel with a pulse. Dense, uppercase typography in heavy custom fonts creates authority, while generous pill-shaped buttons and smooth transitions add approachability. It feels like a VIP wristband: dark, confident, unmistakable.

## Colori

### Palette primaria
| Nome | Hex | Utilizzo |
|------|-----|----------|
| Teal Accent | #01A781 | CTA, link, stati attivi, accent globale Elementor |
| Teal CTA | #069978 | Bottoni, CTA background, elementi interattivi chiave |
| Teal Hover | #00A781 | Hover su elementi accent |
| Blue | #467FF7 | Accent secondario, link occasionali |
| Golden Amber | #FFBC7D | Badge promozionali, callout caldi |

### Palette neutra
| Nome | Hex | Utilizzo |
|------|-----|----------|
| Background Light | #FAFAFA | Sfondo pagina principale, card, sezioni chiare |
| Background Dark | #020202 | Hero, pannelli scuri, footer |
| Pure Black | #000000 | Sezioni full-bleed scure, basi overlay |
| Pure White | #FFFFFF | Superfici card, testo su scuro |
| Overlay Black | #0000004A | Overlay su immagini e video |
| Dark Overlay | rgb(0 0 0 / .8) | Backdrop menu off-canvas |
| Text Primary | #262626 | Testo principale, heading su sfondo chiaro |
| Text Secondary | #1F2124 | Variante più scura, sottotitoli |
| Text Deep | #0C0D0E | Testo massimo contrasto |
| Text Muted | #69727D | Caption, metadata, info secondaria |
| Text Soft | #88909B | Placeholder, stati disabilitati |
| Text Dark Gray | #33373D | Testo terziario, footer |
| Text Medium Gray | #3F444B | Label di supporto |
| Ghost on Dark | #FAFAFA3D | Testo fantasma su sfondi scuri (24% opacità) |

### Colori semantici
| Nome | Hex | Utilizzo |
|------|-----|----------|
| Success | #5CB85C | Conferma, stati positivi |
| Warning | #F0AD4E | Avvisi di cautela |
| Error | #D9534F | Errori, azioni distruttive |
| Info | #5BC0DE | Notifiche informative |

## Tipografia

| Stile | Font | Size | Weight | Line Height | Letter Spacing | Note |
|-------|------|------|--------|-------------|----------------|------|
| H1 | Nexa Black | 4rem (64px) | 600 | 1 | 4px | uppercase |
| H2 | Nexa Black | 3rem (48px) | 500 | 1 | 1px | uppercase |
| H3 | Nexa Black | 2.5rem (40px) | 600 | 1.2 | 1px | uppercase |
| H4 | Nexa Black | 2rem (32px) | 500 | 1.2 | 0 | |
| Large Body | Nexa Bold | 1.6–1.8rem | 400 | 2rem | 0 | Intro, callout |
| Body | Nexa Bold | 1.1rem (17.6px) | 400 | 2rem | 0 | Testo standard |
| UI / Button | Be Vietnam Pro | 1.2rem (19.2px) | 500 | 1.5 | 0 | Nav, bottoni, label |
| Small | Nexa Bold | 0.9rem (14.4px) | 400 | 1.5em | 0 | Metadata, fine print |
| Detail | Nexa Bold | 14–15px | 400 | 1.4 | 0 | Timestamp, tag |

**Font aggiuntivi** (uso limitato):
- "Anton" — heading promozionali speciali
- "Oswald" — contesti display secondari
- "Poppins" — variazione body sporadica
- "Helvetica Black Condensed" — titoli compatti ad alto impatto

**Google Fonts import**: N/A — "Nexa Black" e "Nexa Bold" sono self-hosted

**Trattamenti dominanti**:
- `text-transform: uppercase` su heading, nav, bottoni, titoli sezione
- `letter-spacing: 4px` su H1 (effetto editoriale arioso)
- `letter-spacing: 1px` su H2 e label navigazione

## Spaziature

- **Unità base**: Nessuna unità matematica rigida — cluster su multipli di 5px e 10px
- **xxs**: 0px — spacing collassato, elementi flush
- **xs**: 5px — padding interno stretto (badge, tag)
- **sm**: 10px — gap tra elementi lista, spacing icone
- **md**: 20px — padding interno sezioni, margini widget
- **lg**: 40px — separatori sezioni principali, margini bottom heading
- **xl**: variabile — hero con padding verticale generoso
- **Container max-width**: 1140px (Elementor boxed)
- **Content areas**: 1300px max per sezioni full-width
- **Blocchi testo centrati**: 700px max-width per leggibilità
- **Border radius standard**: 10–15px (card, contenitori)
- **Border radius pill**: 100px / 1000px (bottoni CTA, tag)
- **Border radius large**: 20px (card featured, hero container)
- **Border radius small**: 5–6px (input, elementi UI minori)
- **Border radius tiny**: 2–3px (badge)
- **Circle**: 50% (avatar, contenitori icone)

## Ombre

```css
/* Subtle — card a riposo */
box-shadow: 1px 1px 10px 1px rgb(0 0 0 / .23);

/* Medium — card hover, dropdown */
box-shadow: 1px 1px 10px 0 rgb(0 0 0 / .33);

/* Heavy — modal, overlay prominenti */
box-shadow: 2px 2px 10px 3px rgb(0 0 0 / .5);

/* Floating — card elevate, elementi in evidenza */
box-shadow: 2px 8px 23px 3px rgb(0 0 0 / .2);

/* Ambient — elevazione soft a livello pagina */
box-shadow: 0 8px 24px rgb(0 0 0 / .15);

/* Inset — bordi sottili input field */
box-shadow: inset 0 0 0 1px rgba(0,0,0,.1);

/* Glow — elementi su sfondo scuro */
box-shadow: 1px 1px 5px 1px rgb(255 255 255 / .57);
```

## Stati interattivi

### Bottoni
- **Default**: bg `#069978`, text `#FFFFFF`, border-radius `100px` (pill), font "Be Vietnam Pro" 500
- **Hover**: bg → `#01A781` (teal più luminoso), transizione `color 0.3s`
- **Active**: leggero scurimento del teal
- **Disabled**: riduzione opacità, colori muted
- **Transition**: `color 0.3s`, `all .3s`

### Link
- **Default**: `#01A781` (teal accent)
- **Hover**: `#069978` con `color 0.3s`
- **Nav items**: uppercase, "Nexa Black", animazioni underline/framed pointer
- **Dropdown**: "Be Vietnam Pro", case normale, transizione 300ms

### Input form
- **Border**: `inset 0 0 0 1px rgba(0,0,0,.1)`
- **Border radius**: 5–6px
- **Focus**: bordo teal accent

## Motion

### Principi
Smooth e sicuro. Transizioni a 300ms costanti per un feel premium. Transform a 400ms con ease per peso fisico. Nessun bounce o spring — tutto pulito e intenzionale.

### Pattern
| Tipo | Valore | Uso |
|------|--------|-----|
| Color | `color 0.3s` | Cambio colore testo/icone su hover |
| General | `all .3s` | Cambi multi-proprietà |
| Transform | `transform .4s ease` | Entrata elementi, carousel |
| Fade-in | `opacity 1s` | Reveal drammatico immagini lazy-load |
| Quick fade | `opacity .2s, transform .4s` | Entrata combinata con stagger |
| Menu | `max-height .3s, transform .3s` | Espansione accordion/dropdown |
| Fill | `fill 0.3s` | Cambio colore icone SVG |
| Scroll | IntersectionObserver | Class toggle per animazioni entrata |

## Design Principles

1. **Dark-first confidence** — Sfondi scuri dominano hero e sezioni chiave; il chiaro è per aree di lettura. Il contrasto crea drama e lusso.
2. **Teal as signature** — Un singolo accent vivido (`#01A781`/`#069978`) porta tutto il peso interattivo e di brand.
3. **Heavy type, uppercase authority** — Font custom black-weight ("Nexa Black") in uppercase con tracking largo proiettano sicurezza ed esclusività.
4. **Pill-shaped interactivity** — Tutti gli elementi interattivi primari usano border-radius estremo (100px+).
5. **Consistent 300ms rhythm** — Quasi tutte le transizioni condividono lo stesso timing 300ms.

## Note implementative

- Costruito su **Elementor** (WordPress) con CSS custom properties `--e-global-*`
- **Token Elementor globali**:
  - `--e-global-color-primary: #FAFAFA`
  - `--e-global-color-secondary: #262626`
  - `--e-global-color-accent: #01A781`
  - `--e-global-color-text: #262626`
  - `--e-global-typography-primary-font-family: "Nexa Black"`
  - `--e-global-typography-secondary-font-family: "Nexa Black"`
  - `--e-global-typography-text-font-family: "Nexa Bold"`
  - `--e-global-typography-accent-font-family: "Be Vietnam Pro"`
- **Font custom**: "Nexa Black" e "Nexa Bold" sono self-hosted (non Google Fonts)
- **Performance**: LiteSpeed caching con CSS bundling, lazy loading via IntersectionObserver
- **Container max-width**: 1140px (Elementor default boxed)
- **Multilingua**: 5 lingue (EN, IT, ES, DE, FR) — il design deve gestire lunghezze testo variabili
- CSS consegnato come bundle minificato LiteSpeed (~355KB)
