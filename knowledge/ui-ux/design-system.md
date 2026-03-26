<!-- ultimo aggiornamento: 2026-03-26 -->

# Design System

## Cos'è e perché serve

Un design system è l'unica fonte di verità per l'aspetto visivo e il comportamento di un prodotto digitale. Garantisce coerenza tra pagine, velocizza lo sviluppo e riduce il debito tecnico UI.

## Struttura di un design system

### 1. Design Token

I token sono le variabili atomiche del sistema. Definiscono i valori, non il contesto d'uso.

**Colori**
- `primary`, `primary-light`, `primary-dark` — colore brand principale e varianti
- `secondary` — colore di supporto
- `neutral-50` → `neutral-900` — scala grigi (50 = più chiaro, 900 = più scuro)
- `success`, `warning`, `error`, `info` — colori semantici
- `background`, `surface`, `on-primary`, `on-surface` — colori contestuali

**Tipografia**
- Font family: massimo 2 (uno heading, uno body). Inter è un buon default.
- Scale tipografica: `xs` (12px), `sm` (14px), `base` (16px), `lg` (18px), `xl` (20px), `2xl` (24px), `3xl` (30px), `4xl` (36px)
- Line height: `tight` (1.25), `normal` (1.5), `relaxed` (1.75)
- Font weight: `regular` (400), `medium` (500), `semibold` (600), `bold` (700)

**Spacing**
- Scala a base 4: `1` (4px), `2` (8px), `3` (12px), `4` (16px), `6` (24px), `8` (32px), `10` (40px), `12` (48px), `16` (64px)
- Usare sempre la scala, mai valori arbitrari

**Border radius**
- `none` (0), `sm` (4px), `md` (8px), `lg` (12px), `xl` (16px), `full` (9999px)

**Shadow**
- `sm` — card e elementi rialzati
- `md` — dropdown, popover
- `lg` — modal, dialog

### 2. Componenti base

Ogni componente ha: stato default, hover, focus, active, disabled.

| Componente | Varianti | Note |
|-----------|----------|------|
| Button | primary, secondary, tertiary, danger | Vedi sezione dedicata sotto |
| Input | text, email, password, search, textarea | Label sempre visibile, no placeholder-as-label |
| Select | single, multi, searchable | Dropdown con max-height e scroll |
| Checkbox / Radio | default, indeterminate (checkbox) | Area cliccabile generosa (min 44x44px) |
| Badge | info, success, warning, error, neutral | Solo testo breve |
| Avatar | image, initials, icon | Con fallback a iniziali |
| Card | default, interactive (hover state) | Padding interno consistente |
| Modal / Dialog | small, medium, large | Trap focus, chiudi con Esc |
| Toast / Alert | info, success, warning, error | Auto-dismiss dopo 5s (non per errori) |
| Tooltip | top, right, bottom, left | Solo per info supplementare, mai critica |

### Button — guida ai 3 pesi

Un design system ha bisogno di 3 pesi di bottone per indicare l'importanza relativa delle azioni:

- **Primary** — azione principale, il più prominente. Fill ad alto contrasto col colore brand.
- **Secondary** — alternativa alla primary o azioni di pari importanza. Bordo ad alto contrasto senza fill (outline).
- **Tertiary** — azioni multiple o distruttive da rendere meno prominenti. Testo sottolineato.

**Pattern sicuro e accessibile:**
```
[  Primary  ]     →  fill colore brand, testo bianco
[  Secondary ]    →  bordo colore brand, sfondo trasparente, testo colore brand
   Tertiary       →  testo sottolineato, colore brand
```

Questa combinazione ha gerarchia visiva chiara, non dipende dal solo colore, e rispetta i requisiti WCAG.

**Errori comuni da evitare:**

| Errore | Problema |
|--------|----------|
| Secondary con fill a basso contrasto (grigio chiaro) | Contrasto < 3:1, sembra disabilitato |
| Primary e secondary entrambi con fill colorato | Conflitto visivo, gerarchia confusa, indistinguibili per daltonici |
| Tertiary come testo colorato senza underline | Colore come unico indicatore di interattività, inaccessibile |
| Primary e secondary con forma diversa (es. round vs rettangolo) | Incoerenza, elementi con stessa funzione devono avere stessa forma |
| Tutti i bottoni solo outline con colori diversi | Troppo simili, contrasto tra bottoni < 3:1 |

**Dimensioni bottoni:**

- **Altezza**: tra 44px e 72px. Sotto 44px non è touch-friendly, sopra 72px è visivamente sbilanciato
- **Larghezza minima mobile**: 10mm x 10mm (circa 40x40px) — basato sulla dimensione media del polpastrello. Oltre il minimo, la larghezza si adatta al contenuto (padding + label)
- **Padding**: il padding orizzontale è 2x il verticale. Es: verticale 16px → orizzontale 32px

| Size | Altezza | Padding (v / h) | Font size | Uso |
|------|---------|-----------------|-----------|-----|
| `sm` | 36px | 8px / 16px | 14px | Azioni inline, tabelle |
| `md` | 44px | 12px / 24px | 16px | Default, form |
| `lg` | 52px | 16px / 32px | 18px | CTA, hero, azioni primarie |

**Regole di accessibilità per bottoni:**

- Contrasto forma bottone vs sfondo: minimo **3:1** (WCAG 2.1 AA)
- Contrasto testo bottone: minimo **4.5:1** (testo normale ≤ 18px)
- Se due bottoni hanno stile identico, il contrasto tra loro deve essere almeno **3:1**
- Non usare il colore come unico differenziatore tra bottoni
- Target area minima: **48x48px** (su mobile almeno 10x10mm)
- Spaziatura minima tra bottoni: **16px**
- Focus ring visibile su tutti i bottoni

**Nota:** tertiary button e text link possono apparire identici. Quello che conta è che siano codificati correttamente — `<button>` per azioni, `<a>` per navigazione — indipendentemente dall'aspetto.

### 3. Pattern di composizione

- **Stack**: elementi impilati verticalmente con gap uniforme
- **Cluster**: elementi affiancati con wrap automatico
- **Sidebar layout**: contenuto principale + sidebar con larghezza fissa
- **Grid**: 12 colonne per layout complessi, CSS Grid per dashboard

## Naming convention

- Token: `kebab-case` → `color-primary`, `spacing-4`, `font-size-lg`
- Componenti: `PascalCase` → `Button`, `TextInput`, `CardHeader`
- Varianti: prop esplicita → `<Button variant="primary" size="lg">`
- CSS/Tailwind: prefisso semantico → `bg-primary`, `text-on-primary`

## Tailwind CSS — integrazione token

Quando si usa Tailwind senza configurazione custom (come in Trovapulizie), applicare i colori direttamente nei componenti:

```jsx
// Colore brand diretto nel componente
<button className="bg-[#00C896] hover:bg-[#00B585] text-white">
```

Quando il progetto scala, migrare a `tailwind.config.js`:

```js
theme: {
  extend: {
    colors: {
      primary: { DEFAULT: '#00C896', light: '#E6F9F3', dark: '#00A87D' },
    }
  }
}
```

## Figma — struttura consigliata

Un file Figma di design system dovrebbe avere:
1. **Cover** — nome, versione, data ultimo aggiornamento
2. **Styles** — colori, tipografia, effetti (shadow, blur)
3. **Components** — tutti i componenti con varianti e stati
4. **Patterns** — composizioni ricorrenti (form, card list, navigation)
5. **Screens** — pagine tipo per riferimento

Usare Figma Variables per i token e Auto Layout per tutti i componenti.

## Checklist nuovo design system

- [ ] Palette colori definita con contrasto WCAG AA
- [ ] Scala tipografica con massimo 2 font
- [ ] Spacing su scala base-4
- [ ] Componenti base con tutti gli stati
- [ ] Naming convention documentata
- [ ] File Figma strutturato
- [ ] Token esportabili o mappati su Tailwind/CSS
