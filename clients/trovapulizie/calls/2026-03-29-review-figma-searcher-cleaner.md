# Call 2026-03-29 — Trovapulizie

**Data:** 2026-03-29
**Partecipanti:** Digital On Agency (Guido), Niccolò Fulgaro
**Durata:** ~1h 8min
**Progetto/i coinvolti:** Portale Transazionale — Figma Searcher Mobile + Dashboard Cleaner

---

## Contesto
Review approfondita del Figma: schermate searcher già disegnate + prima bozza dashboard cleaner. Focus su UX, flussi, decisioni architetturali e backlog feature.

---

## Decisioni prese

**Dashboard Cleaner — bottom bar:**
- [DEFAULT] Bottom bar cleaner: Dashboard | Calendario | Assistente | Profilo (parallela a Home | Prenotazioni | Assistente | Profilo del searcher)
- [DEFAULT] Storico lavori → tab dedicata nel menu, non nella home dashboard (non è voce operativa prioritaria)

**Vista calendario searcher:**
- [DEFAULT] Nessun calendario dedicato nel portale searcher — si usa il tasto "Aggiungi al calendario" (link → Google Calendar)
- [DEFAULT] Vista calendario per le prenotazioni del searcher è nice to have, da implementare con calma
- [DEFAULT] Le prenotazioni del searcher avranno uno switcher lista/calendario con default impostabile nelle preferenze utente

**Profilo ditta vs cleaner singolo:**
- [DEFAULT] Le ditte devono avere un profilo separato — non gestibili con un unico profilo searcher o cleaner individuale

**Flusso doppio (Flow A / Flow B):**
- [DEFAULT] Flow A (scegli il cleaner): l'utente sceglie il cleaner prima, l'orario si mette dopo. Logica: chi sceglie il cleaner non ha una data esatta in mente — includere una data obbligatoria escluderebbe cleaner rilevanti
- [DEFAULT] Flow B (trova disponibilità): metti data/ora, il sistema trova il cleaner. Per chi ha urgenza o gestisce un'attività (es. affittacamere)
- [DEFAULT] Il tipo di servizio rimane obbligatorio nella ricerca (filtra risultati irrilevanti → UX migliore). Da monitorare con bounce rate: se crea troppo attrito si rimuove
- [NOTA] L'obbligo del servizio nella search bar non va applicato all'orario nel Flow A — logiche diverse

**Notifiche:**
- [DEFAULT] Notifiche conservate per 30 giorni, poi eliminazione automatica (pulizia DB)
- [DEFAULT] "Archivia lette" = nasconde dalla barra, non elimina dal sistema
- [DEFAULT] Impostazioni notifiche accessibili sia da Notifiche che da Impostazioni (ridondanza intenzionale per UX)
- [DEFAULT] Tutte le impostazioni centralizzate in un unico posto — alcune voci richiamate anche da contesti specifici

**Codice sconto / referral:**
- [DEFAULT] Codice amico inserito in fase di iscrizione (non al checkout) — più logico, impedisce abusi, modello Revolut
- [DEFAULT] Campo codice sconto nel checkout comunque presente (per promozioni future separate)
- [DEFAULT] Verifica identità necessaria per utilizzare il codice amico
- [NOTA] Complessità implementativa simile tra le due opzioni — vale la pena fare la versione corretta

**Recensioni:**
- [DEFAULT] Stelline obbligatorie, commento e sottocategorie opzionali
- [DEFAULT] Più info dai → più punti (incentivo a recensioni strutturate)
- [DEFAULT] Sistema punti da implementare in un secondo momento (post-lancio, entro 1-2 mesi)
- [DEFAULT] Struttura recensione con sottocategorie (puntualità, materiali, ecc.) — solo le stelline obbligatorie

**Assistenza:**
- [DEFAULT] Email + WhatsApp disponibili ora, messaggi in-app nascosti (feature futura)
- [DEFAULT] Ticket di supporto: nice to have post-lancio — form che manda dati via API a Claude senza MCP/automazioni

**Errori / skeleton:**
- [DEFAULT] Errore connessione: copy "Controlla connessione e riprova"
- [DEFAULT] Errore generico (es. server Supabase giù): copy generico variabile + eventuale contattaci
- [DEFAULT] Errore su prenotazioni: "riprova + contattaci" — a seconda del tipo di errore con condizionale lato codice

**Segnalazioni:**
- [DEFAULT] Separare segnalazione profilo generica (es. foto falsa) da segnalazione prenotazione (problema con cleaner specifico)
- [DEFAULT] Sistema ticket su prenotazioni da valutare come feature separata

**Conferma lavoro completato (da decidere con tutto il team):**
- [ATTENZIONE] Discussione aperta: flusso "conferma lavoro" tipo Deliveroo — searcher conferma che il cleaner ha eseguito il lavoro prima che il pagamento venga rilasciato
- Pro: protezione finanziaria piattaforma e utenti
- Contro: step obbligatorio aggiuntivo, complessità implementativa, rischio pagamento bloccato se searcher non risponde
- Decisione da prendere con tutto il team

**Modifica prenotazione:**
- [DEFAULT] Se cleaner ha instant booking: orari disponibili selezionabili direttamente
- [DEFAULT] Se cleaner non ha instant booking: richiesta di conferma al cleaner
- [DEFAULT] Il cleaner ha N ore (es. 12-24h) per rifiutare la modifica — la modifica va richiesta almeno N*2 ore prima
- [ATTENZIONE] Da ragionare con tutto il team prima di implementare

**Splash page (app.trovapulizie.it):**
- [DEFAULT] Splash page: Registrati | Accedi | Continua come ospite
- [DEFAULT] Se ospite arriva al checkout: form login/registrazione embeddato nello stepper (con entrambe le opzioni)

**Dominio dashboard cleaner:**
- [DEFAULT] Dominio separato per la dashboard cleaner (es. cleaner.trovapulizie.it) — più semplice da gestire, meno casino su redirect/404, coerente con modelli di mercato (Booking usa account., GetYourGuide usa supply.)

**Roadmap feature — struttura a 3 livelli (proposta Niccolò):**
- [DEFAULT] Must: da avere al go-live
- [DEFAULT] Nice to have: entro 1-2 mesi dal lancio
- [DEFAULT] Opzionali: entro ~1 anno
- Esempi: sistema recensioni = Must; sistema punti = Nice to have; ticket in-app = Opzionale

---

## Action item
- [ ] Continuare a disegnare la dashboard cleaner su Figma — Guido — prossima sessione
- [ ] Approfondire flusso "conferma lavoro completato" con tutto il team — Guido + Niccolò + team — prossima call
- [ ] Decidere flusso modifica prenotazione con/senza instant booking + finestra di rifiuto cleaner — Guido + Niccolò — prossimo incontro
- [ ] Fix icone SVG: applicare fill/stroke uniforme — Guido — Figma
- [ ] Aggiungere schermate onboarding first time (2 schermate welcome post-registrazione) — Guido — Figma
- [ ] Aggiungere splash page + flusso ospite → login/registrazione nel checkout — Guido — Figma
- [ ] Strutturare lista feature con 3 livelli (Must / Nice / Opzionale) — Guido + Niccolò — prossima sessione
- [ ] Aggiungere schermata errore 404 dedicata — Guido — Figma
- [ ] Nascondere "messaggi in-app" nell'assistenza — Guido — Figma
- [ ] Separare segnalazione profilo generica da segnalazione prenotazione — Guido — Figma

---

## Problemi emersi
- Icone SVG da Lucide React: difficile mantenere coerenza visiva su Figma — soluzione: modificare stroke/fill come SVG direttamente
- Sistema conferma lavoro completato apre complessità implementativa significativa (flusso, logica scadenza, edge case) — decisione rinviata al team

---

## Note interne
- La call evidenzia che la piattaforma è molto più profonda di quanto sembrava — Niccolò: "una porta aperta"
- Guido soddisfatto del livello di dettaglio Figma: permette ora di costruire una roadmap precisa e stimare i tempi
- Niccolò vuole lista feature codificata e strutturata per stimare i tempi in modo più rigoroso — proposta 3 livelli condivisa
