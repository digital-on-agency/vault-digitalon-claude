# Dev Log — Portale Transazionale TrovaPulizie

## Stato refactor

Refactor verticale (FE+BE+DB) della Cleaner Dashboard. Obiettivo: ridurre le ~35 chiamate FE a 1-2 max, spostare aggregazione/logica nel backend, rendere il frontend "dumb".

Approccio scelto: **1 endpoint unico** `GET /api/cleaners/dashboard/:cleaner_id` con progressive enhancement via `?include=jobs,stats` + endpoint separato per reviews `POST .../reviews` con `job_ids`. Rollback via feature flag FE.

Stato: **Step A (jobs UI-ready) in corso** — endpoint creato, query funzionante con join e grouping per status. Step B (reviews batch) parzialmente implementato.

## Task in corso

### Step A — Jobs UI-ready (N→1): lista job pronta per render
- Endpoint `GET /api/cleaners/dashboard/:cleaner_id?include=jobs,stats`
- Query Supabase con join su `profiles` (searcher_name) e `service_type` (type_label)
- Flattening oggetti annidati nel backend
- Raggruppamento per status in 4 bucket: `pending`, `to_confirm`, `upcoming`, `recent`
- Ordinamento per `executed_at` ASC fatto in query (più efficiente che in Node)
- Ritorna anche `review_job_ids` (job done/paid) per la seconda chiamata

### Step B — Reviews batch per job_ids
- Endpoint `POST /api/cleaners/dashboard/:cleaner_id/reviews` con body `{ jobs_id: [...] }`
- Query con `WHERE job_id IN (...)` + chunking a 200 per evitare query troppo grandi
- Join su `profiles` per `searcher_name` via FK `reviews_searcher_id_fkey1`
- Ritorna `reviewsByJobId: { [jobId]: Review[] }`

## Task completate

### Routing Express — conflitto `:user_id` catch-all
- **Com'era**: `GET /api/cleaners/dashboard/` veniva intercettato da `router.get('/:user_id', ...)` che interpretava "dashboard" come user_id
- **Piano**: mettere le route specifiche (`/dashboard/:cleaner_id`) prima di quelle parametriche (`/:user_id`). Aggiungere route esplicita per `/dashboard` senza id che ritorna 400
- **Troubleshooting**: l'ordine delle route era già corretto, ma senza `cleaner_id` nell'URL la route `/dashboard/:cleaner_id` non matchava e Express cadeva su `/:user_id`
- **Com'è ora**: route `/dashboard/:cleaner_id` registrata prima di `/:user_id`; route `/dashboard` senza parametro ritorna 400 esplicito. Opzione futura: regex UUID su `:user_id` per evitare match accidentali

### Controller base + parsing `include` query params
- **Com'era**: nessun endpoint aggregato per la dashboard
- **Piano**: creare controller che estrae `cleaner_id` da `req.params` e `include` da `req.query`, normalizzando in `Set` con allowlist (`jobs`, `reviews`, `stats`, `earnings`). Default: `jobs` se vuoto
- **Com'è ora**: controller `getCleanerDashboardData` funzionante con parsing robusto di include (gestisce stringa singola, array, valori separati da virgola)

### Fix FK reviews → profiles per join searcher_name
- **Com'era**: query reviews con `.select("*, searcher_name: profiles!reviews_searcher_id_fkey(name)")` falliva con errore "Could not find a relationship between reviews and profiles"
- **Piano**: usare il nome FK corretto verso profiles
- **Troubleshooting**: `reviews_searcher_id_fkey` punta a `searchers`, non a `profiles`. La FK verso profiles è `reviews_searcher_id_fkey1`
- **Com'è ora**: query usa `profiles!reviews_searcher_id_fkey1(name)` — funzionante

### Indice su reviews.job_id
- **Com'era**: nessun indice su `reviews.job_id` — query `WHERE job_id IN (...)` non ottimizzata
- **Piano**: creare indice btree per velocizzare le query batch
- **Com'è ora**: `CREATE INDEX idx_reviews_job_id ON public.reviews USING btree (job_id)` — attivo

## Task future

### Step C — Stats aggregate dal backend
- Aggiungere `include=stats` all'endpoint dashboard
- Calcolo server-side: totalJobs, completedJobs, cancelledJobs, pendingJobs, earningsLast30Days
- Decisione aperta: stats su tutti i job del cleaner (query aggregata DB) vs subset paginato (dichiarare esplicitamente)
- Per earnings: valutare se integrare `supabase.rpc('get_total_earnings_last_30_days')` nello stesso payload o separarlo

### Step D1 — Job actions server-side (accept/reject/cancel)
- Endpoint unico `POST /api/jobs/:jobId/action` con body `{ action: "accept"|"reject"|"cancel" }`
- Validazioni e permessi centralizzati (solo cleaner assegnato può agire)
- Update atomico job + invio notifica nello stesso flusso
- Risposta UI-ready per aggiornamento immediato FE
- Sostituisce: `PUT /c-accept`, `PUT /c-reject` + chiamate notifica separate dal FE

### Step D2 — Notifiche idempotenti & retry-safe
- Idempotency key per ogni azione (jobId + action + timestamp o UUID)
- Persistenza evento notifica con vincolo unicità
- Gestione retry senza doppioni
- Rimuovere chiamate dirette FE a `POST /api/notifications/...`

### Step D3 — Side effects & auditing
- Log strutturato per ogni action (chi, cosa, quando, jobId, stato prima/dopo, esito notifica)
- Event record persistente per auditing
- Valutare esecuzione side effects sincrona vs asincrona (coda/worker)
- Metriche base: conteggio action per tipo, % fallimenti notifica

### Step D4 — Test & rollout (actions + notifiche)
- Feature flag `useJobActionsV2` (default OFF)
- Test correttezza state machine (transizioni stato consentite)
- Test permessi/sicurezza (solo cleaner assegnato)
- Test idempotenza (stessa request ripetuta → no doppioni)
- Test notifiche end-to-end
- Rollout graduale dev → staging → %

### Test & rollout dashboard V2 (read model)
- Feature flag `useCleanerDashboardV2` (default OFF)
- Confronto V1 vs V2 su set cleaner reali (pochi job, molti job, con/senza review)
- Benchmark: # chiamate FE, TTFB, payload size, tempo UI pronta
- Test error handling (endpoint parziale, stati loading/empty/error)
- Rollback testato (flag OFF → vecchio flusso senza deploy BE)

## Decisioni architetturali

| Decisione | Motivazione |
|-----------|-------------|
| 1 endpoint unico con `include=` | Progressive enhancement, rollback facile, FE può attivare pezzi incrementalmente |
| 2-3 query mirate + merge BE (no join gigante) | Evita duplicazione righe, payload prevedibile, paginazione più semplice |
| Reviews in endpoint separato POST con job_ids | Payload minimo, tempo percepito migliore (jobs prima, reviews dopo), FE non calcola nulla |
| `review_job_ids` nella prima risposta | Pattern B "return reviewTargets" — sposta logica "chi può avere reviews" nel BE senza token/cache |
| Grouping per status in BE (non FE) | 1 passata O(n) nel backend, FE riceve bucket pronti (`pending`, `to_confirm`, `upcoming`, `recent`) |
| Ordinamento in query DB | DB sfrutta indici, evita O(n log n) in Node ad ogni richiesta |
| Chunking reviews a 200 | Evita query/payload troppo grandi su IN clause |
| Actions (D1-D3) separate dal read model | Read = velocità/payload; Write = consistenza/idempotenza — domini diversi |
