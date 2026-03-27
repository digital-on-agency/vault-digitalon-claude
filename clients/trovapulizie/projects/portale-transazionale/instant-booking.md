# Instant Booking — Analisi, prerequisiti e decisioni implementative

Ultimo aggiornamento: 2026-03-27
Fonte: analisi architettura tecnica + call 2026-03-23 (strategia lancio)

---

## Cos'e' l'Instant Booking

Il searcher prenota e paga immediatamente uno slot libero del cleaner, senza conferma manuale. E' la funzionalita' core del lancio (decisione call 2026-03-23).

Flusso target:
```
Searcher seleziona cleaner con IB attivo
  → vede slot liberi sul calendario
  → sceglie slot → POST /api/jobs/instant-booking
  → paga subito (Stripe Elements, form custom)
  → Stripe invia webhook al backend → job passa a paid
  → cleaner riceve notifica "hai una prenotazione"
  → frontend fa polling sullo stato del job → mostra conferma
```

---

## Prerequisiti bloccanti

Senza questi l'Instant Booking non si puo' sviluppare. Ordinati per priorita'.

### 1. Calendario dinamico cleaner
**Stato: DA DECIDERE**

Il campo `availability` attuale e' un JSONB statico con disponibilita' settimanale generica (`{ giorno: { start, end } }`). Non traccia slot gia' occupati.

L'IB richiede sapere in tempo reale quali slot sono liberi. Senza questo, si prenotano slot gia' occupati.

#### Opzioni valutate

**Opzione A — Derivare da tabella jobs (nessuna tabella nuova) ← raccomandato per il lancio**

Un cleaner e' occupato quando ha un job in stato non-terminale (`confirmed`, `paid`, `payment_pending`) per quella finestra temporale. I dati ci sono gia': `executed_at` + `hours` = finestra occupata.

```sql
-- Verifica se uno slot e' libero
SELECT count(*) FROM jobs
WHERE cleaner_id = :id
  AND status IN ('confirmed', 'paid', 'payment_pending')
  AND executed_at < :slot_end
  AND executed_at + (hours * interval '1 hour') > :slot_start
-- Se count = 0, lo slot e' libero
```

Vantaggi:
- Zero tabelle nuove, zero migration
- Zero logica di sync — il job E' lo slot
- Single source of truth
- Nessun rischio di disallineamento

Svantaggi:
- Non copre appuntamenti fuori piattaforma (accettabile per lancio microarea con pochi cleaner)

**Opzione B — Tabella `booked_slots` separata**

Tabella dedicata che si popola/svuota quando i job cambiano stato. Piu' flessibile ma richiede logica di sync e rischio disallineamento.

Complessita' aggiuntiva: ~4-6 ore rispetto a Opzione A.

**Opzione C — Integrazione Google Calendar (sync bidirezionale)**

Sync bidirezionale con calendario personale del cleaner. Copre anche appuntamenti fuori piattaforma, ma:
- Richiede OAuth consent screen, flow autorizzazione per ogni cleaner, gestione token refresh
- Polling periodico o webhook Google, mapping eventi esterni, gestione conflitti sync
- I cleaner poco digitalizzati non usano Google Calendar (problema emerso nella call)
- Complessita': ~3-5 giorni vs ~2 ore dell'Opzione A

#### Roadmap calendario progressiva

```
Lancio:     Disponibilita' derivata da jobs (Opzione A — zero tabelle nuove)
Dopo:       + Feed iCal per export passivo (~2-3h, funziona con qualsiasi app)
Poi:        + Sync attivo unidirezionale verso Google Calendar (~1 giorno)
Ancora poi: + Sync bidirezionale per importare appuntamenti esterni (~3-5 giorni)
```

Ogni step e' indipendente e non rompe il precedente.

**Feed iCal (evoluzione naturale dell'Opzione A):**
Endpoint `GET /api/cleaners/:id/calendar.ics` (con token segreto nell'URL). Il cleaner lo aggiunge a Google Calendar / Apple Calendar come sottoscrizione. Zero OAuth, zero Google API, funziona ovunque. Delay 15-30 min (polling del client).

**Sync unidirezionale (step successivo):**
La piattaforma resta la fonte di verita'. Quando un job cambia stato, il backend crea/aggiorna/elimina un evento su Google Calendar del cleaner via API. Il cleaner vede le prenotazioni come mirror read-only. Richiede OAuth per cleaner ma nessun conflitto da gestire.

Decisioni da prendere:
- [ ] Confermare Opzione A per il lancio
- [ ] Logica di lock/transazione atomica per evitare double booking
- [ ] Decidere se servono blocchi manuali (tabella `blocked_slots`) prima del lancio o dopo

### 2. Stripe: migrazione a Elements + webhook
**Stato: DA IMPLEMENTARE** — segnalato come [ATTENZIONE] nel CLAUDE.md progetto

#### Stato attuale (frontend-driven con Embedded Checkout)

```
Searcher clicca "Paga"
  → Frontend chiama POST /api/payments/create-checkout-session
  → Backend crea Stripe Checkout Session → ritorna clientSecret
  → Frontend monta <EmbeddedCheckout> (componente preconfezionato, non personalizzabile)
  → Utente paga
  → Frontend chiama GET /api/payments/check-session-status/:session_id
  → Frontend chiama POST /api/jobs/:id/pay          ← FRONTEND SCRIVE IL DB
  → Job → status: paid
```

Problemi:
- Il frontend dice al backend "il pagamento e' andato a buon fine" — inaffidabile
- Se il browser crasha dopo il pagamento ma prima della chiamata → soldi presi, job mai aggiornato
- Bug attuale: `PaymentResult updateJobDatabase()` chiamata due volte → doppie scritture
- Chiunque con un client HTTP potrebbe chiamare `POST /api/jobs/:id/pay` senza aver pagato

#### Soluzione target: Stripe Elements + webhook

```
Backend crea PaymentIntent → ritorna clientSecret
Frontend monta i componenti Stripe personalizzabili:
  - <CardNumberElement>, <CardExpiryElement>, <CardCvcElement>
  - oppure <PaymentElement> (componente unico ma stilizzabile)
Frontend chiama stripe.confirmPayment() al submit
Stripe processa il pagamento + 3DS se necessario
Stripe invia POST /api/webhooks/stripe                ← STRIPE CHIAMA IL BACKEND
  → Backend verifica firma (stripe.webhooks.constructEvent)
  → Estrae payment_intent_id dal payload
  → Trova il job con quel payment_intent_id
  → Aggiorna job → status: paid                       ← BACKEND SCRIVE IL DB
  → Ritorna 200 a Stripe
Frontend fa polling GET /api/jobs/:id ogni 2 secondi
  → Quando vede status: paid → mostra pagina successo
```

Vantaggi di Elements rispetto a Embedded Checkout:
- Controllo totale sul layout — i campi sono componenti React posizionabili liberamente
- Stile custom — font, colori, padding, bordi personalizzabili
- Coerente con il design system Figma (schermata 13d gia' disegnata)

Vantaggi del webhook rispetto al flusso frontend-driven:
- E' Stripe a confermare il pagamento, non il frontend — non falsificabile (firma con secret)
- Se il browser crasha, non importa — il webhook arriva comunque
- Risolve i bug attuali (doppia chiamata, race condition)
- Un'unica fonte di verita' per tutti i pagamenti (IB e tradizionali)

Attenzione con Elements:
- Gestire 3D Secure → `stripe.confirmPayment()` lo fa automaticamente
- Gestire stati di errore del form (carta rifiutata, fondi insufficienti) — con Embedded Checkout era automatico

Decisioni da prendere:
- [ ] Migrazione totale al webhook (tutti i pagamenti) vs convivenza temporanea (solo IB con webhook)
- [ ] Aggiungere campo `payment_intent_id` alla tabella jobs
- [ ] Endpoint webhook + verifica signature Stripe
- [ ] `<PaymentElement>` (unico, meno controllo) vs singoli `<Card*Element>` (piu' controllo su layout)

### 3. Scadenza payment_expires_at
**Stato: DA IMPLEMENTARE** — previsto nel design ma non implementato

Quando un searcher avvia un IB, il job va in `payment_pending`. Se non paga, lo slot resta bloccato per sempre.

Approccio raccomandato: **lazy check + pg_cron** (entrambi, non uno o l'altro).

- **Lazy check**: ogni volta che si cerca disponibilita' o si accede a un job, controlla se `payment_expires_at` e' passato. Zero infrastruttura aggiuntiva, ma lo slot resta bloccato finche' nessuno lo interroga.
- **pg_cron**: job periodico ogni 2 minuti — `UPDATE jobs SET status = 'expired' WHERE status = 'payment_pending' AND payment_expires_at < now()`. Pulizia garantita. Supabase supporta pg_cron.

Decisioni da prendere:
- [ ] Timeout: quanti minuti prima di scadere? (tipico: 15-30 min)
- [ ] Confermare approccio lazy + pg_cron

### 4. Onboarding IB per cleaner
**Stato: DA IMPLEMENTARE**

I campi DB esistono (`instant_booking boolean default false`, `instant_booking_offset smallint`) ma nessun cleaner li ha attivi.

Decisioni da prendere:
- [ ] UI cleaner per attivare/disattivare IB e impostare offset
- [ ] Criteri per abilitare IB: calendario collegato? profilo completo? verificato?
- [ ] Valore di default per `instant_booking_offset` (ore minime anticipo)

### 5. Formula di pricing
**Stato: DA DECIDERE**

L'endpoint IB crea un PaymentIntent con un prezzo calcolato server-side. Non e' definita la formula.

Dalla call 2026-03-23: "partire con prezzo fisso nella microarea di lancio".

Opzioni:
- **Tariffa oraria cleaner**: `hourly_rate * hours + commissione`. Il cleaner decide il suo prezzo
- **Prezzo fisso piattaforma**: la piattaforma decide il prezzo per tipo servizio. Piu' controllo
- **Ibrido base + add-on**: prezzo base fisso + add-on opzionali (vetri +15€, stiratura +10€, balcone +8€). Coerente con stepper Figma (schermata 10)

Decisioni da prendere:
- [ ] Modello di pricing per il lancio
- [ ] Percentuale commissione piattaforma
- [ ] Gestione add-on
- [ ] IVA: inclusa o esclusa?

### 6. Notifiche dedicate IB
**Stato: DA IMPLEMENTARE**

Nell'IB il cleaner non conferma — riceve solo una notifica che qualcuno ha prenotato. Serve un tipo di notifica diverso da "hai una nuova richiesta — accetta/rifiuta".

Decisioni da prendere:
- [ ] Template email/push/WhatsApp per "Nuova prenotazione istantanea"
- [ ] Template conferma per il searcher
- [ ] Il dispatcher (`dispatcher.service.ts`) e' pronto, servono solo i template

### 7. Fix bug nel flusso pagamento esistente
**Stato: DA FIXARE**

Bug documentati che impattano direttamente l'IB:

- [ ] `BookingRecap getRole()`: async non awaited + `Bearer temp` hardcoded — la guard che decide se mostrare il bottone IB non funziona
- [ ] `PaymentResult updateJobDatabase()`: chiamata due volte (doppia scrittura sul job)
- [ ] `PaymentResult setTimeout 20000ms`: probabile typo (dovrebbe essere 2000)
- [ ] Nessun middleware auth centralizzato: l'endpoint `/instant-booking` ha auth Bearer ma il JWT non e' verificato in modo robusto

Nota: la migrazione a webhook + Elements risolve strutturalmente i bug 2 e 3 (il frontend non scrive piu' il DB), ma il bug 1 e 4 vanno fixati comunque.

Riferimento completo bug: sezione "Bug noti e tech debt" nel CLAUDE.md del progetto.

---

## Cosa esiste gia'

Cose gia' in piedi su cui l'IB si appoggia:

- **Campi DB**: `cleaners.instant_booking`, `cleaners.instant_booking_offset` — pronti
- **Endpoint**: `POST /api/jobs/instant-booking` — struttura definita nel CLAUDE.md (crea job `payment_pending`, crea PaymentIntent, ritorna `{ job_id, client_secret }`)
- **Funzione eligibility**: `isInstantBookingEligible(cleaner, executed_at)` in `cleaner.utils.ts` — verifica `instant_booking=true` e differenza temporale >= offset
- **Stato job `payment_pending`**: nel CHECK constraint della tabella jobs
- **Stato job `paid`**: semantica definita (pre-servizio IB, diverso da `confirmed` che e' accettazione manuale)
- **Stripe**: integrazione funzionante (Embedded Checkout + PaymentIntents) — in modalita' test
- **Dispatcher notifiche**: multi-canale (email/push/WhatsApp) con preferenze utente
- **Schermate Figma searcher**: risultati con badge "Instant Book", profilo cleaner, stepper prenotazione, pagamento (form Stripe + caricamento + fallito) — gia' disegnate

---

## Piano di sviluppo

Ordine di implementazione proposto (da confermare dopo le decisioni):

```
Fase 0 — Fix bug bloccanti
  ├── Fix BookingRecap getRole()
  ├── Fix PaymentResult updateJobDatabase() doppia chiamata
  ├── Fix PaymentResult setTimeout 20000ms
  └── Aggiungere middleware auth centralizzato

Fase 1 — Infrastruttura pagamento (Stripe Elements + webhook)
  ├── Aggiungere campo payment_intent_id alla tabella jobs
  ├── Endpoint webhook POST /api/webhooks/stripe + verifica signature
  ├── Handler idempotente (payment_intent.succeeded → job paid)
  ├── Refactor backend: PaymentIntent invece di Checkout Session
  ├── Refactor frontend: Stripe Elements (form custom) + polling stato job
  ├── Rimuovere flusso frontend-driven (POST /api/jobs/:id/pay)
  └── Test con Stripe CLI (stripe listen --forward-to)

Fase 2 — Disponibilita' e double booking protection
  ├── Endpoint GET disponibilita' reale = availability − jobs occupati
  ├── Query anti-overlap su tabella jobs (vedi SQL sopra)
  ├── Lock/transazione atomica su creazione job IB
  └── Scadenza payment_expires_at (lazy check + pg_cron)

Fase 3 — Endpoint Instant Booking
  ├── POST /api/jobs/instant-booking (gia' strutturato)
  ├── Validazione isInstantBookingEligible
  ├── Verifica disponibilita' slot (query anti-overlap)
  ├── Calcolo prezzo server-side (formula decisa)
  ├── Creazione job payment_pending con payment_intent_id
  ├── Creazione PaymentIntent Stripe
  └── Ritorno { job_id, client_secret }

Fase 4 — Onboarding cleaner IB
  ├── UI cleaner: toggle IB on/off + input offset ore
  ├── Endpoint PUT /api/cleaners/:id per aggiornare instant_booking e offset
  └── Criteri minimi per attivazione

Fase 5 — Notifiche IB
  ├── Template "Nuova prenotazione istantanea" (email/push/WhatsApp)
  ├── Template conferma searcher
  └── Integrazione nel dispatcher dopo webhook payment success

Fase 6 — Frontend searcher
  ├── Badge "Instant Book" nei risultati ricerca
  ├── BookingRecap: branch IB (paga subito) vs flusso tradizionale
  ├── Stepper: add-on nel calcolo prezzo (se modello ibrido)
  ├── Pagamento: Stripe Elements con client_secret da IB
  └── Polling stato job dopo pagamento → pagina successo
```

Logica dell'ordine:
- **Fase 0** prima di tutto — i bug impattano il flusso che andremo a toccare
- **Fase 1** subito dopo — il webhook e' la base su cui poggia tutto (IB e flusso esistente)
- **Fase 2** crea l'infrastruttura dati (disponibilita' + scadenza) necessaria all'endpoint IB
- **Fase 3** e' l'endpoint vero e proprio, che a quel punto ha tutto sotto
- **Fase 4-5** abilitano i cleaner e le notifiche — possono procedere in parallelo
- **Fase 6** chiude con il frontend, che si appoggia su tutto il resto

---

## Decisioni implementative

<!-- Popolare man mano che si prendono le decisioni. Formato:
### [Data] — Titolo decisione
**Contesto**: ...
**Decisione**: ...
**Conseguenze**: ...
-->

Nessuna decisione implementativa confermata finora. Decisioni pendenti:
1. Calendario: confermare Opzione A (derivare da jobs)
2. Stripe: confermare migrazione totale a Elements + webhook
3. Pricing: scegliere modello (tariffa cleaner / fisso / ibrido)
4. Scadenza: confermare lazy + pg_cron, definire timeout
5. Blocchi manuali: servono prima del lancio o dopo?
