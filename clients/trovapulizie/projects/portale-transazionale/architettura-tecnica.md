# Architettura Tecnica — Portale Transazionale TrovaPulizie

Ultimo aggiornamento: 2026-03-24
Fonte: repository GitHub `digital-on-agency/trovapulizie` (commit `2c17078`)

---

## Stack tecnologico

| Layer | Tecnologia | Versione |
|-------|-----------|----------|
| **Frontend** | React + TypeScript | React 18.3, TS 5.5 |
| **Build tool** | Vite | 5.4 |
| **Styling** | Tailwind CSS + Emotion | Tailwind 3.4, Emotion 11.14 |
| **Routing** | React Router DOM | 6.22 |
| **Backend** | Express (TypeScript) | Express 5.1, TS 5.8 |
| **Runtime backend** | ts-node-dev | 2.0 |
| **Database** | Supabase (PostgreSQL 15.8) | supabase-js 2.49 |
| **Auth** | Supabase Auth + RLS | integrato |
| **Pagamenti** | Stripe (Embedded Checkout / PaymentIntents) | stripe 18.1 |
| **Push notifications** | Firebase Cloud Messaging (Admin SDK) | firebase-admin 13.2 |
| **Mappe/Geocoding** | HERE Maps API | via axios |
| **Email/WhatsApp** | Webhook esterno (Make/Integromat) | EMAIL_WEBHOOK, MULTI_CHANNEL_WEBHOOK |
| **Logging** | Pino + pino-multi-stream | pino 9.6 |
| **Date/timezone** | Luxon (backend), Day.js + moment-timezone (frontend) | luxon 3.6 |
| **i18n** | i18next + react-i18next | i18next 23, react-i18next 14 |
| **Analytics** | GA4 + GTM | property 428236871, container GTM-WKN46NRS |
| **Animazioni** | Framer Motion | 12.23 |
| **Icone** | Lucide React | 0.344 |
| **Hosting** | VPS Serverplan (backend via PM2), frontend statico, DB Supabase cloud | eu-west-1 |
| **Reverse proxy** | Nginx | su VPS |
| **Deploy** | Manuale via SSH + script bash (`front-end-deploy.sh`) | — |

---

## Struttura repository

```
trovapulizie/                         # root — monorepo
├── front-end/                        # SPA React (Vite)
│   ├── src/
│   │   ├── App.tsx                   # Router, provider, tutte le route
│   │   ├── main.tsx                  # Entry point, monta App + i18n
│   │   ├── NotFound.tsx              # Pagina 404
│   │   ├── index.css                 # Tailwind base
│   │   ├── pages/                    # 22 pagine (vedi sezione Route)
│   │   ├── components/
│   │   │   ├── common/               # Header, Footer, LoadingSpinner, ErrorMessage
│   │   │   ├── JobDetailsModal.tsx   # Modal dettaglio job (44 KB — componente più grande)
│   │   │   ├── CheckoutOverlay.tsx   # Overlay Stripe checkout globale
│   │   │   ├── OffersListModal.tsx   # Lista offerte
│   │   │   ├── ReviewModal.tsx       # Modal recensione
│   │   │   ├── StripeCheckout.tsx    # Componente Stripe
│   │   │   ├── HowItWorks.tsx        # Sezione "Come funziona"
│   │   │   ├── FAQ.tsx               # Accordion FAQ
│   │   │   ├── Avatar.tsx            # Avatar utente
│   │   │   ├── BetaTestBanner.tsx    # Banner beta globale
│   │   │   └── FloatingPopup.tsx     # Popup UI
│   │   ├── context/
│   │   │   ├── UserContext.tsx       # Stato auth/profilo globale (Supabase session)
│   │   │   └── PaymentCheckoutContext.tsx  # Stato overlay Stripe
│   │   ├── hooks/
│   │   │   └── GTMTracker.tsx        # Pageview tracker su cambio route
│   │   ├── lib/
│   │   │   ├── analytics/
│   │   │   │   ├── events.ts         # Catalogo eventi GA4/GTM (18 KB)
│   │   │   │   └── gmt.ts           # Helper push GTM
│   │   │   ├── database/
│   │   │   │   ├── supabase.ts       # Client Supabase
│   │   │   │   └── dbUtils.ts        # Utility DB (fetchProfile, fetchCleanerProfile, etc.)
│   │   │   ├── firebase/
│   │   │   │   ├── firebase-config.ts
│   │   │   │   ├── messaging.ts      # Listener messaggi foreground
│   │   │   │   └── usePushNotification.ts  # Hook permesso + token FCM
│   │   │   ├── maps/
│   │   │   │   ├── AutocompleteAddress.tsx  # Componente autocomplete HERE Maps
│   │   │   │   └── autocomplete.ts
│   │   │   ├── stripe.ts            # Init Stripe JS
│   │   │   └── utils.ts             # Utility generiche
│   │   ├── models/                   # Interfacce TypeScript
│   │   │   ├── users.model.ts        # User, Profile, UserContextType
│   │   │   ├── job.model.ts          # Job, JobStatus
│   │   │   ├── request.model.ts      # Request
│   │   │   ├── services.model.ts     # ServiceType
│   │   │   ├── reviews.model.ts      # Review
│   │   │   ├── maps.model.ts         # HERE Maps response types
│   │   │   └── components.model.ts   # Prop types condivisi
│   │   ├── types/
│   │   │   └── cleaner.ts            # Tipo Cleaner
│   │   ├── i18n/
│   │   │   ├── index.ts              # Config i18next + language detector
│   │   │   └── locales/
│   │   │       ├── it.json           # Italiano (78 KB — completo)
│   │   │       ├── en.json           # Inglese (5 KB — parziale)
│   │   │       ├── de.json           # Tedesco (stub)
│   │   │       ├── es.json           # Spagnolo (stub)
│   │   │       └── fr.json           # Francese (stub)
│   │   └── styles/                   # Stili aggiuntivi
│   ├── batch-notify/                 # Cloudflare Worker (cron, stub — non implementato)
│   ├── public/                       # Asset statici
│   ├── firebase-messaging-sw.js      # Service worker FCM background
│   ├── index.html                    # Entry HTML (GTM/GA4 script inline)
│   ├── vite.config.ts                # Alias: @ → src, @styles → src/styles; porta 8080
│   ├── tailwind.config.js
│   ├── tsconfig.json / tsconfig.app.json
│   └── package.json
│
├── back-end/                         # API Express (TypeScript)
│   ├── src/
│   │   ├── server.ts                 # Bootstrap: importa app, listen su PORT (default 3001)
│   │   ├── app.ts                    # Config Express: CORS, JSON parser, mount router
│   │   ├── config/
│   │   │   ├── supabase.ts           # 3 client: supabase (anon), getSupabaseForUser(token), adminSupabase (service role)
│   │   │   ├── stripe.ts             # Init Stripe SDK (attualmente solo TEST_STRIPE_SECRET)
│   │   │   ├── firebase-admin.ts     # Firebase Admin SDK (service account JSON)
│   │   │   ├── firebase.ts           # Firebase client SDK (codice browser — non usabile server-side)
│   │   │   └── credentials/          # Service account JSON committato nel repo
│   │   ├── routes/                   # 11 file route (auth, cleaners, jobs, maps, notifications, payments, profiles, requests, reviews, searchers, services)
│   │   ├── controllers/              # 11 controller (thin — parsing + chiamata service + risposta)
│   │   ├── services/                 # 10 service + sottodirectory notifications/
│   │   │   ├── auth.service.ts       # Signup, login (+ fallback legacy bcrypt), reset password
│   │   │   ├── cleaners.service.ts   # CRUD cleaner, filtro disponibilità, ranking, instant booking eligibility
│   │   │   ├── jobs.service.ts       # CRUD job, transizioni stato, Supabase RPC
│   │   │   ├── requests.service.ts   # Lifecycle request, auto-assign cleaner, notifiche
│   │   │   ├── payment.service.ts    # Stripe Checkout Sessions, status check
│   │   │   ├── profiles.service.ts   # CRUD profili
│   │   │   ├── reviews.service.ts    # Recensioni, media rating
│   │   │   ├── maps.service.ts       # HERE Maps geocoding + Haversine
│   │   │   ├── searchers.service.ts  # CRUD searcher
│   │   │   ├── services.service.ts   # Tipi servizio
│   │   │   └── notifications/
│   │   │       ├── dispatcher.service.ts     # Orchestratore: preferenze → payload → invio
│   │   │       ├── email.service.ts          # Invio email via webhook
│   │   │       ├── push.service.ts           # FCM push via Firebase Admin
│   │   │       ├── messageFormatter.service.ts  # Template HTML email (56 KB)
│   │   │       ├── firebase.service.ts       # Codice client-side FCM (misplaced)
│   │   │       └── preferences.service.ts    # Helper preferenze
│   │   ├── models/                   # 8 interfacce TypeScript (cleaner, job, notification, profile, request, review, searcher, user)
│   │   ├── utils/
│   │   │   ├── general.utils.ts      # formatDate, validateData, convertDateToLocalTime (Luxon)
│   │   │   ├── geo.utils.ts          # Haversine distance (km)
│   │   │   ├── cleaner.utils.ts      # Trial period ranking, selectCleanersForOffer, isInstantBookingEligible
│   │   │   ├── notification.utils.ts # getUserPreferences
│   │   │   ├── availability.utils.ts # Stub
│   │   │   ├── job.utils.ts          # Helper job
│   │   │   ├── review.utils.ts       # Helper recensioni
│   │   │   └── stripe.utils.ts       # Vuoto
│   │   ├── logger/
│   │   │   └── index.ts              # Pino: file logs/combined.log + console pretty
│   │   └── steps-guide.md            # Guida interna
│   ├── logs/                         # Log file produzione
│   ├── tsconfig.json                 # target es2016, module commonjs, strict
│   └── package.json
│
├── db-migration/                     # Script migrazione MongoDB → Supabase
│   ├── index.js                      # Script esplorazione/dry-run
│   ├── updateCleaner.js              # Migrazione live: crea auth user + profilo + cleaner
│   ├── updateServices.js             # Upsert catalogo servizi in service_type
│   ├── data/
│   │   ├── trovapulizie.users.json   # Export MongoDB originale (871 KB)
│   │   ├── quartieri.geojson         # Poligoni quartieri Roma (631 KB)
│   │   ├── trovapulizie.services.json     # Servizi raw
│   │   ├── new_trovapulizie.services.json # Servizi consolidati (9 attivi + 43 deprecati)
│   │   └── updatedCleaner.json       # Output migrazione
│   └── package.json                  # deps: supabase-js, bcryptjs, @turf/turf, dotenv
│
├── launch-script/
│   └── relaunch-script.js            # Broadcast email rilancio piattaforma (via Make webhook)
│
├── executable/                       # Archivi tar.gz deploy (backend + frontend)
├── archives/                         # Build archiviate
├── front-end-deploy.sh               # Script deploy frontend: build → tar → scp su VPS
├── package.json                      # Root: dipendenze condivise (supabase-js, axios, bcryptjs, zod)
├── todo-list.md                      # JSDoc backlog
└── .gitignore
```

---

## Schema database (Supabase — schema public)

### Tabelle e relazioni

```
auth.users (Supabase managed)
    │
    ├──→ profiles (1:1) ──→ cleaners (1:1, role=cleaner)
    │                   └──→ searchers (1:1, role=searcher)
    │
    ├──→ notifications
    └──→ pushtokens

jobs ←── cleaners (cleaner_id)
     ←── searchers (searcher_id)
     ←── profiles (searcher_id, FK duplicata)
     ←── service_type (type)
     ──→ reviews

requests ←── searchers (searcher_id)

reviews ←── cleaners (cleaner_id)
        ←── searchers (searcher_id)
        ←── profiles (cleaner_id, searcher_id — FK duplicate)
        ←── jobs (job_id — FK duplicata)
```

### Dettaglio tabelle

**profiles** (232 righe, RLS attivo)
| Colonna | Tipo | Note |
|---------|------|------|
| user_id | uuid PK | FK → auth.users.id |
| role | text | CHECK: cleaner / searcher / admin |
| name | varchar | |
| email | text | UNIQUE, nullable |
| phone | text | nullable |
| avatar_url | text | nullable |
| migrated_psw | boolean | default false — flag migrazione legacy |
| legacy_hash | text | nullable — hash bcrypt vecchia password, azzerato dopo primo login |
| created_at / updated_at | timestamp | default now() |

**cleaners** (212 righe, RLS attivo)
| Colonna | Tipo | Note |
|---------|------|------|
| user_id | uuid PK | FK → profiles.user_id |
| bio | text | nullable |
| services | jsonb | CHECK: array con almeno 1 elemento |
| availability | jsonb | CHECK: object — struttura `{ giorno: { start, end } }` |
| rating | numeric | 0–5, default 0.0 |
| reviews_count | integer | default 0 |
| location | varchar | CHECK: non vuoto |
| radius | integer | km, default 3 |
| coordinates | jsonb | `{ lat, lng }` gradi decimali |
| hourly_rate | float8 | default 0.0 |
| preferences | jsonb | `{ notification: { email, browser, whatsapp } }` |
| old_cleaner | boolean | default false — flag migrazione |
| instant_booking | boolean | default false |
| instant_booking_offset | smallint | ore minime per prenotazione istantanea |

**searchers** (20 righe, RLS attivo)
| Colonna | Tipo | Note |
|---------|------|------|
| user_id | uuid PK | FK → profiles.user_id |
| preferences | jsonb | nullable — notifiche e preferenze |

**jobs** (112 righe, RLS attivo)
| Colonna | Tipo | Note |
|---------|------|------|
| id | uuid PK | |
| cleaner_id | uuid | FK → cleaners.user_id |
| searcher_id | uuid | FK → searchers.user_id + profiles.user_id |
| status | text | CHECK: pending / confirmed / done / rejected / paid / payment_pending |
| type | text | FK → service_type.id, default 'unknow' |
| location | text | indirizzo |
| price | numeric | CHECK ≥ 0 |
| hours | integer | CHECK > 0 |
| description | text | nullable |
| requested_at | timestamp | default now() |
| confirmed_at | timestamp | nullable |
| executed_at | timestamp | nullable |
| rejected_at | timestamp | nullable |
| paid_at | timestamptz | nullable |

**requests** (4 righe, RLS attivo)
| Colonna | Tipo | Note |
|---------|------|------|
| id | uuid PK | |
| searcher_id | uuid | FK → searchers.user_id |
| status | text | CHECK: open / accepted / canceled |
| service_type | varchar | CHECK: non vuoto |
| description | text | nullable |
| location | varchar | CHECK: non vuoto |
| date | timestamp | |
| hours | integer | CHECK > 0, default 1 |
| selected_cleaners | uuid[] | array di cleaner selezionati |
| budget | jsonb | `{ cleaner_id: prezzo }` |
| requested_at | timestamp | default now() |
| accepted_at | timestamp | nullable |
| canceled_at | date | nullable |

**reviews** (2 righe, RLS attivo)
| Colonna | Tipo | Note |
|---------|------|------|
| id | uuid PK | |
| cleaner_id | uuid | FK → cleaners + profiles |
| searcher_id | uuid | FK → searchers + profiles |
| job_id | uuid | FK → jobs.id |
| rating | integer | CHECK: 1–5 |
| comment | text | nullable |
| date | timestamp | default now() |

**notifications** (0 righe, RLS attivo)
| Colonna | Tipo | Note |
|---------|------|------|
| id | uuid PK | |
| user_id | uuid | FK → auth.users.id |
| type | varchar | CHECK: non vuoto |
| message | text | CHECK: non vuoto |
| created_at | timestamp | default now() |

**pushtokens** (0 righe, RLS **disattivato**)
| Colonna | Tipo | Note |
|---------|------|------|
| user_id | uuid | PK composita (user_id, token) |
| token | text | UNIQUE |
| device_info | text | |
| updated_at | timestamp | default now() |

**service_type** (9 righe, RLS attivo)
| Colonna | Tipo | Note |
|---------|------|------|
| id | text PK | slug (es. `pulizia_domestica`) |
| name_it | text | |
| name_en | text | nullable |
| name_es | text | nullable |
| updated_at | timestamptz | default now() |

Servizi attivi: `pulizia_domestica`, `pulizia_uffici`, `pulizia_scale`, `sanificazioni`, `pulizia_tappezzeria`, `pulizie_commerciali_e_comunità`, `pulizie_industriali`, `pulizie_ambienti_sanitari`, `pulizia_esterni`

### Funzioni RPC Supabase

Il backend usa `supabase.rpc()` per:
- `get_jobs_by_cleaner` — job per cleaner con join
- `get_requests_by_cleaner` — request per cleaner con join

Queste sono funzioni PostgreSQL definite lato Supabase (non nel repo).

---

## Flussi principali

### 1. Registrazione e autenticazione

```
[Searcher/Cleaner Signup Page]
  → POST /api/auth/signup (Supabase Auth signUp)
  → POST /api/profiles/ (crea profilo con ruolo)
  → POST /api/cleaners/ o /api/searchers/ (crea record specifico)
  → Notifica welcome (email via webhook)

[Login]
  → POST /api/auth/login
    → signInWithPassword (Supabase)
    → Se fallisce: controlla legacy_hash (bcrypt) → se match:
      → adminSupabase.auth.admin.updateUserById (migra password)
      → Retry login
      → Azzera legacy_hash e migrated_psw

[Frontend: UserContext]
  → supabase.auth.getSession() al mount
  → fetchProfile() dal backend
  → onAuthStateChange listener per sessione
```

### 2. Ricerca e prenotazione diretta (Job)

```
[Home / Quarter Landing / ServiceRequestDetails]
  → Utente seleziona tipo servizio, data, indirizzo
  → sessionStorage: serviceRequestData

[SearchResults]
  → GET /api/cleaners/available?date&time&job_type&lat&lng
    → Backend carica TUTTI i cleaner dal DB
    → Filtra in-memory: disponibilità, raggio Haversine, tipo servizio
  → POST /api/cleaners/sort (ranking: trial period + rating)
  → Utente seleziona cleaner → sessionStorage: selectedCleaner

[BookingRecap]
  → Conferma dettagli
  → POST /api/jobs/ (status: pending, requested_at)
  → Notifica cleaner (push/email/webhook)

[Cleaner accetta]
  → PUT /api/jobs/:id/c-accept
    → Verifica executed_at ≥ 1h futuro
    → Imposta confirmed_at

[Pagamento]
  → POST /api/payments/create-checkout-session/
    → Stripe Checkout Session (embedded)
    → Ritorna clientSecret
  → PaymentCheckoutContext → CheckoutOverlay mostra Stripe Embedded Checkout
  → GET /api/payments/check-session-status/:session_id
  → POST /api/jobs/:id/pay → status: paid
```

### 3. Instant Booking

```
[BookingRecap — cleaner con instant_booking=true]
  → POST /api/jobs/instant-booking
    → isInstantBookingEligible(cleaner, executed_at)
      → Verifica instant_booking=true
      → Verifica differenza temporale ≥ instant_booking_offset ore
    → Crea job status: payment_pending
    → Crea PaymentIntent Stripe, salva payment_intent_id
    → Ritorna { job_id, client_secret }
  → Pagamento immediato via Stripe Embedded Checkout
  → Conferma via Stripe (TODO: unificare webhook vs frontend-driven)
```

### 4. Make Offer (Request)

```
[Searcher crea richiesta]
  → POST /api/requests/
    → Crea request (status: open)
    → Auto-seleziona cleaner
    → Notifica cleaner selezionati

[Cleaner fa offerta]
  → PUT /api/requests/:id/budget
    → Aggiorna JSONB budget con { cleaner_id: prezzo }

[Searcher accetta offerta]
  → PUT /api/requests/:id/accept
    → Imposta accepted_at
  → POST /api/payments/create-checkout-session/ (job_or_request: 'request')
  → Pagamento Stripe
  → POST /api/jobs/request-to-job (crea job da request)
```

### 5. Notifiche

```
[Dispatcher (notifications/dispatcher.service.ts)]
  → Legge preferenze utente (email/browser/whatsapp)
  → Per ogni canale abilitato:
    → Email: POST a EMAIL_WEBHOOK con HTML da messageFormatter (56 KB template)
    → WhatsApp: POST a MULTI_CHANNEL_WEBHOOK
    → Push: Firebase Admin SDK → FCM con token da tabella pushtokens

[Tipi di notifica]
  - cleaner-welcome, searcher-welcome (signup)
  - job-request (nuova richiesta)
  - job-rejected, cleaner-job-cancelled, searcher-job-cancelled
  - success-payment, job-paid, offer-accepted-and-paid
  - support-email (form help)

[Push background]
  → firebase-messaging-sw.js (service worker con config Firebase hardcoded)
```

### 6. Recensioni

```
[Dopo completamento job]
  → POST /api/reviews/ (rating 1-5, commento opzionale, job_id)
  → GET /api/reviews/?cleaner_id (lista per cleaner)
  → GET /api/reviews/summary?cleaner_id (media + conteggio)
```

---

## Pattern architetturali

### Backend
- **Layered architecture**: routes → controllers (thin) → services (business logic) → models
- **Singleton config**: Supabase, Stripe, Firebase inizializzati una volta in `src/config/`
- **Dual Supabase client**: `supabase` (anon) per query pubbliche, `getSupabaseForUser(token)` per query con RLS, `adminSupabase` (service role) solo per migrazione password
- **No middleware auth centralizzato**: JWT estratto manualmente in ogni controller via `Authorization` header
- **No global error handler**: nessun `(err, req, res, next)` Express
- **Multi-channel notification**: dispatcher che smista su email/push/WhatsApp in base a preferenze utente
- **Geospatial filtering in-memory**: tutti i cleaner caricati dal DB, filtrati con Haversine in Node.js

### Frontend
- **React Context** (no Redux/Zustand): `UserContext` per auth/profilo, `PaymentCheckoutContext` per Stripe overlay
- **sessionStorage come ponte tra step**: `serviceRequestData`, `selectedCleaner`, `redirectAfterAuth`, `paymentAmount`
- **Pagine grandi**: SearchResults (43 KB), CleanerProfile (33 KB), CleanerDashboard (29 KB) — logica inline nelle pagine
- **Route guard parziali**: `ProtectedRoute` (redirect logged-in), `SearcherRoute` (richiede ruolo searcher). Nessun `CleanerRoute` dedicato
- **API calls non centralizzate**: `fetch` + `VITE_BACKEND_URL` ripetuto in molti file; utility parziali in `dbUtils.ts`
- **SEO quartieri**: 21 route statiche per quartieri di Roma usando componente `Quarter-Landing.tsx` parametrizzato
- **i18n**: italiano completo (78 KB), inglese parziale, altre lingue stub

### Deploy
- **Manuale**: `front-end-deploy.sh` → build → tar → scp su VPS (`root@46.16.90.190`)
- **Nginx**: reverse proxy `/api/*` → backend localhost:3001, resto → file statici frontend
- **PM2**: process manager per backend in produzione
- **No CI/CD**: nessuna pipeline automatica

---

## Variabili d'ambiente

### Frontend (`front-end/.env`)

| Variabile | Scopo |
|-----------|-------|
| `VITE_SUPABASE_URL` | URL progetto Supabase |
| `VITE_SUPABASE_ANON_KEY` | Anon key Supabase |
| `VITE_BACKEND_URL` | Base URL API backend |
| `VITE_STRIPE_PUBLISHABLE` | Stripe publishable key |
| `VITE_STRIPE` | Stripe secret key (presente nel template frontend) |
| `VITE_HERE_MAPS_API_ID` | HERE Maps App ID |
| `VITE_HERE_MAPS_API_KEY` | HERE Maps API Key |
| `VITE_HERE_MAPS_BASE_URL` | HERE Maps base URL |
| `VITE_FIREBASE_API_KEY` | Firebase API Key |
| `VITE_FIREBASE_AUTH_DOMAIN` | Firebase Auth Domain |
| `VITE_FIREBASE_PROJECT_ID` | Firebase Project ID (`trovapulizie-5022b`) |
| `VITE_FIREBASE_STORAGE_BUCKET` | Firebase Storage Bucket |
| `VITE_FIREBASE_MESSAGING_SENDER_ID` | Firebase Messaging Sender ID |
| `VITE_FIREBASE_APP_ID` | Firebase App ID |
| `VITE_FIREBASE_VAPID_KEY` | VAPID key per push notifications |
| `VITE_SUPPORT_MAIL_ADDRESS` | Email supporto |
| `VITE_SUPPORT_MAIL_WEBHOOK` | Webhook email supporto |
| `VITE_SUPPORT_MULTI_CHANNEL_WEBHOOK` | Webhook multi-canale supporto |
| `VITE_JOB_CANCELLING_TIME` | Tempo max cancellazione job (ms) |

### Backend (`back-end/.env`)

| Variabile | Scopo |
|-----------|-------|
| `PORT` | Porta server (default 3001) |
| `FRONTEND_URL` | URL frontend per CORS |
| `SUPABASE_URL` | URL Supabase |
| `SUPABASE_ANON_KEY` | Anon key |
| `SUPABASE_SERVICE_ROLE_KEY` | Service role key (non nel template, usata nel codice) |
| `STRIPE_SECRET` | Stripe live secret key |
| `TEST_STRIPE_SECRET` | Stripe test secret key (attualmente unica in uso) |
| `HERE_MAPS_API_ID` | HERE Maps App ID |
| `HERE_MAPS_API_KEY` | HERE Maps API Key |
| `GEOCODE_URL` | URL geocoding HERE Maps |
| `FIREBASE_API_KEY` | Firebase API Key |
| `FIREBASE_AUTH_DOMAIN` | Firebase Auth Domain |
| `FIREBASE_PROJECT_ID` | Firebase Project ID |
| `FIREBASE_STORAGE_BUCKET` | Firebase Storage Bucket |
| `FIREBASE_MESSAGING_SENDER_ID` | Firebase Messaging Sender ID |
| `FIREBASE_APP_ID` | Firebase App ID |
| `FIREBASE_VAPID_KEY` | VAPID Key |
| `EMAIL_WEBHOOK` | Webhook invio email (Make) |
| `MULTI_CHANNEL_WEBHOOK` | Webhook multi-canale (Make) |

---

## Dipendenze principali

### Frontend (`front-end/package.json`)

| Pacchetto | Versione | Uso |
|-----------|----------|-----|
| react / react-dom | ^18.3.1 | UI framework |
| react-router-dom | ^6.22.3 | Routing SPA |
| @supabase/supabase-js | ^2.49.4 | Client Supabase |
| @stripe/react-stripe-js | ^3.7.0 | Componenti Stripe React |
| @stripe/stripe-js | ^7.3.0 | Stripe JS SDK |
| stripe | ^18.1.0 | Stripe SDK (presente ma usato lato server) |
| firebase | ^10.8.1 | FCM client |
| i18next | ^23.10.1 | Internazionalizzazione |
| react-i18next | ^14.1.0 | Binding React i18n |
| axios | ^1.6.7 | HTTP client |
| framer-motion | ^12.23.11 | Animazioni |
| lucide-react | ^0.344.0 | Icone |
| dayjs | ^1.11.13 | Date |
| moment-timezone | ^0.5.48 | Date con timezone |
| @emotion/react / styled | ^11.14.0 | CSS-in-JS (uso limitato) |
| react-helmet | ^6.1.0 | Meta tag SEO |
| react-animated-numbers | ^1.1.1 | Animazione numeri |
| uuid | ^11.1.0 | Generazione UUID |
| cors | ^2.8.5 | CORS (presente ma usato server-side) |
| tailwindcss | ^3.4.1 | CSS utility-first (dev) |
| vite | ^5.4.15 | Build tool (dev) |
| typescript | ^5.5.3 | TypeScript (dev) |

### Backend (`back-end/package.json`)

| Pacchetto | Versione | Uso |
|-----------|----------|-----|
| express | ^5.1.0 | Web framework |
| @supabase/supabase-js | ^2.49.4 | Client Supabase |
| stripe | ^18.1.0 | Stripe SDK |
| firebase-admin | ^13.2.0 | FCM server-side |
| firebase | ^11.6.0 | Firebase client (misplaced) |
| pino | ^9.6.0 | Logger strutturato |
| pino-multi-stream | ^6.0.0 | Multi-destination logging |
| luxon | ^3.6.1 | Date/timezone (Europe/Rome) |
| bcryptjs | ^3.0.2 | Hash verifica legacy password |
| axios | ^1.8.4 | HTTP client (geocoding) |
| cors | ^2.8.5 | CORS middleware |
| dotenv | ^16.4.7 | Env vars |
| ts-node-dev | ^2.0.0 | Dev server con hot reload |
| typescript | ^5.8.3 | TypeScript (dev) |

### Root (`package.json`)

| Pacchetto | Versione | Uso |
|-----------|----------|-----|
| @supabase/supabase-js | ^2.58.0 | Condiviso (usato da db-migration) |
| @material-tailwind/react | ^2.1.10 | UI components (non chiaro dove usato) |
| axios | ^1.12.2 | HTTP |
| bcryptjs | ^3.0.2 | Hash |
| zod | ^4.1.11 | Validazione schema |
| p-limit | ^7.1.1 | Concurrency limiter |
| react-animated-numbers | ^1.1.1 | Animazione |

---

## Note per refactoring

### Consolidato e funzionante
- Architettura layered backend (routes → controllers → services) è chiara e coerente
- Sistema notifiche multi-canale con dispatcher e template HTML
- Flusso auth con migrazione legacy password da MongoDB
- Schema DB Supabase con RLS su tutte le tabelle tranne pushtokens
- SEO landing pages per quartieri di Roma
- Analytics GA4/GTM con catalogo eventi ampio

### In evoluzione / da consolidare
- **Instant Booking**: funzionalità nuova, flusso post-pagamento da unificare (frontend-driven vs webhook Stripe)
- **Scadenza payment_expires_at**: non implementata (cron o lazy da decidere)
- **Stripe in modalità test**: live key dichiarata ma non usata
- **Filtro geospaziale in-memory**: carica tutti i cleaner e filtra con Haversine — non scala. Candidato per PostGIS
- **Nessun middleware auth centralizzato**: JWT verificato ad-hoc in ogni controller
- **Nessun error handler globale Express**: errori non catturati danno 500 non formattato
- **`VITE_BACKEND_URL` sparso**: nessun modulo API centralizzato nel frontend
- **Pagine frontend monolitiche**: SearchResults (43 KB), CleanerProfile (33 KB) — candidati per decomposizione in componenti
- **Guard route incomplete**: nessun `CleanerRoute` dedicato — protezione solo interna con timeout
- **i18n incompleto**: solo italiano completo; en parziale; de/es/fr stub
- **Cloudflare Worker batch-notify**: stub, non implementato
- **Logrotate**: non configurato in produzione
- **Pino logger**: campi strutturati (module, user_id, req_id) pianificati ma non ancora aggiunti
- **Firebase foreground notifications**: commentate in App.tsx

### Problemi di sicurezza nel repo
- Firebase Admin service account JSON committato in `back-end/src/config/credentials/`
- Supabase service_role key hardcoded in `launch-script/relaunch-script.js`
- Credenziali MongoDB/DigitalOcean visibili in `db-migration/old-Back-end-connection.md`
- `VITE_STRIPE` (secret key) nel template env frontend — verrebbe esposta nel bundle
- `firebase-messaging-sw.js` con config Firebase hardcoded (accettabile per FCM client)

### Bug noti documentati
1. `auth.service.resetPassword` usa `getSupabaseForUser(email)` invece di `(token)`
2. `requests.controller createRequest` validateData con `status: 'JobStatus'` — typeof fallisce sempre
3. `UserContext onAuthStateChange` fetchProfile non passata a setProfile
4. `BookingRecap getRole()` async non awaited + `Bearer temp` hardcoded
5. `BookingSuccess` titoli invertiti (hasCleaners/noCleanerTitle)
6. `PaymentResult` updateJobDatabase duplicata + setTimeout 20000ms (probabile typo)
7. `profiles.service.getProfileByUserId` usa client anon — non rispetta RLS utente
8. Diversi endpoint GET senza auth (jobs/:id, cleaners/available, payments/create-checkout-session)
9. Nessun error handler globale Express
10. Route cleaner senza guard dedicata
11. `firebase.service.ts` nel backend usa API browser (codice morto server-side)
12. `expresss` (doppia s) nel package.json backend — dipendenza typo/inutile
