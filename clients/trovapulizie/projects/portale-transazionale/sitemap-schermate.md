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

## Searcher — Mobile (55 schermate)

### Onboarding & Auth
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 1 | Welcome / Splash | Logo, tagline, CTA login/registrati | Fatto |
| 2 | Login | Email + password, social login, link registrazione | Fatto |
| 2b | Password dimenticata | Form reset password via email | Fatto |
| 3 | Registrazione | Nome, email, password, conferma | Fatto |
| 4 | Verifica OTP | Input codice, resend, countdown | Da fare |

### Home & Discovery
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 5 | Home (attuale) | Greeting top bar, search bar, griglia 6 servizi, cleaner consigliati/vicini | Fatto |
| 5b | Home / Indirizzo Mancante | Click servizio senza indirizzo: toast warning + search bar highlight arancione (variante Home attuale) | Fatto |
| 5b-load | Home / Caricamento | Skeleton della home con placeholder contenuti | Fatto |
| 5c | Home / Servizio Mancante | Variante Home attuale con servizio mancante | Fatto |
| 5v2 | Home v2 — Dual Flow | Hero card Flow B (AI Match) + divider "oppure scegli tu" + griglia servizi + consigliati | Fatto |
| 5v2b | Home v2 / Indirizzo Mancante | Click servizio senza indirizzo: toast warning + search bar highlight arancione + helper text + servizio selezionato (verde) | Fatto |
| 5v2c | Home v2 / Servizio Mancante | Variante Home v2 con servizio mancante | Fatto |
| 6 | Notifiche | Lista notifiche (prenotazione, reminder, promo) con icone colorate per tipo, sezioni Oggi/Questa settimana, stati letta/non letta | Fatto |
| 6b | Notifiche / Menu Aperto | Dropdown 3 puntini: Segna tutte come lette, Impostazioni notifiche, Archivia lette. Backdrop semitrasparente | Fatto |

### Ricerca & Filtri
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 7 | Risultati ricerca | 5 card cleaner, search bar posizione + tasto filtri, 2 Instant Book | Fatto |
| 7b | Risultati ricerca / Caricamento | Skeleton card cleaner (4), spinner "Ricerca in corso...", hint centrato | Fatto |
| 7d | Risultati ricerca / Nessun Risultato | Empty state "Nessun risultato" + CTA "Rimuovi filtri" | Fatto |
| 8 | Filtri (Bottom Sheet) | Tipo di servizio (chip), range prezzo (min/max), rating minimo (chip stelle), disponibilità (chip) | Fatto |
| 8b | Ordina (Bottom Sheet) | Opzioni ordinamento risultati | Fatto |
| 9 | Profilo cleaner | Avatar, rating 4.8, bio, chip servizi, recensione, CTA sticky "Prenota ora" | Fatto |
| 9b | Profilo cleaner / Caricamento | Skeleton fedele al profilo (hero, bio, servizi chip, recensione, CTA) | Fatto |
| 9c | Profilo cleaner / Menu Aperto | Dropdown 3 puntini: Condividi profilo, Segnala (rosso). Backdrop semitrasparente | Fatto |
| 9d | Profilo cleaner / Segnala (Bottom Sheet) | 5 opzioni radio (info false, foto inappropriata, comportamento, spam, altro) + CTA rosso "Invia segnalazione" | Fatto |
| 9e | Profilo cleaner / Condividi (Bottom Sheet) | Anteprima URL + 4 opzioni: Copia link, WhatsApp, Messaggio, Altro... | Fatto |

### Prenotazione (stepper)
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 10 | Step 1 — Servizio | Stepper + 6 servizi (radio card) + sezione add-on (Pulizia vetri, Stiratura, Pulizia balcone). Servizio pre-selezionato se utente arriva da ricerca/griglia servizi | Fatto |
| 11 | Step 2 — Data/Ora | Stepper + calendario compatto (mese) + fasce orarie (chip 2 righe) | Fatto |
| 11b | Step 2 — Caricamento | Skeleton calendario e fasce orarie | Fatto |
| 12 | Step 3 — Dettagli | Stepper + indirizzo, durata (chip), piano/interno, note | Fatto |
| 13a | Step 4 — Conferma (Flow A) | Riepilogo: cleaner card, dettagli, note, breakdown prezzo, totale, CTA "Paga — €72" | Fatto |
| 13b | Step 4 — Conferma + Sconto Applicato | Riepilogo con codice sconto -€10, totale aggiornato | Fatto |
| 13c | Step 4 — Caricamento | Skeleton riepilogo ordine | Fatto |
| 13c2 | Checkout / Verifica Richiesta (Bottom Sheet) | Bottom sheet verifica identità richiesta nel checkout | Fatto |
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
| 17 | Prenotazioni / Errore | Empty State Error + "Riprova" | Fatto |
| 16 | Dettaglio prenotazione | Status, servizio, prezzo, cleaner, dettagli, note, azioni (Contatta/Modifica + link annulla) | Fatto |
| 16b | Modifica Prenotazione (Bottom Sheet) | Bottom sheet modifica data/ora prenotazione | Fatto |
| 16c | Dettaglio Prenotazione / Toast Modifica | Toast conferma modifica avvenuta | Fatto |
| 16d | Dettaglio Prenotazione / Modale Annulla | Modal danger con conferma annullamento | Fatto |
| 16e | Dettaglio Prenotazione / Contatta Cleaner | Bottom sheet Chiama/WhatsApp/Messaggio in-app | Fatto |
| 16f | Dettaglio Prenotazione / Caricamento | Skeleton fedele al layout (badge, titolo, prezzo, avatar cleaner, dettagli, note, bottoni) | Fatto |
| 16g | Dettaglio Prenotazione / Completata | Dettaglio prenotazione con stato completata | Fatto |
| 21 | Lascia Recensione | Form recensione post-servizio | Fatto |
| 22 | Ricevuta Pagamento | Ricevuta/fattura del pagamento effettuato | Fatto |

### AI Assistant
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 18a | Assistente / Conversazione | 5 messaggi personalizzati, bubble allineate sx/dx | Fatto |
| 18b | Assistente / Empty State | Illustrazione + 4 chip suggerimento | Fatto |
| 18c | Assistente / Caricamento | Skeleton bubble + typing indicator 3 dots | Fatto |

### Profilo & Settings
| # | Schermata | Descrizione | Stato |
|---|-----------|-------------|-------|
| 19 | Profilo utente | Avatar, dati personali, indirizzi salvati (icone SVG casa/ufficio), metodi pagamento (icona carta), banner verifica identità | Fatto |
| 19b | Modifica Profilo | Avatar con badge fotocamera, campi nome/email/telefono, CTA "Salva modifiche" | Fatto |
| 19c | Modifica Profilo / Cambia Foto (Bottom Sheet) | 3 opzioni: Scatta foto, Scegli dalla galleria, Rimuovi foto (rosso) + Annulla | Fatto |
| 19d | Aggiungi Indirizzo | Chip tipo (Casa/Ufficio/Altro), ricerca indirizzo, nome opzionale, piano/interno, note cleaner, CTA "Salva indirizzo" | Fatto |
| 19e | Aggiungi Metodo di Pagamento | Form aggiunta carta di pagamento | Fatto |
| 19f | Profilo Utente / Menu Aperto | Menu 3 puntini con 7 voci (assistenza, invita, notifiche, lingua, termini, esci, elimina) con icone SVG | Fatto |
| 19g | Assistenza | FAQ con 6 domande accordion | Fatto |
| 19h | Assistenza / Contattaci (Bottom Sheet) | 3 opzioni: Email, WhatsApp, In-app | Fatto |
| 19i | Invita un Amico | Codice referral + condividi via WhatsApp + guadagna €10 | Fatto |
| 19j | Impostazioni Notifiche | Toggle canali (push, email, SMS) + tipo notifica | Fatto |
| 19k | Lingua | 5 opzioni lingua (IT, EN, DE, ES, FR) | Fatto |
| 19l | Elimina Account (Modale) | Modal danger conferma eliminazione account | Fatto |
| 19m | Cambia Password | Form cambio password (attuale + nuova + conferma) | Fatto |
| 20a | Verifica Documento | Upload CI/Patente/Passaporto + numero documento | Fatto |
| 20b | Documento Inviato | Conferma invio documento per verifica | Fatto |

### Dev Notes (non schermate)
| # | Elemento | Descrizione |
|---|----------|-------------|
| — | Dev Note — CTA dinamico | CTA 20b cambia in base all'origin (checkout vs profile) |
| — | Dev Note — Banner Verifica | Banner profilo 3 stati (non verificato/pending/verificato) + campo DB |
| — | Dev Note — Termini e Privacy | Link esterno nuova scheda |

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
