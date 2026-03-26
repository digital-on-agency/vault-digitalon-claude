<!-- ultimo aggiornamento: 2026-03-26 -->

# Componenti UI — Pattern ricorrenti

## Principi generali

- Ogni componente deve funzionare in isolamento e in composizione
- Stato vuoto (empty state) sempre gestito — mai una pagina bianca
- Feedback visivo immediato su ogni interazione utente
- Area touch minima 44x44px su mobile

## Icone — dimensioni

### Regole generali
- Touch target minimo: **44x44px** indipendentemente dalla dimensione dell'icona
- Mantenere size consistenti in tutta l'interfaccia per contesto d'uso
- Icone troppo piccole impattano l'accessibilità per utenti con deficit visivi

### Mobile

| Contesto | Size | Note |
|----------|------|------|
| Tab bar (iOS) | 30px (60px @2x) | Icona dentro touch target 44x44px |
| Tab bar (Android) | 24px | Material Design standard |
| Navigazione | 24-30px | Touch target almeno 44x44px |
| Icone UI generiche | 30-50px | Range consigliato mobile |
| App icon (iOS) | 180px (iPhone), 152px (iPad) | PNG trasparente, aspect ratio 1:1 |
| App icon (Android) | 192px | PNG trasparente, aspect ratio 1:1 |

### Desktop

| Contesto | Size | Note |
|----------|------|------|
| Menu e inline | 16-24px | Icone piccole accanto a testo |
| Toolbar | 24-48px | Dipende dalla densità dell'interfaccia |
| Applicazione | 16-256px | Varia per OS e contesto |
| Notifiche | 16-32px | Piccole ma distinguibili |
| File type | 16-32px | Icone in file explorer/liste |

### Scale consigliate per design system

Per un design system coerente, definire 4 size standard:

| Token | Mobile | Desktop | Uso tipico |
|-------|--------|---------|------------|
| `icon-xs` | 16px | 16px | Inline con testo, indicatori |
| `icon-sm` | 20px | 20px | Menu, liste, badge |
| `icon-md` | 24px | 24px | Toolbar, navigation, default |
| `icon-lg` | 32px | 32px | Card, empty state, CTA |

Dentro un bottone: l'icona segue il size del bottone — SM usa `icon-sm` (20px), MD usa `icon-md` (24px), LG usa `icon-lg` (32px).

## Navigation

### Quale tipo scegliere

| Tipo | Quando usarlo | Non usarlo quando |
|------|--------------|-------------------|
| Top bar | Siti/app con poche sezioni (5-7 voci), contenuto prevalentemente testuale | Mobile con molte sezioni — difficile da raggiungere con il pollice |
| Sidebar | Dashboard, app con molte sezioni, contenuto ricco di immagini/video | Siti semplici con poche pagine |
| Bottom nav | App mobile, azioni principali frequenti | Desktop, o quando le azioni sono > 5 |
| Breadcrumb | Gerarchia 3+ livelli, e-commerce, contenuti annidati | Pagine di primo livello, app flat |
| Dropdown | Molte feature/sottosezioni da raggruppare | Azioni primarie — l'utente non le scopre |

### Top Navigation Bar
- Logo a sinistra, nav links al centro o a destra, azioni utente (avatar/logout) a destra
- Su mobile: collassa in hamburger menu o si sostituisce con bottom navigation
- Evidenziare pagina attiva con colore o underline
- Max 5-7 voci visibili, il resto in dropdown "Altro"

### Sidebar Navigation
- Usare per app/dashboard con molte sezioni
- Icona + label per ogni voce, collapsabile su schermi piccoli
- Gruppi logici separati da divider o heading di sezione
- Stato attivo: background colorato + testo bold
- Su mobile: hidden by default, aperta con hamburger o swipe

### Breadcrumb
- Usare quando la gerarchia ha 3+ livelli
- Formato: Home > Sezione > Pagina attuale (ultima non cliccabile)
- Non serve su pagine di primo livello

### Bottom Navigation (mobile)
- Max 5 icone, quella attiva evidenziata
- Solo per le azioni principali dell'app
- Icona + label breve sotto

### Label e icone nella navigazione
- Label brevi e descrittive — l'utente deve capire la destinazione senza cliccare
- Terminologia consistente in tutta l'app (non "Home" in una pagina e "Principale" in un'altra)
- Icone come supporto alle label, mai sostitutive (tranne bottom nav con icone universali)
- Tooltip solo per info supplementare, mai per label primarie

### Navigazione responsive
- **Desktop**: top bar o sidebar con tutte le voci visibili
- **Tablet**: top bar con voci ridotte + overflow in "Altro", oppure sidebar collapsabile
- **Mobile**: bottom nav (3-5 azioni) oppure hamburger menu. La navigazione deve adattarsi, non semplicemente rimpicciolirsi

## Card

### Card informativa
```
┌─────────────────────────┐
│ [Immagine/Cover]        │
│ Titolo                  │
│ Descrizione breve       │
│ Meta (data, tag, badge) │
└─────────────────────────┘
```
- Padding interno: 16px (mobile) / 24px (desktop)
- Border radius: 8-12px
- Shadow leggera per separazione dal background

### Card interattiva
- Hover: leggero rialzo shadow + cursor pointer
- Tutta la card cliccabile (wrap in link/button), non solo il titolo
- Se ci sono azioni interne (edit, delete), usare menu "..." per evitare conflitti click

### Card list vs Grid
- **List**: quando il contenuto è prevalentemente testuale, scansione verticale
- **Grid**: quando l'elemento visivo (immagine, icona) è dominante
- Su mobile: grid diventa stack verticale (1 colonna)

## Form

### Layout
- Un campo per riga su mobile, max 2 su desktop per campi correlati (nome + cognome)
- Label sempre sopra il campo, mai a sinistra (peggiore scansione)
- Raggruppare campi logicamente con fieldset o heading di sezione
- Bottone submit allineato a sinistra (dove finisce la lettura)

### Validazione
- Inline, al blur del campo (non al submit)
- Messaggio di errore sotto il campo, in rosso, con icona
- Non cancellare mai l'input dell'utente dopo un errore
- Indicare campi obbligatori con asterisco (*) nella label

### Input specifici
- **Password**: toggle show/hide, indicatore forza
- **Email**: validazione formato al blur
- **Telefono**: prefisso internazionale se necessario, formattazione automatica
- **Data**: date picker nativo o custom, formato locale visibile
- **File upload**: drag & drop + click, preview file selezionato, limite dimensione chiaro
- **Search**: icona lente, clear button (X), debounce 300ms

## Table / Data Display

### Table responsive
- Su desktop: table standard con header fisso su scroll
- Su mobile: card stack (ogni riga diventa una card) oppure scroll orizzontale con colonna fissa
- Sortable: icona freccia su colonne ordinabili
- Max 5-7 colonne visibili, il resto in expand row o colonne nascoste

### Paginazione
- Mostrare: pagina corrente, totale risultati, items per pagina
- Navigazione: prev/next + numeri pagina (mostrare max 5 numeri con ellipsis)
- Default: 10-25 items per pagina
- Alternativa: infinite scroll per feed/timeline (con skeleton loading)

### Filtri
- Sopra la tabella, inline o in pannello collapsabile
- Chip/tag per filtri attivi con X per rimuoverli
- "Rimuovi tutti i filtri" sempre visibile quando ci sono filtri attivi

## Modal / Dialog

- **Conferma**: titolo + messaggio + 2 azioni (annulla a sinistra, conferma a destra)
- **Form modal**: per creazione/modifica rapida senza cambiare pagina
- **Full-screen modal**: su mobile per form complessi
- Sempre: overlay scuro dietro, chiudi con Esc e click overlay, focus trap interno
- Non annidare modal dentro modal

## Dashboard

### Layout tipo
```
┌──────────────────────────────────┐
│ Header (titolo + filtri globali) │
├────────┬────────┬────────┬───────┤
│ KPI 1  │ KPI 2  │ KPI 3  │ KPI 4│
├────────┴────────┼────────┴───────┤
│ Chart grande    │ Lista/table    │
├─────────────────┼────────────────┤
│ Chart 2         │ Activity feed  │
└─────────────────┴────────────────┘
```

- KPI cards in alto: numero grande + label + trend (freccia su/giù + percentuale)
- Chart: titolo chiaro, legenda, tooltip su hover
- Griglia: CSS Grid con gap uniforme (16-24px)
- Skeleton loading per ogni blocco indipendente

## Empty State

Ogni lista, tabella, sezione che può essere vuota deve avere:
- Illustrazione o icona contestuale
- Titolo breve che spiega lo stato ("Nessun progetto ancora")
- Descrizione opzionale con suggerimento ("Crea il tuo primo progetto per iniziare")
- CTA primaria (bottone per l'azione suggerita)

## Loading State

- **Skeleton**: per contenuto strutturato (card, tabelle, profili). Stessa forma del contenuto finale.
- **Spinner**: per azioni puntuali (submit form, caricamento dati). Sempre con testo ("Caricamento...")
- **Progress bar**: per operazioni lunghe con progresso misurabile (upload, import)
- Non bloccare tutta la pagina — caricare sezioni indipendentemente
