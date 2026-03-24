# Troubleshooting Log — Portale Transazionale

Storico dei problemi tecnici riscontrati e relative soluzioni. Utile per evitare di ripetere gli stessi errori e come riferimento per debug futuri.

## Database e Supabase

### Signup 500 "Database error saving new user"
**Problema**: INSERT diretto in `auth.users` tramite SQL non crea utenti validi nel sistema di autenticazione Supabase.
**Soluzione**: Usare sempre `supabase.auth.signUp` (client) o `supabase.auth.admin.createUser` (server). La tabella `auth.users` è gestita internamente da Supabase Auth e non supporta INSERT manuali.

### RLS blocca INSERT su profiles (errore 42501)
**Problema**: `new row violates row-level security policy for table "profiles"` durante signup.
**Causa**: RLS attivo ma nessuna policy per INSERT.
**Soluzione**: Creare policy con `WITH CHECK (auth.uid() = user_id)` per permettere all'utente autenticato di inserire il proprio profilo. Stesso pattern applicato a `searchers` e `cleaners`.

### FK mancante causa errore PostgREST (PGRST200)
**Problema**: `Searched for a foreign key relationship between 'jobs' and 'cleaners' but no matches were found` quando si tenta una join.
**Causa**: Supabase PostgREST richiede FK esplicite per risolvere le join automatiche nella sintassi `.select('*, cleaners(*)')`.
**Soluzione**: Aggiungere foreign key esplicita: `jobs.cleaner_id → cleaners.user_id`.

### Trigger rating/reviews_count non si aggiorna
**Problema**: Dopo INSERT in `reviews`, i campi `rating` e `reviews_count` in `cleaners` restano invariati.
**Causa**: La funzione trigger non aveva permessi per aggiornare `cleaners` a causa di RLS.
**Soluzione**: Usare `SECURITY DEFINER` sulla funzione trigger per bypassare RLS, oppure creare una policy che permetta a trigger/funzioni di aggiornare la tabella.

### Duplicate key su profiles_pkey (23505)
**Problema**: `duplicate key value violates unique constraint "profiles_pkey"` durante creazione cleaner.
**Causa**: Tentativo di creare un profilo per un `user_id` già esistente (es. retry dopo errore parziale).
**Soluzione**: Verificare esistenza del profilo prima di INSERT, oppure usare upsert dove appropriato.

### Constraint troppo restrittivo su reviews
**Problema**: `UNIQUE(searcher_id, cleaner_id)` impediva a un searcher di lasciare più di una recensione allo stesso cleaner (per job diversi).
**Soluzione**: Rimosso il constraint unique; la logica "una recensione per job" è gestita a livello applicativo.

### Check constraint violation su budget (23514)
**Problema**: Update del campo `budget` in `requests` fallisce per violazione constraint.
**Causa**: Formato dati passato non corrispondente al tipo JSONB atteso.
**Soluzione**: Verificare che il payload sia un oggetto JSONB valido con la struttura `{ cleaner_id: amount }`.

## Autenticazione

### Password recovery senza sessione attiva
**Problema**: `supabase.auth.updateUser` fallisce perché l'utente non ha una sessione attiva quando arriva dalla email di reset.
**Causa**: Il link email contiene un hash token, non un access token. Senza sessione, updateUser non può funzionare.
**Soluzione**: Usare `supabase.auth.exchangeCodeForSession(code)` per ottenere una sessione dal token nell'URL, poi eseguire updateUser con la sessione attiva.

### Rate limit su signup massivo (429)
**Problema**: `Request rate limit reached` durante migrazione bulk di utenti con `auth.signUp`.
**Causa**: Supabase applica rate limiting anche a frequenze moderate se le richieste sono ravvicinate (burst-sensitive).
**Soluzione**: Introdurre delay di 3 secondi tra ogni signup. Per sicurezza aggiuntiva, implementare retry con backoff esponenziale.

## Notifiche e FCM

### FCM permission timing — browser blocca richieste automatiche
**Problema**: `Notification.requestPermission()` chiamata su page load viene bloccata silenziosamente dal browser.
**Soluzione**: Richiedere il permesso notifiche solo dopo un'azione esplicita dell'utente (es. click su "Attiva notifiche"). I browser moderni ignorano o negano le richieste di permesso non originate da interazione utente.

### Make webhook — payload email vs WhatsApp
**Problema**: Confusione sul formato dati da inviare al webhook Make per notifiche multi-canale.
**Chiarimento**: Email e WhatsApp hanno payload separati. Il rate limiting degli invii è gestito da Make (scenario con sleep/iterator), non dal codice applicativo. Il codice invia solo il trigger al webhook con i dati del destinatario e del messaggio.

## React e frontend

### `timeRange.split is not a function` su availability
**Problema**: Funzione `isTimeInRange` fallisce perché si aspetta una stringa `"HH:MM-HH:MM"` ma riceve un oggetto.
**Causa**: Il campo `availability` nel DB è un oggetto `{startTime: '09:00', endTime: '18:00', isAvailable: true}`, non una stringa.
**Soluzione**: Adattare `isTimeInRange` per accettare il formato oggetto e accedere a `startTime`/`endTime` come proprietà.

### `useLocation` fuori da Router — errore LinkWithRef
**Problema**: `Error at LinkWithRef ... at Header` — componenti che usano hook di react-router (`useLocation`, `useNavigate`, `Link`) crashano.
**Causa**: Il componente si trova nell'albero React al di sopra di `<BrowserRouter>`, quindi non ha accesso al contesto del router.
**Soluzione**: Assicurarsi che tutti i componenti che usano hook/componenti di react-router siano figli di `<BrowserRouter>`. Nel progetto, `Header` deve essere dentro `AppContent` (che è dentro `Router`), non al livello di `App`.

## Backend e API

### 404 su nuove API routes
**Problema**: Endpoint appena creato risponde 404 nonostante il file route esista.
**Causa**: La route è definita nel file router ma non è montata in `app.ts`.
**Soluzione**: Due step necessari: (1) definire la route nel file `routes/*.route.ts`, (2) montarla in `app.ts` con `app.use('/api/<dominio>', router)`. Mancarne uno dei due causa 404.

### Bearer token extraction — formato JWT
**Problema**: Token estratto da `Authorization` header non funziona con Supabase.
**Soluzione**: Pattern corretto: `const token = req.headers.authorization?.split(' ')[1]`. Verificare che il token abbia formato JWT valido (3 parti separate da `.`). Se il formato è diverso, restituire 401 prima di passarlo a `getSupabaseForUser`.

## Stripe e pagamenti

### `client_secret` non è nell'URL di redirect
**Problema**: Confusione su dove si trova il `client_secret` dopo il checkout Stripe.
**Chiarimento**: Solo `session_id` viene passato come query param nella redirect URL (`/checkout/successful-payment?session_id=...`). Il `client_secret` si ottiene dalla risposta di `createCheckoutSession` e va nel PaymentCheckoutContext React, mai esposto in URL.

### Errore "multiple Embedded Checkout objects"
**Problema**: Stripe lancia errore se esistono più istanze di `EmbeddedCheckoutProvider` contemporaneamente.
**Soluzione**: Una sola istanza di `EmbeddedCheckoutProvider` a livello app (CheckoutOverlay in App.tsx). Le pagine di pagamento impostano solo `clientSecret` nel context — non devono creare un secondo EmbeddedCheckout.

### Catena useEffect nella payment result page
**Problema**: Logica post-pagamento in un unico useEffect causa race condition e chiamate premature.
**Soluzione**: Separare in useEffect distinti con dipendenze corrette: (1) checkSession → accessToken, (2) sessionId → checkStatus, (3) paymentSuccess → fetch job/request, (4) jobInfos/requestInfos → updateDB + notifiche. Ogni step dipende dal risultato del precedente.

## Infrastruttura e configurazione

### `require is not defined` nel backend
**Problema**: `ReferenceError: require is not defined` all'avvio del server.
**Causa**: Il progetto è configurato come ES modules (`"type": "module"` in package.json).
**Soluzione**: Usare `import` invece di `require`. Per librerie CommonJS, usare `import pkg from 'package'` o `createRequire`.

### Delete utenti fallisce per catena FK
**Problema**: Impossibile eliminare utenti dalla dashboard Supabase — "User not found" o errori FK.
**Causa**: Catena di dipendenze: `auth.users` ← `identities`, `mfa_factors`, `sessions` (lato auth) + `profiles` ← `cleaners`/`searchers`, `jobs`, `requests`, `reviews` (lato applicativo).
**Soluzione**: Cleanup manuale ordinato — eliminare prima le entità dipendenti (reviews, jobs, requests, cleaners/searchers, profiles) e poi l'utente auth. I cascade non sono sufficienti per tutte le dipendenze.
