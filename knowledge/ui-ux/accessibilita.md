<!-- ultimo aggiornamento: 2026-03-26 -->

# Accessibilità Web (a11y)

## Perché è importante

L'accessibilità non è un extra — è un requisito. In Italia il Decreto Legislativo 76/2020 estende gli obblighi di accessibilità anche ai privati con fatturato > 500M (dal 2025 si estende ulteriormente con l'European Accessibility Act). Oltre alla compliance, un sito accessibile è un sito migliore per tutti.

## WCAG — i 4 principi

1. **Percepibile** — il contenuto deve essere presentabile in modi che l'utente può percepire
2. **Utilizzabile** — l'interfaccia deve essere navigabile e operabile
3. **Comprensibile** — il contenuto e l'interfaccia devono essere comprensibili
4. **Robusto** — il contenuto deve funzionare con diverse tecnologie assistive

**Target minimo: WCAG 2.1 livello AA.**

## Contrasto colori

Rapporto minimo di contrasto (AA):
- **Testo normale** (< 18px): 4.5:1
- **Testo grande** (>= 18px bold o >= 24px): 3:1
- **Elementi UI** (bordi, icone): 3:1

Strumenti per verificare:
- Chrome DevTools: inspect elemento → contrast ratio nel color picker
- WebAIM Contrast Checker (webaim.org/resources/contrastchecker)

Errore comune: testo grigio chiaro su bianco. `#757575` su `#FFFFFF` = 4.6:1 (passa). `#999999` su `#FFFFFF` = 2.8:1 (non passa).

## HTML semantico

Usare i tag HTML corretti è il modo più semplice per migliorare l'accessibilità:

| Invece di | Usare |
|-----------|-------|
| `<div onclick>` | `<button>` |
| `<div class="header">` | `<header>` |
| `<div class="nav">` | `<nav>` |
| `<div class="main">` | `<main>` |
| `<div>` per testo | `<p>`, `<h1>`-`<h6>` |
| `<div>` per lista | `<ul>`, `<ol>`, `<li>` |
| `<span>` cliccabile | `<a>` (se naviga) o `<button>` (se azione) |

**Heading**: rispettare la gerarchia (h1 → h2 → h3). Un solo `<h1>` per pagina. Mai saltare livelli.

## Navigazione da tastiera

Ogni funzionalità deve essere utilizzabile senza mouse:

- **Tab**: muove il focus al prossimo elemento interattivo
- **Shift+Tab**: torna indietro
- **Enter/Space**: attiva bottoni e link
- **Esc**: chiude modal/dropdown
- **Arrow keys**: naviga dentro menu, tab, select

### Focus visible

Il focus ring deve essere sempre visibile. Mai `outline: none` senza alternativa.

```css
/* Focus ring accessibile */
:focus-visible {
  outline: 2px solid #00C896;
  outline-offset: 2px;
}
```

In Tailwind: `focus-visible:ring-2 focus-visible:ring-primary focus-visible:ring-offset-2`

### Focus trap

Modal e dialog devono intrappolare il focus al loro interno. Tab dal ultimo elemento torna al primo. Implementare con librerie (`focus-trap-react`) o attributo `inert` sullo sfondo.

### Skip link

Primo elemento della pagina, visibile solo al focus:

```html
<a href="#main-content" class="sr-only focus:not-sr-only focus:absolute focus:top-4 focus:left-4 focus:bg-white focus:p-2 focus:z-50">
  Salta al contenuto principale
</a>
```

## ARIA — quando e come

**Regola d'oro: non usare ARIA se l'HTML semantico basta.**

ARIA serve solo per widget custom che HTML non copre:

| Attributo | Quando usarlo |
|-----------|--------------|
| `aria-label` | Elemento interattivo senza testo visibile (es. bottone con sola icona) |
| `aria-labelledby` | Label è un altro elemento nella pagina |
| `aria-describedby` | Descrizione aggiuntiva (es. messaggio errore per un input) |
| `aria-hidden="true"` | Nascondere elementi decorativi dallo screen reader |
| `aria-expanded` | Toggle (accordion, dropdown) — `true`/`false` |
| `aria-live="polite"` | Regione che si aggiorna dinamicamente (toast, contatori) |
| `role="alert"` | Messaggi urgenti (errori form) |
| `role="dialog"` | Modal custom |
| `role="tablist/tab/tabpanel"` | Tab interface custom |

## Immagini

- **Decorative**: `alt=""` (stringa vuota, non omettere l'attributo)
- **Informative**: `alt="Descrizione del contenuto"` — descrivere cosa comunica l'immagine, non cosa è
- **Funzionale** (icona in bottone): `alt` descrive l'azione, non l'icona → `alt="Cerca"` non `alt="Lente di ingrandimento"`

## Form accessibili

```html
<!-- Label esplicita collegata all'input -->
<label for="email">Email</label>
<input id="email" type="email" aria-describedby="email-error" aria-invalid="true" />
<span id="email-error" role="alert">Inserisci un'email valida</span>
```

- Ogni input deve avere un `<label>` collegato con `for`/`id`
- Errori collegati con `aria-describedby`
- `aria-invalid="true"` su campi con errore
- `aria-required="true"` o attributo HTML `required` per campi obbligatori
- Raggruppare radio/checkbox con `<fieldset>` e `<legend>`

## Checklist rapida

- [ ] Contrasto testo AA (4.5:1 normale, 3:1 grande)
- [ ] HTML semantico (heading, landmark, liste)
- [ ] Navigazione completa da tastiera
- [ ] Focus visibile su tutti gli elementi interattivi
- [ ] Alt text su tutte le immagini informative
- [ ] Label su tutti i campi form
- [ ] Modal con focus trap e chiusura Esc
- [ ] Skip link presente
- [ ] Nessuna informazione trasmessa solo tramite colore
- [ ] Testo ridimensionabile fino a 200% senza perdita di contenuto
