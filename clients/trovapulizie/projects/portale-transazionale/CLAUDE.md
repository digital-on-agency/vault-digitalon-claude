# Portale Transazionale — Trovapulizie S.R.L.
Tipo: Sito Web

## Obiettivo
Piattaforma transazionale per prenotazione e pagamento di servizi di pulizia. Booking flow completo fino a payment_success. Go-live commerciale Roma-first previsto 1 aprile 2026.

## Stato attuale
**Stato**: In corso
**Ultimo aggiornamento**: 2026-03-24
**Fase attuale**: Pre-go-live — focus su Instant Booking, onboarding cleaner e acquisizione offerta per microarea di lancio
**URL produzione**: trovapulizie.it
**URL staging**: <!-- DA COMPLETARE -->

## Stack tecnologico
**Framework**: TypeScript full-stack — React (frontend) + Express (backend)
**Frontend**: Asset statici su dominio dedicato
**Backend**: Servizio API separato
**Database**: Supabase
**Hosting**: Serverplan (migrazione a Hostinger entro aprile 2026)
**Repository**: https://github.com/digital-on-agency/trovapulizie.git
**Deploy**: Manuale da terminale via SSH

## Integrazioni
- Supabase — database e auth
- Stripe — payment provider (booking flow fino a payment_success)
- GA4 — property ID 428236871
- Airtable — ops layer e CRM

## Decisioni tecniche
[BLOCCATO] 2026-04-01 — Go-live Roma-first — strategia approvata dal team
[DEFAULT] 2026-03-22 — Migrazione hosting Serverplan → Hostinger entro aprile 2026
[ATTENZIONE] Ogni modifica all'infrastruttura va valutata in ottica fundraising
[DEFAULT] 2026-03-23 — Instant Booking come funzionalità core del lancio — prerequisiti e decisioni in `instant-booking.md`
[DEFAULT] 2026-03-23 — Espansione per microaree, non lancio aggressivo su tutta Roma
[DEFAULT] 2026-03-23 — IA per matchmaking predittivo domanda/offerta, rerouting e rimborsi
[DEFAULT] 2026-03-23 — Sistema ricompensa a doppia logica (crediti/sconti) per fidelizzazione
[DEFAULT] 2026-03-23 — Prova completamento servizio tramite foto/video
[DEFAULT] 2026-03-23 — Assistente AI in-app per cleaner (fase futura — effetto "wow")
[DEFAULT] 2026-03-23 — Logo da rifare pensando ad app mobile

## Prossimi passi
- [ ] Risolvere prerequisiti bloccanti Instant Booking (vedi `instant-booking.md`) — Team — priorità alta
- [ ] Completare onboarding cleaner per Instant Booking — Niccolò — entro: 2026-04-01
- [ ] Creare script intervista telefonica cleaner — Guido — entro: 2026-04-05
- [ ] Contattare 120 vecchi cleaner con script — Guido — entro: 2026-04-12
- [ ] Identificare microarea di lancio da copertura cleaner — Team — entro: 2026-04-12
- [ ] Configurare dashboard KPI piattaforma — Matti — entro: 2026-04-04
- [ ] Proporre idee nuovo logo (app-ready) — Matti — entro: 2026-04-04
- [ ] Preparare volantinaggio per microarea — Digital On — entro: TBD

## Architettura backend
**Layering**: routes → controllers (thin) → services (business) → models → utils
- Bootstrap separato: `app.ts` (configurazione Express) vs `server.ts` (avvio)
- Integrazioni esterne (Supabase, Stripe, Firebase) inizializzate in `src/config` come singleton condivisi
- Utils pure e riusabili; sottosistemi complessi (notifiche) in sottodirectory dedicate
- Controller: solo parsing request + chiamata service + risposta. Zero business logic

## Architettura frontend
**Struttura**: components / pages / lib / models / types / hooks
- Pages come orchestratori, non contenitori di logica
- Logiche riusabili in hooks/lib; tipi in models/types
- Componenti con hook: solo `<Component />`, mai invocati come funzioni
- UI globali (banner, scroll-to-top, modali persistenti) in App.tsx / Router
- Route 404 catch-all: `path="*"`
- Tailwind safelist generata dai JSON di stile per evitare purge classi dinamiche — aggiornare quando cambiano i JSON

## Auth e sicurezza
- **Supabase Auth + RLS** su tabelle critiche
- Reset password / operazioni sensibili: `exchangeCodeForSession` prima di update
- Migrazione massiva utenti: delay **3s** tra signup per evitare 429
- Query su tabelle RLS: `getSupabaseForUser(token)` per contesto utente
- Usare `maybeSingle()` per evitare eccezioni con RLS/dati mancanti
- Delete utenti: cleanup manuale ordinato delle entità dipendenti (FK/trigger/RLS rendono insufficienti i cascade)

## Pagamenti Stripe
**Metodo attuale**: Stripe Embedded Checkout / PaymentIntents (frontend-driven)
**Migrazione prevista**: Stripe Elements (form custom) + webhook autoritativo — vedi `instant-booking.md` §2

**Stati job**:
- `payment_pending` (obbligatorio) → `confirmed` | `paid` (Instant Booking) | `payment_failed` | `expired`
- `confirmed` = accettazione manuale cleaner; `paid` = pre-servizio Instant Booking (semantica diversa)

**Regole**:
- Creare sempre record server-side PRIMA del pagamento (job payment_pending)
- Prezzo, eligibility, offset temporali calcolati server-side
- Conferma finale via **webhook Stripe** (meccanismo autoritativo)
- Idempotenza su webhook: usare event id / payment_intent_id
- `client_secret`: mai in URL o log non protetti; usare `session_id` per pagina ritorno
- Pagina ritorno: `/checkout/successful-payment` con parametri jobId/requestId+cleanerId + session_id

**Instant Booking**:
- Endpoint: `POST /api/bookings/instant/checkout`
  - Valida eligibility/disponibilità con `isInstantBookingEligible(cleaner, executed_at)` (basata su instant_booking, instant_booking_offset, differenza temporale server-side)
  - Calcola prezzo server-side
  - Crea job `payment_pending` con `payment_expires_at`
  - Crea PaymentIntent Stripe, salva `payment_intent_id`
  - Ritorna al frontend: `{ job_id, client_secret }`
- Scadenza `payment_expires_at` → stato `expired`: implementazione (cron o lazy) da definire

[ATTENZIONE] Conflitto post-pagamento: flusso esistente ha azioni frontend-driven (dopo retrieve session); Instant Booking richiede webhook autoritativo. Da unificare per evitare doppie scritture e race condition. Analisi completa e piano migrazione in `instant-booking.md`.

## Notifiche e comunicazioni
- **Push**: Firebase Cloud Messaging con `firebase-admin` nel backend
- **Token FCM**: tabella `pushtokens` con `UNIQUE(token)`, legati a user_id
- **Canali**: email HTML transazionali, push, WhatsApp — invio solo se canale abilitato dall'utente
- **Template**: separati per canale; WhatsApp con variabili `{}`
- **Errori FCM**: su `registration-token-not-registered` rimuovere token dal DB immediatamente
- **Invii massivi** (riattivazione piattaforma): script Node per normalizzare contatti + Make via webhook per invio e rate limiting

## Geofilter
- Coordinate in `cleaners.coordinates` (JSONB lat/lng gradi decimali)
- Filtro distanza: Haversine, raggio in **km**
- Logica attualmente lato client; moduli dedicati (`/lib/maps/` o equivalenti)
- Abbandonato batch reverse geocoding (HERE OAuth/permessi + 429; Google no batch standard)
- Possibile evoluzione a PostGIS se necessità di scalabilità/precisione

## Deploy production
- **Nginx** unico ingresso pubblico (80/443), backend solo localhost (es. 3001)
- Routing: `/api/*` → `proxy_pass` backend; resto → static frontend (`root` + `try_files`)
- HTTPS forzato; CSP gestita in Nginx; env runtime via PM2 (non in build)
- Debug: se browser fallisce ma curl ok → quasi sempre CSP/HTTPS/Mixed Content
- Versionare config Nginx nel progetto
- [ATTENZIONE] Logrotate da configurare prima del go-live

## Logging
- **Pino** strutturato JSON; dev su console, prod su file `logs/app.log`
- `pino.multistream` per più destinazioni
- Campi pianificati: `module`, `user_id`, `req_id` — da aggiungere

## Timezone e date
- Backend normalizza con **Luxon**, timezone **Europe/Rome**
- Frontend invia ISO "grezzo" senza offset manuali
- Vietati offset manuali lato client

## Modello dati
- `profiles` = proiezione applicativa di `auth.users`
- `cleaners` / `searchers` estendono 1:1 `profiles`
- Campi JSONB per flessibilità, mitigati da vincoli CHECK
- `selected_cleaners uuid[]` in requests: scelta deliberata (no tabella ponte) — attenzione a implicazioni query/indicizzazione
- FK multiple su jobs verso profiles e cleaners/searchers: documentare e usare query con cautela

## Error handling
- **Standard**: HTTP `status` + `code` applicativo stabile — mai inferire errori dal testo
- **Classificazione**: 401 credenziali invalide, 403 permission, 400/422 validation, 503 infra/retryable
- In ogni accesso DB: verificare `error` prima di usare `data`
- Fallback legacy login: non attivare su errori infrastrutturali o DB
- Mappa `error.code` ↔ messaggi UI frontend: da mantenere e versionare

## Struttura repo
Monorepo con due applicazioni principali:
- `front-end/`: SPA React (Vite), porta dev 8080, `base: './'`
- `back-end/`: API Express, porta default 3001, avvio con `ts-node-dev`
- `db-migration/`: script JS + dati JSON/GeoJSON per migrazioni DB
- `launch-script/`, `archives/`, `executable/`: artifacts di deploy

## Env vars chiave
**Frontend**: `VITE_BACKEND_URL`, `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`, `VITE_STRIPE_PUBLISHABLE`, `VITE_FIREBASE_*`, `VITE_SUPPORT_MAIL_ADDRESS`, `VITE_SUPPORT_MAIL_WEBHOOK`
**Backend**: `PORT`, `FRONTEND_URL`, `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY`, `STRIPE_SECRET` / `TEST_STRIPE_SECRET`, Firebase credentials JSON, `MULTI_CHANNEL_WEBHOOK`

## Frontend state e pattern
- **UserContext**: `user`, `profile`, `session`, `loading`, `error` + setter. Init da `supabase.auth.getSession()` + `fetchProfile`; listener `onAuthStateChange`
- **PaymentCheckoutContext**: `clientSecret` (Stripe), `onCheckoutClose`. CheckoutOverlay globale in App.tsx mostra Embedded Checkout quando clientSecret è valorizzato
- **Route guards**: `ProtectedRoute` (home → redirect per ruolo), `SearcherRoute` (richiede login + ruolo searcher). Nessuna `CleanerRoute` dedicata — protezione solo interna alle pagine
- **Ponte tra step** (sessionStorage): `serviceRequestData`, `selectedCleaner`, `redirectAfterAuth`, `request_auth_status`, `requestFlowSource`, `paymentAmount`
- **i18n**: i18next con it (fallback), en, de, es, fr — risorse in `src/i18n/locales/`
- **API calls**: nessun client centralizzato; `fetch` + `VITE_BACKEND_URL` ripetuto in più file; `dbUtils` per operazioni comuni (fetchProfile, fetchUserName, fetchCleanerProfile, fetchAllCleaners, fetchServiceTypes, checkSession, mailExists)

## UX — Regole di interazione Home

### Click servizio senza indirizzo
**Regola**: l'indirizzo è obbligatorio prima di procedere alla ricerca cleaner.
**Comportamento**:
1. Click su card servizio → il servizio si seleziona (bordo verde, sfondo `#E6FFF5`) come feedback visivo
2. Toast warning (arancione) appare in alto: "Inserisci un indirizzo per continuare"
3. Search bar evidenziata con bordo arancione (`#F59E0B`) + helper text sotto
4. Dopo 3s il toast scompare automaticamente, l'highlight sulla search bar resta
5. Quando l'utente inserisce l'indirizzo → navigazione automatica ai risultati ricerca, filtrati per il servizio selezionato
**Motivazione**: lancio Roma-first con pochi cleaner per microarea — mostrare risultati senza filtro geografico crea aspettative sbagliate.

## API reference

### Auth (`/api/auth`)
| Method | Path | Auth | Descrizione |
|--------|------|------|-------------|
| POST | /signup | No | Registrazione — `supabase.auth.signUp`. Ritorna user + session (access_token, refresh_token) |
| POST | /login | No | Login — `signInWithPassword` + fallback legacy (bcrypt hash → migrazione password). Errori tipizzati: EMAIL_NOT_CONFIRMED, RATE_LIMIT, INVALID_CREDENTIALS |
| GET | /mail-check | No | Verifica esistenza email (tentativo login con password finta) |
| POST | /reset-password-email | No | Invia email reset via `supabase.auth.resetPasswordForEmail` |
| POST | /reset-password | Bearer | Aggiorna password. **BUG**: usa `getSupabaseForUser(email)` invece di `(token)` |

### Profiles (`/api/profiles`)
| Method | Path | Auth | Descrizione |
|--------|------|------|-------------|
| GET | /:user_id | Bearer | Profilo completo. Usa client anon (non rispetta RLS utente) |
| GET | /:user_id/name | Bearer | Solo campo `name` |
| GET | /check-email | No | Email esiste? Query su tabella `profile_emails` |
| POST | / | Bearer | Crea profilo: user_id, name, email, phone, role, avatar_url |
| PUT | /:user_id | Bearer | Aggiorna name, phone, avatar_url. Usa `getSupabaseForUser` |

### Cleaners (`/api/cleaners`)
| Method | Path | Auth | Descrizione |
|--------|------|------|-------------|
| POST | / | No | Crea cleaner (signup): geocoding → createProfile (role cleaner) → insert cleaners con coordinate |
| PUT | /:user_id | No | Aggiorna bio, services, availability, location, radius, hourly_rate, preferences |
| GET | /:user_id | Bearer | Cleaner + join profilo |
| GET | /available | No | Cleaner disponibili — query: date, time, job_type, lat, lng. Filtra per disponibilità, raggio, tipo servizio |
| GET | /all | No | Tutti i cleaner |
| POST | /sort | No | Ordinamento "consigliati" (trial period, priority, ranking) |

### Searchers (`/api/searchers`)
| Method | Path | Auth | Descrizione |
|--------|------|------|-------------|
| POST | / | Bearer | Crea searcher: user_id, preferences |
| PUT | /:userId | Bearer | Aggiorna preferences (notifiche) |
| GET | /:userId | Bearer | Dati searcher + preferences |

### Jobs (`/api/jobs`)
| Method | Path | Auth | Descrizione |
|--------|------|------|-------------|
| POST | / | Bearer | Crea job (status: pending, requested_at: ora locale). Usa `getSupabaseForUser` |
| POST | /instant-booking | Bearer | Crea job instant booking (status: payment_pending) |
| GET | /:id | No | Dettaglio job per id |
| GET | /cleaner/:cleaner_id | No | Job per cleaner |
| GET | /searcher/:searcher_id | No | Job per searcher |
| PUT | /:id/c-reject | Bearer | Cleaner rifiuta → aggiorna rejected_at |
| PUT | /:id/c-accept | Bearer | Cleaner accetta → controlla executed_at ≥ 1h futuro (422 se no), aggiorna confirmed_at |
| POST | /:id/pay | Bearer | Segna job come pagato (status: paid, paid_at) |
| POST | /request-to-job | Bearer | Crea job da request accettata: body requestId + cleanerId |

### Requests (`/api/requests`)
| Method | Path | Auth | Descrizione |
|--------|------|------|-------------|
| POST | / | Bearer | Crea request (make-offer) + assegnazione e notifica cleaner. **BUG**: validateData usa `status: 'JobStatus'` → typeof fallisce sempre |
| GET | / | Bearer | Request per status e searcherId (query params) |
| GET | /:req_id | Bearer | Request per id |
| GET | /cleaner/:cleaner_id | Bearer | Request per cleaner |
| PUT | /:id/budget | Bearer | Aggiorna budget (offerta economica del cleaner) |
| PUT | /:id/accept | Bearer | Searcher accetta request → imposta accepted_at |
| PUT | /:id/cancel | Bearer | Searcher annulla request |
| PUT | /:id/cancel-offer | Bearer | Cleaner ritira la propria offerta |

### Reviews (`/api/reviews`)
| Method | Path | Auth | Descrizione |
|--------|------|------|-------------|
| POST | / | Bearer | Crea recensione: cleaner_id, searcher_id, rating, job_id, comment |
| GET | / | No | Recensioni per cleaner_id (query) |
| GET | /summary | No | Media rating + conteggio per cleaner_id |
| POST | /job | No | Recensioni per array di job_ids |

### Maps (`/api/maps`)
| Method | Path | Auth | Descrizione |
|--------|------|------|-------------|
| GET | /coordinates | No | Geocoding indirizzo → {lat, lng} (API esterna) |
| POST | /distance | No | Distanza Haversine tra due punti |

### Notifications (`/api/notifications`)
| Method | Path | Auth | Descrizione |
|--------|------|------|-------------|
| POST | /cleaner-welcome | No | Email welcome cleaner (signup) |
| POST | /searcher-welcome | No | Email welcome searcher (signup) |
| POST | /job-request | Bearer | Nuova richiesta job → notifica cleaner (email/push/webhook in base preferenze) |
| POST | /job-rejected | Bearer | Cleaner rifiuta → notifica searcher |
| POST | /cleaner-job-cancelled | Bearer | Cleaner annulla job |
| POST | /searcher-job-cancelled | Bearer | Searcher annulla job |
| POST | /success-payment | Bearer | Pagamento riuscito → notifica searcher |
| POST | /job-paid | Bearer | Job pagato → notifica cleaner |
| POST | /offer-accepted-and-paid | Bearer | Offerta accettata e pagata → notifica cleaner |
| POST | /support-email | No | Email a supporto (form help) |
| POST | /save-push-token | No | Salva token FCM: userId, token, deviceInfo |
| POST | /email | Bearer | Email generica |

### Payments (`/api/payments`)
| Method | Path | Auth | Descrizione |
|--------|------|------|-------------|
| POST | /create-checkout-session/ | No | Crea Stripe Checkout Session. Body: job_or_request ('job'\|'request'), job_id/request_id, cleaner_name, executed_at, hours, price, type. Ritorna {clientSecret} |
| GET | /check-session-status/:session_id | No | Stato sessione Stripe: status (open/complete) + payment_status |

### Services (`/api/services`)
| Method | Path | Auth | Descrizione |
|--------|------|------|-------------|
| GET | /types | No | Elenco tipi servizio (id, name_it, name_en, name_es) |

**Nota route ordering**: path fissi (`/available`, `/check-email`, `/instant-booking`) definiti prima di path parametrici (`/:id`) per evitare conflitti.

## Bug noti e tech debt
1. **auth.service.resetPassword**: usa `getSupabaseForUser(email)` invece di `getSupabaseForUser(token)` — reset password non funziona
2. **requests.controller createRequest**: `validateData` con `status: 'JobStatus'` — `typeof status !== 'JobStatus'` è sempre true → usare `'string'`
3. **UserContext onAuthStateChange**: `fetchProfile` chiamata ma risultato non passato a `setProfile` — profilo non si aggiorna dopo cambio auth da altro tab
4. **BookingRecap getRole()**: async non awaited + `Bearer temp` hardcoded — guard ruolo non funziona
5. **BookingSuccess**: titoli `hasCleaners ? noCleanerTitle : title` invertiti
6. **PaymentResult**: `updateJobDatabase()` chiamata due volte (duplicato); `setTimeout 20000ms` probabilmente typo (dovrebbe essere 2000)
7. **Nessun middleware auth centralizzato**: JWT verificato solo implicitamente da Supabase quando si usa `getSupabaseForUser`
8. **profiles.service.getProfileByUserId**: usa client anon, non `getSupabaseForUser` — non rispetta RLS utente
9. **GET senza auth**: jobs/:id, cleaners/available, payments/create-checkout-session — verificare se intenzionalmente pubblici
10. **Nessun error handler globale Express** `(err, req, res, next)` — eccezioni non catturate danno 500 non formattato
11. **Route cleaner** (`/c-profile`, `/c-dashboard`): nessuna guard dedicata, protezione solo interna con timeout 20s
12. **`VITE_BACKEND_URL` ripetuto** in molti file — da centralizzare in modulo `api`
13. **Firebase foreground notifications**: `listenToForegroundNotifications` commentato in App.tsx

## Problemi aperti
- Unificare flusso post-pagamento (frontend-driven vs webhook-driven)
- Implementare scadenza payment_expires_at (cron o lazy)
- Configurare logrotate produzione
- Aggiungere campi strutturati a Pino (module, user_id, req_id)
- Migrare geofilter da client-side a server-side (eventuale PostGIS)
- Risolvere bug noti (vedi sezione sopra)
- Introdurre middleware auth centralizzato
- Introdurre CleanerRoute o protezione equivalente
- Centralizzare `VITE_BACKEND_URL` in un modulo unico

## Staging — blocchi da risolvere (2026-03-24)
Analisi fatta su branch `staging` (repo locale `~/trovapulizie`). Nessun branch `origin/v2`.

**Infrastruttura mancante:**
- `.env` assenti su disco (sia `front-end/.env` che `back-end/.env`) — gitignored ma mai creati localmente. Servono i valori per staging (Supabase, Stripe test keys, Firebase, ecc.)
- Nessun `ecosystem.config.js` — PM2 non configurato (e non installato sulla macchina locale)
- Nessuna config Nginx locale (`/etc/nginx/sites-available/` vuoto)

**Backend non pronto per produzione/staging:**
- `package.json` back-end ha solo `dev` (ts-node-dev) — manca script `build` (tsc) e `start` (node dist/)
- Serve decidere: compilazione TypeScript + PM2, oppure ts-node-dev anche in staging?

**Deploy:**
- `front-end-deploy.sh` esiste e punta a `root@46.16.90.190:/srv/trovapulizie/archives/` (produzione Serverplan)
- Non esiste script deploy per backend ne per staging
- Non esiste script/config per ambiente staging separato

**Prossimi step per staging:**
1. Creare `.env` per entrambi (frontend con `VITE_BACKEND_URL` staging, backend con Supabase/Stripe test keys)
2. Aggiungere script `build` e `start` al back-end `package.json`
3. Creare `ecosystem.config.js` per PM2 (o decidere alternativa)
4. Creare config Nginx per staging (subdomain o porta diversa)
5. Decidere dove gira staging: stessa macchina `46.16.90.190` o altra?
6. Creare deploy script per staging

## Note operative
Hardening tecnico (serverplan, monitoring, alerting, reliability, release gates) è parte integrante di questo progetto — non un progetto separato.
Accessi → secrets.md

## Storico
<!-- 2026-03-28 — Figma: creata schermata 5v2b Home/Indirizzo Mancante (toast warning + search bar highlight + helper text) ma DA RIFARE: search bar non corretta (usa componente generico invece di quella della Home), icone servizi sono emoji invece delle icone originali della Home. Problema: API Figma MCP restituisce 0 children per pagina Searcher Mobile (202:2) nonostante lo screenshot mostri ~30 schermate — impossibile leggere i nodi esistenti per copiare icone/search bar. Prossimo step: utente fornisce link diretto alla Home v2 o si risolve il bug API. Regola UX "indirizzo obbligatorio" documentata e confermata. Sitemap aggiornata. -->
<!-- 2026-03-27 — Figma: 7 nuove schermate (risultati ricerca caricamento + empty, profilo cleaner caricamento, pagamento form Stripe + caricamento + fallito, filtri bottom sheet con chip servizi/rating/disponibilità + range prezzo). Search bar mostra posizione, filtri contengono tipo servizio. Tasto filtri aggiunto accanto search bar. Decisione: split subdomain trovapulizie.it (landing) + app.trovapulizie.it (SPA). Sitemap aggiornata. -->
<!-- 2026-03-27 — Figma: Home v2 Dual Flow + stepper completo Flow A (5 schermate). Servizi: Condomini al posto di Vetri (Vetri → add-on). Add-on in Step 1: Pulizia vetri +€15, Stiratura +€10, Pulizia balcone +€8. Servizio pre-selezionato da ricerca/griglia. Sitemap aggiornata. -->
<!-- 2026-03-27 — Figma Searcher Mobile: 14 schermate (prenotazioni, assistente AI, ricerca, profilo cleaner) con varianti empty/loading/error. Flusso prenotazione unificato: Flow A (utente sceglie cleaner, lancio) + Flow B (match AI, futuro) con stepper condiviso. Diagramma FigJam. Sitemap aggiornata con stati. -->
<!-- 2026-03-24 — Analisi staging: infrastruttura mancante (.env, PM2, Nginx, build script backend, deploy script staging) -->
<!-- 2026-03-23 — Call strategia lancio: Instant Booking core, espansione microaree, recupero 120 cleaner, matchmaking IA, logo da rifare, assistente AI futuro -->
<!-- 2026-02-20 — inizio sviluppo con Digital On come socio -->
<!-- 2026-03-22 — onboarding vault — test controllati completati, pre-go-live -->
