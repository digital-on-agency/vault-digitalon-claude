<!-- ultimo aggiornamento: 2026-03-26 -->

# Figma to Code — Workflow

## Overview

Il passaggio da Figma al codice è il momento in cui si perdono più dettagli. Un workflow strutturato riduce i round di revisione e mantiene la fedeltà al design.

## Workflow standard

### 1. Preparazione in Figma

**Prima di passare allo sviluppo, verificare che il file Figma sia pronto:**

- Auto Layout su tutti i componenti (no posizionamento assoluto)
- Varianti componenti definite come Component Set
- Colori e tipografia come Figma Styles o Variables
- Naming layer pulito e semantico (no "Frame 427")
- Responsive: almeno 2 breakpoint (mobile 375px, desktop 1440px)
- Spacing e padding espliciti (visibili in inspect)

### 2. Inspect e handoff

**Figma Dev Mode** (o inspect panel):
- Selezionare un elemento per vedere: dimensioni, spacing, colori, font, border radius
- Copiare i valori CSS direttamente dal pannello
- Verificare le distanze tra elementi con hover + Alt

**Cosa estrarre per ogni componente:**
- Dimensioni (width, height — fisse o responsive?)
- Padding e margin
- Colori (hex, opacity)
- Font: family, size, weight, line-height, letter-spacing
- Border: width, color, radius
- Shadow: x, y, blur, spread, color
- Stato: default, hover, focus, active, disabled

### 3. Export asset

**Icone**
- Esportare come SVG (scalabili, leggeri)
- In Figma: selezionare icona → Export → SVG
- Ottimizzare con SVGO prima di importare nel progetto
- In React: importare come componente o usare sprite SVG

**Immagini**
- Esportare a 2x per retina
- Formati: WebP per web (fallback JPG/PNG), PNG per trasparenza
- Definire dimensioni max nel design per guidare il responsive

**Illustrazioni**
- SVG se vettoriali
- PNG/WebP se complesse con molti dettagli

### 4. Da Figma a Tailwind

Mappatura rapida dei valori Figma più comuni:

| Figma | Tailwind |
|-------|----------|
| Width 100% | `w-full` |
| Padding 16px | `p-4` |
| Gap 12px | `gap-3` |
| Border radius 8px | `rounded-lg` |
| Font size 14px | `text-sm` |
| Font weight 600 | `font-semibold` |
| Color #00C896 | `text-[#00C896]` o custom config |
| Shadow 0 1px 3px | `shadow-sm` |
| Opacity 50% | `opacity-50` |
| Auto Layout vertical | `flex flex-col` |
| Auto Layout horizontal | `flex flex-row` |
| Space between | `justify-between` |
| Fill container | `flex-1` |
| Hug contents | `w-fit` |

### 5. Da Figma a React

**Struttura componente tipo:**

```jsx
// Figma Component → React Component
// "Card / Default" in Figma → Card.jsx

function Card({ title, description, image, onClick }) {
  return (
    <div
      className="rounded-lg shadow-sm bg-white p-6 cursor-pointer hover:shadow-md transition-shadow"
      onClick={onClick}
    >
      {image && <img src={image} alt="" className="w-full h-40 object-cover rounded-md mb-4" />}
      <h3 className="text-lg font-semibold text-gray-900">{title}</h3>
      <p className="text-sm text-gray-600 mt-2">{description}</p>
    </div>
  );
}
```

**Mappatura varianti Figma → props React:**
- Figma variant "Size = Large" → prop `size="lg"`
- Figma variant "State = Disabled" → prop `disabled`
- Figma variant "Type = Primary" → prop `variant="primary"`

## MCP Figma — Code Connect

Con il server MCP Figma si può:

1. **`get_design_context`** — estrae codice, screenshot e hint da un nodo Figma. Restituisce React+Tailwind come riferimento da adattare.
2. **`get_code_connect_map`** — vede le mappature esistenti tra componenti Figma e componenti code.
3. **`add_code_connect_map`** — crea nuove mappature per mantenere sincronizzazione.
4. **`get_screenshot`** — cattura screenshot di un frame per riferimento visivo.

**Workflow con MCP:**
1. Ricevere URL Figma dal designer
2. Estrarre fileKey e nodeId dall'URL
3. Chiamare `get_design_context` per ottenere codice di riferimento
4. Adattare al progetto: componenti esistenti, token, convenzioni
5. Mappare con `add_code_connect_map` per futuri aggiornamenti

## Checklist handoff

- [ ] Tutti i componenti hanno Auto Layout
- [ ] Stili (colori, font) definiti come Variables o Styles
- [ ] Layer rinominati con nomi semantici
- [ ] Almeno 2 breakpoint (mobile + desktop)
- [ ] Asset esportabili marcati con export settings
- [ ] Stati interattivi visibili (hover, focus, disabled)
- [ ] Spacing consistente e sulla griglia base-4
