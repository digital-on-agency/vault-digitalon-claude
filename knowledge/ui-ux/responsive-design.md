<!-- ultimo aggiornamento: 2026-03-26 -->

# Responsive Design

## Approccio: Mobile-First

Scrivere gli stili per mobile come default, poi aggiungere stili per schermi più grandi con media query (o prefissi Tailwind). Il motivo: è più facile aggiungere complessità che toglierla.

```css
/* Mobile default */
.container { padding: 16px; }

/* Tablet e su */
@media (min-width: 768px) { .container { padding: 24px; } }

/* Desktop */
@media (min-width: 1024px) { .container { padding: 32px; max-width: 1200px; } }
```

## Breakpoint

Standard Tailwind (e consigliati come default):

| Nome | Min-width | Target |
|------|-----------|--------|
| `sm` | 640px | Smartphone landscape |
| `md` | 768px | Tablet portrait |
| `lg` | 1024px | Tablet landscape / laptop |
| `xl` | 1280px | Desktop |
| `2xl` | 1536px | Monitor grandi |

**Regola pratica:** progettare per 3 layout (mobile, tablet, desktop). Usare `sm` e `2xl` solo per aggiustamenti minori.

## Pattern adattivi

### Stack (vertical collapse)
Elementi affiancati su desktop diventano impilati su mobile.

```html
<!-- Tailwind: row su desktop, column su mobile -->
<div class="flex flex-col md:flex-row gap-4">
  <div class="md:w-1/2">Blocco 1</div>
  <div class="md:w-1/2">Blocco 2</div>
</div>
```

### Grid responsive
Da multi-colonna a singola colonna.

```html
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
  <!-- Card ripetute -->
</div>
```

### Sidebar collapse
Sidebar visibile su desktop, nascosta su mobile con toggle (hamburger).

```html
<!-- Sidebar -->
<aside class="hidden lg:block lg:w-64">...</aside>
<!-- Mobile: overlay sidebar con state open/closed -->
```

### Table → Card stack
Tabelle non funzionano su mobile. Due approcci:

1. **Card stack**: ogni riga diventa una card con label:valore
2. **Scroll orizzontale**: `overflow-x-auto` con prima colonna sticky

La card stack è preferibile per dati che l'utente legge. Lo scroll orizzontale per dati che l'utente confronta tra righe.

### Navigation adattiva
- **Desktop**: top bar orizzontale con tutte le voci
- **Tablet**: top bar con voci ridotte + menu "Altro"
- **Mobile**: bottom navigation (3-5 icone) oppure hamburger menu

### Hide / Show
Nascondere elementi non essenziali su mobile:

```html
<span class="hidden md:inline">Descrizione estesa visibile solo su tablet+</span>
<span class="md:hidden">Breve</span>
```

Usare con cautela — il contenuto nascosto su mobile deve essere davvero secondario.

## Tipografia responsive

La dimensione font deve scalare con lo schermo:

| Elemento | Mobile | Desktop |
|----------|--------|---------|
| Body | 16px (`text-base`) | 16px |
| H1 | 24px (`text-2xl`) | 36px (`text-4xl`) |
| H2 | 20px (`text-xl`) | 30px (`text-3xl`) |
| H3 | 18px (`text-lg`) | 24px (`text-2xl`) |
| Small | 12px (`text-xs`) | 14px (`text-sm`) |

```html
<h1 class="text-2xl md:text-3xl lg:text-4xl font-bold">Titolo</h1>
```

## Spacing responsive

Padding e gap più stretti su mobile:

```html
<section class="px-4 py-6 md:px-8 md:py-12 lg:px-16 lg:py-20">
  <div class="grid gap-4 md:gap-6 lg:gap-8">
    ...
  </div>
</section>
```

## Immagini responsive

```html
<!-- Dimensione fluida con aspect ratio -->
<img src="hero.webp" class="w-full h-auto aspect-video object-cover" alt="..." />

<!-- Immagini diverse per breakpoint -->
<picture>
  <source media="(min-width: 1024px)" srcset="hero-desktop.webp" />
  <source media="(min-width: 768px)" srcset="hero-tablet.webp" />
  <img src="hero-mobile.webp" alt="..." />
</picture>
```

## Touch target

Su mobile ogni elemento interattivo deve avere area minima **44x44px** (linee guida Apple/Google). In Tailwind: `min-h-[44px] min-w-[44px]`.

Distanza minima tra target touch: 8px.

## Testing

- Chrome DevTools: toggle device toolbar (Ctrl+Shift+M)
- Testare almeno: 375px (iPhone SE), 768px (iPad), 1440px (desktop)
- Verificare: testo leggibile senza zoom, touch target adeguati, nessun overflow orizzontale
