# Sitemap Schermate — Trovapulizie

## Struttura pagine Figma

| Pagina | Contenuto |
|--------|-----------|
| Styles & Cover | Token, colori, tipografia, spacing, radius, shadow |
| Components | Tutti i component set (mobile + desktop) |
| Searcher — Mobile | App mobile searcher |
| Searcher — Desktop | Portale web searcher |
| Cleaner — Mobile | App mobile cleaner |
| Cleaner — Desktop | Dashboard web cleaner |
| Admin — Desktop | Pannello admin |

---

## Searcher — Mobile (~20 schermate)

### Onboarding & Auth
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 1 | Welcome / Splash | Logo, tagline, CTA login/registrati | Da fare |
| 2 | Login | Email + password, social login, link registrazione | Da fare |
| 3 | Registrazione | Nome, email, password, conferma | Da fare |
| 4 | Verifica OTP | Input codice, resend, countdown | Da fare |

### Home & Discovery
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 5 | Home (attuale) | Greeting top bar, search bar, griglia 6 servizi, cleaner consigliati/vicini | Fatto |
| 5v2 | Home v2 — Dual Flow | Hero card Flow B (AI Match) + divider "oppure scegli tu" + griglia servizi + consigliati | Fatto |
| 5v2b | Home / Indirizzo Mancante | Click servizio senza indirizzo: toast warning + search bar highlight arancione + helper text + servizio selezionato (verde). Dopo indirizzo → risultati filtrati | Fatto |
| 6 | Notifiche | Lista notifiche (prenotazione, reminder, promo) | Da fare |

### Ricerca & Filtri
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 7 | Risultati ricerca | 5 card cleaner, search bar posizione + tasto filtri, 2 Instant Book | Fatto |
| 7b | Risultati ricerca / Caricamento | Skeleton card cleaner (4), spinner "Ricerca in corso...", hint centrato | Fatto |
| 7d | Risultati ricerca / Nessun Risultato | Empty state "Nessun risultato" + CTA "Rimuovi filtri" | Fatto |
| 8 | Filtri (Bottom Sheet) | Tipo di servizio (chip), range prezzo (min/max), rating minimo (chip stelle), disponibilità (chip) | Fatto |
| 9 | Profilo cleaner | Avatar, rating 4.8, bio, chip servizi, recensione, CTA sticky "Prenota ora" | Fatto |
| 9b | Profilo cleaner / Caricamento | Skeleton fedele al profilo (hero, bio, servizi chip, recensione, CTA) | Fatto |

### Prenotazione (stepper)
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 10 | Step 1 — Servizio | Stepper + 6 servizi (radio card) + sezione add-on (Pulizia vetri, Stiratura, Pulizia balcone). Servizio pre-selezionato se utente arriva da ricerca/griglia servizi | Fatto |
| 11 | Step 2 — Data/Ora | Stepper + calendario compatto (mese) + fasce orarie (chip 2 righe) | Fatto |
| 12 | Step 3 — Dettagli | Stepper + indirizzo, durata (chip), piano/interno, note | Fatto |
| 13a | Step 4 — Conferma (Flow A) | Riepilogo: cleaner card, dettagli, note, breakdown prezzo, totale, CTA "Paga — €72" | Fatto |
| 13b | Step 4 — Proposta Match (Flow B) | Match AI con proposta cleaner + accetta/rifiuta | Da fare |
| 13d | Pagamento | Riepilogo ordine (cleaner, servizio, totale €72) + form Stripe embedded (email, carta, scadenza/CVC) + CTA "Paga €72" + "Pagamento sicuro con Stripe" | Fatto |
| 13e | Pagamento / Caricamento | Spinner verde centrato + "Elaborazione in corso..." + "Non chiudere questa pagina" + footer Stripe | Fatto |
| 13f | Pagamento / Fallito | Icona errore rossa, "Pagamento non riuscito", CTA "Riprova il pagamento" + "Torna alla home" + link supporto | Fatto |
| 14 | Prenotazione confermata | Success: check verde, titolo, card riepilogo, CTA "Vai alle prenotazioni" + "Torna alla home" | Fatto |

### Gestione prenotazioni
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 15a | Prenotazioni / Prossime | Sezioni DA COMPLETARE + IN PROGRAMMA, card personalizzate con badge colorati | Fatto |
| 15b | Prenotazioni / Passate | Sezioni COMPLETATE + ANNULLATE | Fatto |
| 15c | Prenotazioni / Caricamento | 4 skeleton card | Fatto |
| 15d | Prenotazioni / Empty State | "Nessuna prenotazione" + CTA cerca servizio | Fatto |
| 15e | Prenotazioni / Errore | Empty State Error + "Riprova" | Fatto |
| 16 | Dettaglio prenotazione | Status, servizio, prezzo, cleaner, dettagli, note, azioni (Contatta/Modifica + link annulla) | Fatto |
| 17 | Annulla prenotazione | Modal danger con conferma | Da fare |

### AI Assistant
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 18a | Assistente / Conversazione | 5 messaggi personalizzati, bubble allineate sx/dx | Fatto |
| 18b | Assistente / Empty State | Illustrazione + 4 chip suggerimento | Fatto |
| 18c | Assistente / Caricamento | Skeleton bubble + typing indicator 3 dots | Fatto |
| 18d | Assistente / Errore | Empty State Error | Fatto |

### Profilo & Settings
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 19 | Profilo utente | Avatar, dati personali, indirizzi salvati, metodi pagamento | Da fare |
| 20 | Impostazioni | Toggle notifiche, privacy, logout | Da fare |

---

## Cleaner — Mobile (~18 schermate)

### Onboarding & Auth
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 1 | Welcome cleaner | Logo, CTA login/registrati (diverso da searcher) | Da fare |
| 2 | Login | Uguale al searcher | Da fare |
| 3 | Registrazione cleaner | Dati + servizi offerti + zona operativa | Da fare |

### Dashboard
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 4 | Home dashboard | Greeting, prossimo lavoro (card expanded), KPI giornata | Da fare |
| 5 | Notifiche | Nuove prenotazioni, reminder, pagamenti | Da fare |

### Prenotazioni
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 6 | Lista lavori | Tab bar (Oggi/Prossimi/Passati) + card job list | Da fare |
| 7 | Dettaglio lavoro | Info cliente, indirizzo, mappa, checklist, note | Da fare |
| 8 | Checklist lavoro | Lista check in corso (checkbox component) | Da fare |
| 9 | Lavoro completato | Success + riepilogo ore + guadagno | Da fare |

### AI Assistant
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 10 | Chat AI | Consigli, checklist suggerite, reminder | Da fare |

### Guadagni
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 11 | Riepilogo guadagni | Periodo, totale, lista pagamenti | Da fare |
| 12 | Dettaglio pagamento | Importo, data, prenotazione associata | Da fare |

### Recensioni
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 13 | Lista recensioni | Rating medio + lista recensioni ricevute | Da fare |

### Profilo & Settings
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 14 | Profilo cleaner | Avatar, dati, servizi, zone, disponibilità | Da fare |
| 15 | Modifica disponibilità | Calendario settimana + fasce orarie toggle | Da fare |
| 16 | Impostazioni | Toggle notifiche, privacy, documenti, logout | Da fare |

---

## Searcher — Desktop (da definire)

Portale web searcher — stesse funzionalità del mobile adattate a layout desktop con sidebar.

## Cleaner — Desktop (da definire)

Dashboard web cleaner — gestione prenotazioni, guadagni, profilo su desktop.

## Admin — Desktop (da definire)

Pannello admin — gestione utenti, prenotazioni, analytics, configurazione piattaforma.
