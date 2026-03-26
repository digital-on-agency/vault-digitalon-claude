<!-- ultimo aggiornamento: 2026-03-26 -->

# UX Patterns — Flussi e stati comuni

## Onboarding

### Primo accesso
L'utente non conosce il prodotto. L'obiettivo è portarlo al primo momento di valore nel minor tempo possibile.

**Pattern efficaci:**
- **Progressive disclosure**: non mostrare tutto subito. Rivelare funzionalità man mano che servono
- **Empty state con CTA**: invece di una dashboard vuota, guidare l'utente all'azione ("Crea il tuo primo progetto")
- **Checklist di setup**: 3-5 step visibili con progresso (barra o check). L'utente vede quanto manca
- **Tooltip contestuali**: piccoli hint al primo uso di una funzionalità. Max 1 alla volta, chiudibili, non bloccanti

**Da evitare:**
- Tour forzati di 10 step che nessuno legge
- Richiesta di molti dati prima di mostrare valore
- Tutorial video come unica forma di onboarding

### Registrazione
- Campi minimi: email + password (il resto dopo)
- Social login se il target lo usa (Google per B2B, Google+Apple per consumer)
- Conferma email senza bloccare l'accesso — lasciare usare il prodotto e ricordare dopo

## Search e Filter

### Barra di ricerca
- Posizione: in alto, sempre visibile o a un click di distanza
- Placeholder: suggerire cosa cercare ("Cerca servizi, città...")
- Debounce 300ms per ricerca live
- Predictive search: suggerire termini mentre l'utente digita
- Auto-correzione typo per non bloccare l'utente su errori di battitura
- Risultati: mostrare subito con highlight del termine cercato
- Stato vuoto: "Nessun risultato per X. Prova con termini diversi."

### Filtri
- **Inline**: sopra i risultati per filtri principali (2-4 filtri)
- **Pannello laterale**: per molti filtri (e-commerce, marketplace)
- **Bottom sheet su mobile**: per filtri complessi

**Principi:**
- Mostrare conteggio risultati che si aggiorna in tempo reale
- Filtri attivi visibili come chip rimovibili
- "Rimuovi tutti" sempre disponibile
- Ricordare i filtri nella sessione (non reset al cambio pagina)

### Ordinamento
- Default sensato (rilevanza per search, recenti per liste)
- Dropdown per cambiare: "Più rilevanti", "Più recenti", "Prezzo crescente"
- Indicare chiaramente l'ordinamento attivo

## Flusso di prenotazione / checkout

### Struttura a step
```
1. Selezione servizio → 2. Data/ora → 3. Dati → 4. Conferma → 5. Pagamento → 6. Riepilogo
```

**Regole:**
- Mostrare a che step si trova l'utente (stepper/progress bar)
- Permettere di tornare indietro senza perdere i dati
- Riepilogo visibile prima del pagamento (cosa, quando, quanto)
- Conferma finale chiara: cosa succede adesso, email di conferma, prossimi step

**Ridurre l'abbandono:**
- Meno step possibili (combina dove ha senso)
- Salvare il progresso (se l'utente chiude e torna, riprendere da dove era)
- Mostrare il prezzo totale il prima possibile, non solo alla fine
- Guest checkout disponibile (no registrazione obbligatoria prima del pagamento)

## Error Handling

### Errori di form
- Inline, sotto il campo specifico
- Rosso + icona + testo che dice come correggere
- "Inserisci un'email valida" non "Errore nel campo email"
- Non cancellare l'input dell'utente

### Errori di sistema (500, timeout, rete)
- Messaggio umano: "Qualcosa è andato storto. Riprova tra qualche istante."
- Bottone "Riprova" quando possibile
- Non mostrare stack trace o codici errore tecnici all'utente
- Loggare il dettaglio tecnico lato server

### Errori 404
- Messaggio chiaro: "Pagina non trovata"
- Suggerire: link alla home, barra di ricerca, pagine principali
- Mantenere la navigazione del sito

### Errori di permesso (403)
- Spiegare perché l'accesso è negato
- Suggerire cosa fare: contattare admin, cambiare account, richiedere accesso

## Empty State

Ogni lista/tabella/sezione vuota deve comunicare:

1. **Cosa**: cosa dovrebbe esserci qui ("I tuoi progetti appariranno qui")
2. **Perché** è vuoto: prima volta, filtri troppo restrittivi, nessun risultato
3. **Come**: azione per popolare ("Crea il tuo primo progetto" con CTA)

```
┌────────────────────────────────┐
│         [Illustrazione]        │
│                                │
│    Nessun progetto ancora      │
│                                │
│  Crea il tuo primo progetto    │
│  per iniziare a organizzare    │
│  il tuo lavoro.                │
│                                │
│     [ + Nuovo progetto ]       │
└────────────────────────────────┘
```

### Empty state per filtri
Diverso dall'empty state iniziale:
- "Nessun risultato per i filtri selezionati"
- CTA: "Rimuovi filtri" oppure "Modifica la ricerca"

## Loading State

### Cosa usare e quando

| Durata attesa | Pattern | Esempio |
|--------------|---------|---------|
| < 300ms | Niente — non mostrare loader | Click su tab |
| 300ms - 1s | Spinner inline | Submit form |
| 1s - 5s | Skeleton screen | Caricamento pagina |
| > 5s | Progress bar + messaggio | Upload file, import dati |

### Skeleton screen
- Stessa struttura del contenuto finale (non un generico spinner)
- Animazione pulse/shimmer per indicare che sta caricando
- Caricare sezioni indipendentemente (la sidebar può essere pronta prima del contenuto)

### Feedback su azione
- Bottone submit: stato loading (spinner + testo "Salvataggio...") + disabilitare per evitare doppio click
- Azione completata: feedback positivo (toast "Salvato", check verde, cambio stato)
- Ottimistic UI: aggiornare l'interfaccia subito e sincronizzare in background (per azioni frequenti come like, toggle)

## Notifiche e feedback

### Toast / Snackbar
- In basso a destra (desktop) o in alto (mobile)
- Auto-dismiss dopo 5 secondi (tranne errori)
- Max 1-2 visibili contemporaneamente, stack verticale
- Azione opzionale ("Annulla", "Vedi dettagli")

### Conferma azione distruttiva
Sempre chiedere conferma per: eliminare, annullare, rimuovere accesso.
- Dialog modale con: "Sei sicuro di voler eliminare X? Questa azione non è reversibile."
- Bottone di conferma rosso/danger, testo esplicito ("Elimina", non "OK")
- Bottone annulla come default (focus su annulla, non su elimina)

### Feedback inline
- Successo: check verde + testo breve, scompare dopo 3s
- Salvataggio automatico: "Salvato" discreto vicino al campo, o icona cloud-check
