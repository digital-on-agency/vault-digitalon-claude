# Trovapulizie — Design System v1.0

## 1. Fondamenta del Brand

### 1.1 Principi di Design

| Principio | Descrizione | Applicazione |
|-----------|-------------|--------------|
| **Semplicita prima di tutto** | Ogni schermata ha un solo obiettivo chiaro | Max 1 CTA primaria per schermata |
| **Fiducia visiva** | L'utente (cleaner) deve sentirsi sicuro | Feedback visivo immediato, stati chiari |
| **Accessibilita nativa** | Target poco digitalizzato = zero ambiguita | Testi grandi, icone + label, tap target generosi |
| **Progressione guidata** | Mai lasciare l'utente senza direzione | Stepper visibili, pulsanti "Avanti" evidenti |

### 1.2 Tone of Voice UI

- **Registro:** informale ma rispettoso ("tu", mai "Lei")
- **Microcopy:** frasi brevi, verbi d'azione, niente gergo tecnico
- **Errori:** tono rassicurante ("Qualcosa non ha funzionato. Riprova!")
- **Conferme:** celebrative ma sobrie ("Prenotazione confermata!")

---

## 2. Palette Colori

### 2.1 Colori Primari

| Token | Hex | Uso |
|-------|-----|-----|
| `color-primary-50` | `#E6FFF5` | Background leggero, hover states |
| `color-primary-100` | `#B3FFE0` | Badge, chip background |
| `color-primary-200` | `#80FFCC` | Progress bar fill |
| `color-primary-300` | `#4DFFB8` | Icone secondarie |
| `color-primary-400` | `#1AFFA3` | Hover su CTA |
| `color-primary-500` | `#00C896` | **Primario principale** — CTA, link, accenti |
| `color-primary-600` | `#00A87E` | Pressed state su CTA |
| `color-primary-700` | `#008866` | Testo su sfondo chiaro (accessibile) |
| `color-primary-800` | `#00684E` | Header di sezione |
| `color-primary-900` | `#004836` | Icone su sfondo chiaro |

### 2.2 Colori Neutrali

| Token | Hex | Uso |
|-------|-----|-----|
| `color-neutral-0` | `#FFFFFF` | Background principale |
| `color-neutral-50` | `#F7F8FA` | Background secondario (card, sezioni) |
| `color-neutral-100` | `#EBEDF0` | Bordi, divider |
| `color-neutral-200` | `#D1D5DB` | Placeholder text |
| `color-neutral-300` | `#9CA3AF` | Testo disabilitato |
| `color-neutral-400` | `#6B7280` | Testo secondario (caption, metadata) |
| `color-neutral-500` | `#4B5563` | Testo body |
| `color-neutral-600` | `#374151` | Testo enfatizzato |
| `color-neutral-700` | `#1F2937` | Titoli, heading |
| `color-neutral-800` | `#111827` | Testo massimo contrasto |
| `color-neutral-900` | `#030712` | Overlay scuri |

### 2.3 Colori Semantici

| Token | Hex | Uso |
|-------|-----|-----|
| `color-success` | `#10B981` | Conferme, completamento |
| `color-success-light` | `#D1FAE5` | Background notifiche successo |
| `color-warning` | `#F59E0B` | Attenzione, in attesa |
| `color-warning-light` | `#FEF3C7` | Background avvisi |
| `color-error` | `#EF4444` | Errori, azioni distruttive |
| `color-error-light` | `#FEE2E2` | Background errori |
| `color-info` | `#3B82F6` | Informazioni, tooltip |
| `color-info-light` | `#DBEAFE` | Background info |

### 2.4 Contrasto e Accessibilita

- Tutti i testi su sfondo bianco: minimo **WCAG AA** (4.5:1 per body, 3:1 per testi grandi)
- `color-primary-500` (#00C896) su bianco = **3.1:1** → usare solo per testi grandi (>18px) o elementi grafici
- Per testo piccolo su bianco usare `color-primary-700` (#008866) = **5.4:1** ✅
- CTA primaria: testo bianco su `color-primary-500` = **3.1:1** → usare testo bold ≥16px, oppure testo su `color-primary-700`

---

## 3. Tipografia

### 3.1 Font Family

| Ruolo | Font | Fallback | Motivo |
|-------|------|----------|--------|
| **Heading** | Inter | system-ui, sans-serif | Leggibile, moderno, ottimo su mobile |
| **Body** | Inter | system-ui, sans-serif | Consistenza, ampio supporto lingue |
| **Monospace** | JetBrains Mono | monospace | Solo per codici/ID prenotazione |

> **Nota React Native:** usare `System` (San Francisco su iOS, Roboto su Android) per performance nativa. Inter solo per web.

### 3.2 Scala Tipografica

| Token | Size | Line Height | Weight | Uso |
|-------|------|-------------|--------|-----|
| `text-display` | 32px / 2rem | 40px / 1.25 | 700 | Titolo pagina principale |
| `text-h1` | 26px / 1.625rem | 34px / 1.3 | 700 | Titoli sezione |
| `text-h2` | 22px / 1.375rem | 30px / 1.36 | 600 | Sottotitoli |
| `text-h3` | 18px / 1.125rem | 26px / 1.44 | 600 | Card title, label importanti |
| `text-body-lg` | 17px / 1.0625rem | 26px / 1.53 | 400 | Body principale (mobile-first) |
| `text-body` | 15px / 0.9375rem | 24px / 1.6 | 400 | Body standard |
| `text-body-sm` | 13px / 0.8125rem | 20px / 1.54 | 400 | Caption, metadata |
| `text-label` | 14px / 0.875rem | 20px / 1.43 | 500 | Label form, tab, chip |
| `text-button` | 16px / 1rem | 24px / 1.5 | 600 | Testo pulsanti |
| `text-overline` | 12px / 0.75rem | 16px / 1.33 | 600 | Overline, badge, tag |

> **Regola accessibilita:** body text mai sotto 15px. Per il target cleaner, preferire `text-body-lg` (17px) come default.

---

## 4. Spaziatura e Layout

### 4.1 Scala Spaziatura (4px base)

| Token | Valore | Uso tipico |
|-------|--------|------------|
| `space-1` | 4px | Micro-gap (icona-testo inline) |
| `space-2` | 8px | Gap tra elementi correlati |
| `space-3` | 12px | Padding interno badge/chip |
| `space-4` | 16px | Padding card, gap lista |
| `space-5` | 20px | Padding orizzontale schermo |
| `space-6` | 24px | Separazione sezioni interne |
| `space-8` | 32px | Separazione tra sezioni |
| `space-10` | 40px | Padding verticale hero |
| `space-12` | 48px | Spazio prima di CTA bottom |
| `space-16` | 64px | Bottom safe area (con tab bar) |

### 4.2 Grid e Breakpoint

| Breakpoint | Larghezza | Colonne | Margine | Gutter |
|------------|-----------|---------|---------|--------|
| **Mobile** | < 640px | 4 | 20px | 16px |
| **Tablet** | 640–1024px | 8 | 32px | 24px |
| **Desktop** | > 1024px | 12 | auto (max 1200px) | 24px |

### 4.3 Safe Areas

- **Top:** rispettare status bar + notch (env safe-area-inset-top)
- **Bottom:** 34px su iPhone con home indicator + altezza tab bar (56px)
- **Tap target minimo:** 48x48px (raccomandato 56px per target poco digitalizzato)

---

## 5. Border Radius e Elevazione

### 5.1 Border Radius

| Token | Valore | Uso |
|-------|--------|-----|
| `radius-none` | 0px | Divider, elementi full-width |
| `radius-sm` | 6px | Badge, chip, input |
| `radius-md` | 12px | Card, bottom sheet |
| `radius-lg` | 16px | Modale, immagini profilo |
| `radius-xl` | 24px | FAB, pulsanti pill |
| `radius-full` | 9999px | Avatar, indicatori |

### 5.2 Elevazione (Shadow)

| Token | CSS Shadow | Uso |
|-------|-----------|-----|
| `shadow-none` | none | Flat elements |
| `shadow-xs` | `0 1px 2px rgba(0,0,0,0.05)` | Card a riposo |
| `shadow-sm` | `0 2px 4px rgba(0,0,0,0.08)` | Card hover, input focus |
| `shadow-md` | `0 4px 12px rgba(0,0,0,0.1)` | Dropdown, popover |
| `shadow-lg` | `0 8px 24px rgba(0,0,0,0.12)` | Bottom sheet, modale |
| `shadow-xl` | `0 16px 48px rgba(0,0,0,0.16)` | Overlay a tutto schermo |

> **React Native:** usare `elevation` (Android) + `shadowOffset/shadowOpacity` (iOS) con valori equivalenti.

---

## 6. Iconografia

### 6.1 Set Consigliato

**Libreria:** Phosphor Icons (MIT, disponibile per React + React Native)

| Motivo | Dettaglio |
|--------|-----------|
| Stile coerente | Linea pulita, peso regolabile |
| Leggibilita | Tratto spesso (bold) per target accessibilita |
| Copertura | Include icone domestiche (scopa, secchio, casa) |
| Multi-piattaforma | Package per React e React Native |

### 6.2 Specifiche

| Proprieta | Valore |
|-----------|--------|
| Dimensione default | 24px |
| Dimensione tocco | 20px icona dentro target 48px |
| Peso | Bold (per chiarezza su mobile) |
| Colore default | `color-neutral-500` |
| Colore attivo | `color-primary-500` |
| Sempre con label | Si, mai icona sola per azioni critiche |

### 6.3 Icone Chiave dell'App

| Azione | Icona Phosphor |
|--------|---------------|
| Home | `House` |
| Cerca | `MagnifyingGlass` |
| Prenotazioni | `CalendarCheck` |
| Profilo | `UserCircle` |
| Pulizia | `Broom` |
| Posizione | `MapPin` |
| Pagamento | `CreditCard` |
| Chat/Supporto | `ChatCircle` |
| Stella/Recensione | `Star` |
| Conferma | `CheckCircle` |
| Errore | `XCircle` |
| Indietro | `ArrowLeft` |

---

## 7. Componenti UI

### 7.1 Pulsanti

#### Varianti

| Variante | Background | Testo | Bordo | Uso |
|----------|-----------|-------|-------|-----|
| **Primary** | `primary-500` | `#FFFFFF` | nessuno | CTA principale (1 per schermata) |
| **Secondary** | `transparent` | `primary-500` | `primary-500` 1.5px | Azione secondaria |
| **Tertiary** | `transparent` | `primary-700` | nessuno | Azione meno importante |
| **Destructive** | `error` | `#FFFFFF` | nessuno | Cancellazione, eliminazione |
| **Disabled** | `neutral-100` | `neutral-300` | nessuno | Non disponibile |

#### Dimensioni

| Size | Altezza | Padding H | Font | Radius |
|------|---------|-----------|------|--------|
| **Large** | 56px | 24px | `text-button` (16px) | `radius-xl` |
| **Medium** | 48px | 20px | `text-button` (16px) | `radius-lg` |
| **Small** | 40px | 16px | `text-label` (14px) | `radius-md` |

> **Default mobile: Large** (56px) — facilita il tocco per utenti meno esperti.

#### Stati

| Stato | Trasformazione |
|-------|---------------|
| Default | Come da variante |
| Pressed | Opacity 0.85 + scala 0.98 (feedback tattile) |
| Loading | Spinner bianco centrato, testo nascosto |
| Disabled | Opacity 0.5, non cliccabile |

### 7.2 Input di Testo

| Proprieta | Valore |
|-----------|--------|
| Altezza | 52px (touch-friendly) |
| Padding | 16px orizzontale |
| Background | `neutral-0` (bianco) |
| Bordo default | `neutral-200` 1.5px |
| Bordo focus | `primary-500` 2px |
| Bordo errore | `error` 2px |
| Radius | `radius-sm` (6px) |
| Font input | `text-body-lg` (17px) |
| Label | Sopra l'input, `text-label`, `neutral-600` |
| Placeholder | `text-body-lg`, `neutral-200` |
| Helper text | Sotto l'input, `text-body-sm`, `neutral-400` |
| Error text | Sotto l'input, `text-body-sm`, `error` |

#### Pattern Accessibilita

- Label **sempre** visibile (no floating label — confonde utenti poco esperti)
- Icona a sinistra opzionale per contesto (es. MapPin per indirizzo)
- Messaggio errore con icona `WarningCircle` + testo descrittivo
- Autocompletamento attivo dove possibile (indirizzo, citta)

### 7.3 Card

| Proprieta | Valore |
|-----------|--------|
| Background | `neutral-0` |
| Bordo | `neutral-100` 1px |
| Shadow | `shadow-xs` |
| Radius | `radius-md` (12px) |
| Padding | `space-4` (16px) |
| Gap interno | `space-3` (12px) |

#### Card Servizio (esempio)

```
┌─────────────────────────────┐
│ [Foto profilo]  Nome        │
│  ★ 4.8 (123)   €15/ora     │
│                             │
│  🧹 Pulizia generale       │
│  📍 Milano, 2.3 km         │
│                             │
│  [ Prenota ora ]            │
└─────────────────────────────┘
```

### 7.4 Bottom Sheet

| Proprieta | Valore |
|-----------|--------|
| Background | `neutral-0` |
| Radius top | `radius-lg` (16px) |
| Shadow | `shadow-lg` |
| Handle | 40x5px, `neutral-200`, centrato, `radius-full` |
| Overlay | `neutral-900` con opacity 0.4 |
| Padding | `space-5` (20px) orizzontale, `space-6` (24px) top |

### 7.5 Tab Bar (Bottom Navigation)

| Proprieta | Valore |
|-----------|--------|
| Altezza | 56px + safe area bottom |
| Background | `neutral-0` |
| Shadow top | `0 -1px 4px rgba(0,0,0,0.06)` |
| Item | Icona 24px + label `text-overline` |
| Inattivo | `neutral-300` |
| Attivo | `primary-500` |
| Items | 4 max: Home, Cerca, Prenotazioni, Profilo |

### 7.6 Status Pills — Legenda

Sistema di badge per comunicare lo stato delle prenotazioni e informazioni temporali. Ogni colore corrisponde a una categoria semantica precisa.

**Logica colori:**
- **Giallo (ambra)** = aspetti qualcun altro
- **Blu** = tocca a te, azione richiesta
- **Verde pieno** = tutto ok, confermato
- **Verde muted** = completato con successo
- **Rosso** = problema, annullamento, scadenza
- **Blu info** = informazione temporale (quando)

#### Stati prenotazione

| Pill | Background | Testo | Categoria | Significato |
|------|-----------|-------|-----------|-------------|
| **In attesa** | `#FEF3C7` | `#854F0B` | Attesa | Richiesta inviata, in attesa di risposta cleaner |
| **Da pagare** | `#DBEAFE` | `#1D4ED8` | Azione richiesta | L'utente deve completare il pagamento |
| **Confermata** | `#ECFCCB` | `#3B6D11` | Confermato | Cleaner ha accettato, prossimo step automatico |
| **Pagato** | `#ECFCCB` | `#3B6D11` | Confermato | Pagamento ricevuto (Instant Booking) |
| **Completato** | `#F0FBF7` | `#006B50` | Completato | Servizio terminato con successo |
| **Rifiutato** | `#FEE2E2` | `#A32D2D` | Negativo | Cleaner ha rifiutato la richiesta |
| **Annullato** | `#FEE2E2` | `#A32D2D` | Negativo | Prenotazione annullata da utente |
| **Scaduto** | `#FEE2E2` | `#A32D2D` | Negativo | Pagamento non completato in tempo |

#### Badge temporali

| Pill | Background | Testo | Esempio |
|------|-----------|-------|---------|
| **Timing** | `#DBEAFE` | `#1D4ED8` | Domani, Oggi, Tra 2h, Tra 45 min |

#### Specifiche UI

| Proprieta | Valore |
|-----------|--------|
| Font | Inter Medium, 11-12px |
| Padding | 4px 10px |
| Border radius | 6px |
| Altezza | 22px |

### 7.6b Filtro Chip

| Variante | Background | Testo | Radius |
|----------|-----------|-------|--------|
| **Filtro** | `neutral-50` | `neutral-600` | `radius-sm` |
| **Filtro attivo** | `primary-500` | `#FFFFFF` | `radius-sm` |

### 7.7 Lista / List Item

| Proprieta | Valore |
|-----------|--------|
| Altezza minima | 56px |
| Padding | `space-4` (16px) orizzontale |
| Divider | `neutral-100` 1px, inset 16px da sinistra |
| Icona sinistra | 24px, `neutral-400` |
| Chevron destra | `CaretRight`, `neutral-300` |
| Tap feedback | Background `neutral-50` |

### 7.8 Avatar

| Size | Dimensione | Radius | Uso |
|------|-----------|--------|-----|
| **Small** | 32px | `radius-full` | Lista, chat |
| **Medium** | 48px | `radius-full` | Card servizio |
| **Large** | 80px | `radius-full` | Profilo, dettaglio cleaner |
| **XL** | 120px | `radius-full` | Profilo proprio |

Fallback: iniziali su sfondo `primary-100`, testo `primary-700`.

### 7.9 Toast / Snackbar

| Proprieta | Valore |
|-----------|--------|
| Posizione | Top, sotto status bar |
| Background | `neutral-700` |
| Testo | `#FFFFFF`, `text-body` |
| Radius | `radius-md` |
| Durata | 4 secondi |
| Icona | A sinistra, semantica (CheckCircle, XCircle, Info) |
| Azione | Link testuale opzionale ("Annulla") |

---

## 8. Pattern di Navigazione

### 8.1 Struttura Navigazione

```
Tab Bar (bottom)
├── Home
│   ├── Servizi consigliati
│   └── Prenotazioni recenti
├── Cerca
│   ├── Filtri (bottom sheet)
│   └── Risultati → Dettaglio cleaner → Prenota
├── Prenotazioni
│   ├── In arrivo
│   ├── Passate
│   └── Dettaglio prenotazione
└── Profilo
    ├── Dati personali
    ├── Metodi pagamento
    ├── Indirizzi
    └── Supporto
```

### 8.2 Regole di Navigazione

- **Back button:** sempre presente (tranne su tab root)
- **Gestural navigation:** supportata ma non unica via (pulsante sempre visibile)
- **Deep link:** ogni schermata raggiungibile via URL
- **No hamburger menu:** utenti poco esperti non lo trovano
- **No swipe nascosto:** ogni azione accessibile con tap esplicito

---

## 9. Animazioni e Transizioni

| Tipo | Durata | Easing | Uso |
|------|--------|--------|-----|
| Micro-interazione | 150ms | ease-out | Toggle, check, ripple |
| Transizione UI | 250ms | ease-in-out | Sheet apertura, card espansione |
| Navigazione | 300ms | ease-in-out | Push/pop schermata |
| Feedback touch | 100ms | ease-out | Scala 0.98 su press |
| Skeleton loader | 1.5s loop | linear | Shimmer durante caricamento |

> **Regola:** nessuna animazione deve ritardare l'interazione. Skeleton loader al posto di spinner dove possibile (riduce ansia da attesa).

---

## 10. Pattern di Accessibilita

### 10.1 Checklist Obbligatoria

| Requisito | Dettaglio |
|-----------|-----------|
| Contrasto testi | AA minimo (4.5:1 body, 3:1 heading) |
| Tap target | Minimo 48x48px |
| Font size minimo | 13px (caption), 15px (body) |
| Icone | Sempre con label testuale per azioni |
| Errori form | Colore + icona + testo (mai solo colore) |
| Focus visible | Outline 2px `primary-500` offset 2px |
| Screen reader | Tutti i componenti con accessibilityLabel |
| Riduzione movimento | Rispettare `prefers-reduced-motion` |
| Orientamento | Supportare portrait e landscape |

### 10.2 Pattern per Utenti Poco Digitalizzati

| Problema | Soluzione |
|----------|----------|
| Non capiscono le icone | Icona + label sempre |
| Non trovano le azioni | CTA grande e centrale, colore forte |
| Si perdono nella navigazione | Breadcrumb o stepper visibile |
| Non capiscono gli errori | Linguaggio semplice, azione suggerita |
| Paura di sbagliare | Conferma prima di azioni irreversibili |
| Non sanno lo stato | Feedback immediato (loading, success, error) |

---

## 11. Design Token — Formato Esportazione

### 11.1 CSS Custom Properties

```css
:root {
  /* Colors - Primary */
  --color-primary-50: #E6FFF5;
  --color-primary-100: #B3FFE0;
  --color-primary-200: #80FFCC;
  --color-primary-300: #4DFFB8;
  --color-primary-400: #1AFFA3;
  --color-primary-500: #00C896;
  --color-primary-600: #00A87E;
  --color-primary-700: #008866;
  --color-primary-800: #00684E;
  --color-primary-900: #004836;

  /* Colors - Neutral */
  --color-neutral-0: #FFFFFF;
  --color-neutral-50: #F7F8FA;
  --color-neutral-100: #EBEDF0;
  --color-neutral-200: #D1D5DB;
  --color-neutral-300: #9CA3AF;
  --color-neutral-400: #6B7280;
  --color-neutral-500: #4B5563;
  --color-neutral-600: #374151;
  --color-neutral-700: #1F2937;
  --color-neutral-800: #111827;
  --color-neutral-900: #030712;

  /* Colors - Semantic */
  --color-success: #10B981;
  --color-success-light: #D1FAE5;
  --color-warning: #F59E0B;
  --color-warning-light: #FEF3C7;
  --color-error: #EF4444;
  --color-error-light: #FEE2E2;
  --color-info: #3B82F6;
  --color-info-light: #DBEAFE;

  /* Typography */
  --font-family-base: 'Inter', system-ui, -apple-system, sans-serif;
  --font-family-mono: 'JetBrains Mono', monospace;

  /* Spacing */
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 12px;
  --space-4: 16px;
  --space-5: 20px;
  --space-6: 24px;
  --space-8: 32px;
  --space-10: 40px;
  --space-12: 48px;
  --space-16: 64px;

  /* Radius */
  --radius-none: 0px;
  --radius-sm: 6px;
  --radius-md: 12px;
  --radius-lg: 16px;
  --radius-xl: 24px;
  --radius-full: 9999px;

  /* Shadows */
  --shadow-xs: 0 1px 2px rgba(0,0,0,0.05);
  --shadow-sm: 0 2px 4px rgba(0,0,0,0.08);
  --shadow-md: 0 4px 12px rgba(0,0,0,0.1);
  --shadow-lg: 0 8px 24px rgba(0,0,0,0.12);
  --shadow-xl: 0 16px 48px rgba(0,0,0,0.16);
}
```

---

## 12. Linee Guida React Native — Implementazione Mobile

### 12.1 Architettura Token

```
src/
├── design-system/
│   ├── tokens/
│   │   ├── colors.ts          # Palette completa
│   │   ├── typography.ts      # Scale tipografiche
│   │   ├── spacing.ts         # Scala spaziatura
│   │   └── index.ts           # Re-export unico
│   ├── components/
│   │   ├── Button/
│   │   │   ├── Button.tsx
│   │   │   ├── Button.styles.ts
│   │   │   └── Button.test.tsx
│   │   ├── Input/
│   │   ├── Card/
│   │   ├── Avatar/
│   │   ├── Badge/
│   │   ├── BottomSheet/
│   │   ├── ListItem/
│   │   ├── Toast/
│   │   └── index.ts
│   └── theme/
│       ├── theme.ts           # Tema unificato
│       └── ThemeProvider.tsx   # Context provider
```

### 12.2 Token TypeScript

```typescript
// tokens/colors.ts
export const colors = {
  primary: {
    50: '#E6FFF5',
    100: '#B3FFE0',
    200: '#80FFCC',
    300: '#4DFFB8',
    400: '#1AFFA3',
    500: '#00C896',
    600: '#00A87E',
    700: '#008866',
    800: '#00684E',
    900: '#004836',
  },
  neutral: {
    0: '#FFFFFF',
    50: '#F7F8FA',
    100: '#EBEDF0',
    200: '#D1D5DB',
    300: '#9CA3AF',
    400: '#6B7280',
    500: '#4B5563',
    600: '#374151',
    700: '#1F2937',
    800: '#111827',
    900: '#030712',
  },
  success: '#10B981',
  successLight: '#D1FAE5',
  warning: '#F59E0B',
  warningLight: '#FEF3C7',
  error: '#EF4444',
  errorLight: '#FEE2E2',
  info: '#3B82F6',
  infoLight: '#DBEAFE',
} as const;

// tokens/spacing.ts
export const spacing = {
  1: 4,
  2: 8,
  3: 12,
  4: 16,
  5: 20,
  6: 24,
  8: 32,
  10: 40,
  12: 48,
  16: 64,
} as const;

// tokens/typography.ts
import { Platform } from 'react-native';

const fontFamily = Platform.select({
  ios: 'System',
  android: 'Roboto',
  default: 'Inter',
});

export const typography = {
  display: {
    fontFamily,
    fontSize: 32,
    lineHeight: 40,
    fontWeight: '700' as const,
  },
  h1: {
    fontFamily,
    fontSize: 26,
    lineHeight: 34,
    fontWeight: '700' as const,
  },
  h2: {
    fontFamily,
    fontSize: 22,
    lineHeight: 30,
    fontWeight: '600' as const,
  },
  h3: {
    fontFamily,
    fontSize: 18,
    lineHeight: 26,
    fontWeight: '600' as const,
  },
  bodyLg: {
    fontFamily,
    fontSize: 17,
    lineHeight: 26,
    fontWeight: '400' as const,
  },
  body: {
    fontFamily,
    fontSize: 15,
    lineHeight: 24,
    fontWeight: '400' as const,
  },
  bodySm: {
    fontFamily,
    fontSize: 13,
    lineHeight: 20,
    fontWeight: '400' as const,
  },
  label: {
    fontFamily,
    fontSize: 14,
    lineHeight: 20,
    fontWeight: '500' as const,
  },
  button: {
    fontFamily,
    fontSize: 16,
    lineHeight: 24,
    fontWeight: '600' as const,
  },
  overline: {
    fontFamily,
    fontSize: 12,
    lineHeight: 16,
    fontWeight: '600' as const,
  },
} as const;

// tokens/radius.ts
export const radius = {
  none: 0,
  sm: 6,
  md: 12,
  lg: 16,
  xl: 24,
  full: 9999,
} as const;
```

### 12.3 Theme Provider

```typescript
// theme/theme.ts
import { colors } from '../tokens/colors';
import { spacing } from '../tokens/spacing';
import { typography } from '../tokens/typography';
import { radius } from '../tokens/radius';

export const theme = {
  colors,
  spacing,
  typography,
  radius,
  shadows: {
    xs: {
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 1 },
      shadowOpacity: 0.05,
      shadowRadius: 2,
      elevation: 1,
    },
    sm: {
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.08,
      shadowRadius: 4,
      elevation: 2,
    },
    md: {
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 4 },
      shadowOpacity: 0.1,
      shadowRadius: 12,
      elevation: 4,
    },
    lg: {
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 8 },
      shadowOpacity: 0.12,
      shadowRadius: 24,
      elevation: 8,
    },
  },
} as const;

export type Theme = typeof theme;
```

### 12.4 Componente Button (esempio implementativo)

```typescript
// components/Button/Button.tsx
import React from 'react';
import {
  TouchableOpacity,
  Text,
  ActivityIndicator,
  StyleSheet,
  ViewStyle,
  TextStyle,
} from 'react-native';
import { theme } from '../../theme/theme';

type ButtonVariant = 'primary' | 'secondary' | 'tertiary' | 'destructive';
type ButtonSize = 'large' | 'medium' | 'small';

interface ButtonProps {
  label: string;
  onPress: () => void;
  variant?: ButtonVariant;
  size?: ButtonSize;
  loading?: boolean;
  disabled?: boolean;
  icon?: React.ReactNode;
  accessibilityHint?: string;
}

export function Button({
  label,
  onPress,
  variant = 'primary',
  size = 'large',
  loading = false,
  disabled = false,
  icon,
  accessibilityHint,
}: ButtonProps) {
  const isDisabled = disabled || loading;

  return (
    <TouchableOpacity
      onPress={onPress}
      disabled={isDisabled}
      activeOpacity={0.85}
      accessibilityRole="button"
      accessibilityLabel={label}
      accessibilityHint={accessibilityHint}
      accessibilityState={{ disabled: isDisabled, busy: loading }}
      style={[
        styles.base,
        sizeStyles[size],
        variantStyles[variant],
        isDisabled && styles.disabled,
      ]}
    >
      {loading ? (
        <ActivityIndicator
          color={variant === 'primary' ? '#FFFFFF' : theme.colors.primary[500]}
        />
      ) : (
        <>
          {icon}
          <Text
            style={[
              styles.label,
              variantTextStyles[variant],
              size === 'small' && styles.labelSmall,
            ]}
          >
            {label}
          </Text>
        </>
      )}
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  base: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: theme.spacing[2],
  },
  disabled: {
    opacity: 0.5,
  },
  label: {
    ...theme.typography.button,
  },
  labelSmall: {
    ...theme.typography.label,
  },
});

const sizeStyles: Record<ButtonSize, ViewStyle> = {
  large: {
    height: 56,
    paddingHorizontal: theme.spacing[6],
    borderRadius: theme.radius.xl,
  },
  medium: {
    height: 48,
    paddingHorizontal: theme.spacing[5],
    borderRadius: theme.radius.lg,
  },
  small: {
    height: 40,
    paddingHorizontal: theme.spacing[4],
    borderRadius: theme.radius.md,
  },
};

const variantStyles: Record<ButtonVariant, ViewStyle> = {
  primary: {
    backgroundColor: theme.colors.primary[500],
  },
  secondary: {
    backgroundColor: 'transparent',
    borderWidth: 1.5,
    borderColor: theme.colors.primary[500],
  },
  tertiary: {
    backgroundColor: 'transparent',
  },
  destructive: {
    backgroundColor: theme.colors.error,
  },
};

const variantTextStyles: Record<ButtonVariant, TextStyle> = {
  primary: { color: '#FFFFFF' },
  secondary: { color: theme.colors.primary[500] },
  tertiary: { color: theme.colors.primary[700] },
  destructive: { color: '#FFFFFF' },
};
```

### 12.5 Regole Implementative React Native

| Area | Regola |
|------|--------|
| **Font** | Usare font di sistema (`System`/`Roboto`), non caricare Inter |
| **Navigazione** | React Navigation con `@react-navigation/bottom-tabs` |
| **Bottom Sheet** | `@gorhom/bottom-sheet` (gesture-based, performante) |
| **Icone** | `phosphor-react-native` |
| **Animazioni** | `react-native-reanimated` per 60fps |
| **Safe Area** | `react-native-safe-area-context` ovunque |
| **Haptics** | `expo-haptics` su press button e azioni completate |
| **Skeleton** | `react-native-skeleton-placeholder` per loading |
| **Storage** | `@react-native-async-storage/async-storage` |
| **Form** | `react-hook-form` + `zod` per validazione |

### 12.6 Performance Mobile

| Pratica | Motivo |
|---------|--------|
| `FlatList` sempre (mai `ScrollView` per liste) | Virtualizzazione memoria |
| `React.memo` su ListItem/Card | Evitare re-render |
| Immagini via `expo-image` o `FastImage` | Cache nativa, placeholder |
| Bundle < 5MB iniziale | Target device bassa gamma |
| Skeleton loader (no spinner) | Percezione velocita |

### 12.7 Cross-Platform (React Web ↔ React Native)

| Strategia | Dettaglio |
|-----------|-----------|
| **Token condivisi** | Stesso file `colors.ts`, `spacing.ts` per entrambe le piattaforme |
| **Componenti separati** | UI diversa per web e mobile (no `react-native-web` forzato) |
| **Logica condivisa** | Hook custom, API client, validazione — in package shared |
| **Monorepo** | Turborepo o Nx con `packages/shared`, `apps/web`, `apps/mobile` |

```
trovapulizie/
├── packages/
│   ├── shared/           # Logica, token, types, API client
│   │   ├── tokens/
│   │   ├── hooks/
│   │   ├── api/
│   │   └── types/
│   ├── ui-web/           # Componenti React web
│   └── ui-mobile/        # Componenti React Native
├── apps/
│   ├── web/              # Next.js / Vite app
│   └── mobile/           # Expo / React Native app
├── package.json
└── turbo.json
```

---

## 13. Schermate Chiave — Wireframe Strutturale

### 13.1 Home (Cliente)

```
┌──────────────────────────────┐
│ 📍 Milano, Via Roma 12    ⚙️ │  ← Header con indirizzo
│──────────────────────────────│
│                              │
│  Ciao, Marco! 👋            │  ← Saluto personalizzato
│  Di cosa hai bisogno?        │
│                              │
│  ┌──────┐ ┌──────┐ ┌──────┐ │
│  │ 🧹   │ │ 🪟   │ │ 🏠   │ │  ← Categorie servizio
│  │Pulizia│ │Vetri │ │Fondo │ │
│  └──────┘ └──────┘ └──────┘ │
│                              │
│  Consigliati per te          │
│  ┌─────────────────────────┐ │
│  │ [Foto] Maria R.  ★ 4.9 │ │  ← Card cleaner
│  │ Pulizia casa • €16/h    │ │
│  │ [ Prenota ]             │ │
│  └─────────────────────────┘ │
│  ┌─────────────────────────┐ │
│  │ [Foto] Luca T.   ★ 4.7 │ │
│  │ Pulizia ufficio • €18/h │ │
│  │ [ Prenota ]             │ │
│  └─────────────────────────┘ │
│                              │
│──────────────────────────────│
│ 🏠Home  🔍Cerca  📅Pren  👤 │  ← Tab bar
└──────────────────────────────┘
```

### 13.2 Flusso Prenotazione (Stepper)

```
Step 1/4          Step 2/4          Step 3/4          Step 4/4
Servizio          Data e Ora        Indirizzo         Conferma
─────●────────    ──────●───────    ──────●───────    ──────●──

[Radio]           [Calendario]      [Input indirizzo]  Riepilogo:
○ Pulizia casa    │ Mar 15 │        Via Roma 12        • Pulizia casa
● Pulizia ufficio │ Mer 16 │        Milano             • Maria R.
○ Pulizia vetri   │ Gio 17✓│        Piano: 3           • Gio 17, 10:00
                  Ore: 10:00        Citofono: Rossi    • €48 (3h)

[ Avanti → ]      [ Avanti → ]      [ Avanti → ]      [ Conferma ✓ ]
```

---

## 14. Checklist Pre-Lancio Design

- [ ] Tutti i colori testati con simulatore daltonismo
- [ ] Tap target >= 48px verificati su device reale
- [ ] Font size minimo 15px per body verificato
- [ ] Ogni schermata testata con VoiceOver/TalkBack
- [ ] Loading state presente su ogni azione asincrona
- [ ] Error state con messaggio chiaro su ogni form
- [ ] Empty state con illustrazione e CTA su ogni lista
- [ ] Offline state gestito (messaggio + retry)
- [ ] Test con utenti target (cleaner 45-60 anni)
- [ ] Performance: FCP < 1.5s, TTI < 3s su 3G