# Database Schema — TrovaPulizie

Progetto Supabase: `uzqxvktrsmxumjnlzuzd` (regione: eu-west-1)
PostgreSQL: 15.8.1.100
Stato: ACTIVE_HEALTHY
Creato: 2025-03-10

---

## Tabelle

### profiles (232 righe) — RLS attiva

Estende `auth.users` con informazioni aggiuntive per Cleaners e Searchers.

| Campo | Tipo | Nullable | Default | Vincoli | Descrizione |
|-------|------|----------|---------|---------|-------------|
| `user_id` | uuid | NO | — | PK, FK → auth.users.id | ID univoco dell'utente |
| `role` | text | NO | — | CHECK: cleaner, searcher, admin | Ruolo dell'utente |
| `name` | varchar | NO | — | — | Nome completo |
| `phone` | text | SI | — | — | Numero di telefono |
| `email` | text | SI | — | UNIQUE | Email dell'utente |
| `avatar_url` | text | SI | — | — | URL avatar |
| `migrated_psw` | boolean | NO | false | — | Flag migrazione password dal vecchio DB |
| `legacy_hash` | text | SI | — | — | Hash vecchia password (nullato dopo primo login nuovo) |
| `created_at` | timestamp | SI | now() | — | Data registrazione |
| `updated_at` | timestamp | SI | now() | — | Ultimo aggiornamento |

### cleaners (212 righe) — RLS attiva

Informazioni specifiche per i professionisti delle pulizie.

| Campo | Tipo | Nullable | Default | Vincoli | Descrizione |
|-------|------|----------|---------|---------|-------------|
| `user_id` | uuid | NO | — | PK, FK → profiles.user_id | ID cleaner |
| `bio` | text | SI | — | — | Descrizione breve |
| `services` | jsonb | NO | — | CHECK: array con almeno 1 elemento | Servizi offerti (es. ["Pulizia Domestica", "Sanificazione"]) |
| `availability` | jsonb | NO | — | CHECK: deve essere oggetto | Disponibilita per giorni/orari |
| `location` | varchar | NO | — | CHECK: non vuoto | Zona geografica operativa |
| `coordinates` | jsonb | NO | {"lat": 0.0, "lng": 0.0} | — | Coordinate GPS |
| `radius` | integer | SI | 3 | CHECK: >= 0 | Raggio di azione in km |
| `hourly_rate` | float8 | NO | 0.0 | — | Tariffa oraria in euro |
| `rating` | numeric | SI | 0.0 | CHECK: 0-5 | Media recensioni |
| `reviews_count` | integer | SI | 0 | CHECK: >= 0 | Numero totale recensioni |
| `preferences` | jsonb | SI | {"notification": {"email": true, "browser": true, "whatsapp": true}} | — | Preferenze notifiche e altro |
| `old_cleaner` | boolean | NO | false | — | Flag cleaner migrato dal vecchio DB |
| `instant_booking` | boolean | NO | false | — | Prenotazione istantanea abilitata |
| `instant_booking_offset` | smallint | SI | — | — | Ore di anticipo per instant booking |

### searchers (20 righe) — RLS attiva

Informazioni specifiche per i clienti che cercano servizi di pulizia.

| Campo | Tipo | Nullable | Default | Vincoli | Descrizione |
|-------|------|----------|---------|---------|-------------|
| `user_id` | uuid | NO | — | PK, FK → profiles.user_id | ID searcher |
| `preferences` | jsonb | SI | {"notification": {"email": true, "browser": true, "whatsapp": true}} | CHECK: null o oggetto | Preferenze (servizi, disponibilita, notifiche) |

### jobs (112 righe) — RLS attiva

Lavori richiesti dai searcher ed eseguiti dai cleaner.

| Campo | Tipo | Nullable | Default | Vincoli | Descrizione |
|-------|------|----------|---------|---------|-------------|
| `id` | uuid | NO | gen_random_uuid() | PK | ID univoco del lavoro |
| `cleaner_id` | uuid | NO | — | FK → cleaners.user_id | Cleaner assegnato |
| `searcher_id` | uuid | NO | — | FK → searchers.user_id, FK → profiles.user_id | Searcher richiedente |
| `type` | text | NO | 'unknow' | FK → service_type.id | Tipo di servizio |
| `status` | text | NO | — | CHECK: pending, confirmed, done, rejected, paid, payment_pending | Stato del lavoro |
| `description` | text | SI | — | — | Descrizione del lavoro |
| `location` | text | NO | — | — | Indirizzo del lavoro |
| `hours` | integer | NO | — | CHECK: > 0 | Ore di lavoro |
| `price` | numeric | SI | — | CHECK: >= 0 | Prezzo totale |
| `requested_at` | timestamp | NO | now() | — | Quando e stato richiesto |
| `confirmed_at` | timestamp | SI | — | — | Quando e stato confermato |
| `executed_at` | timestamp | SI | — | — | Quando e stato eseguito |
| `rejected_at` | timestamp | SI | — | — | Quando e stato rifiutato |
| `paid_at` | timestamptz | SI | — | — | Quando e stato pagato |

### requests (4 righe) — RLS attiva

Richieste di pulizia pubblicate dai Searchers (sistema di offerta).

| Campo | Tipo | Nullable | Default | Vincoli | Descrizione |
|-------|------|----------|---------|---------|-------------|
| `id` | uuid | NO | gen_random_uuid() | PK | ID richiesta |
| `searcher_id` | uuid | NO | — | FK → searchers.user_id | Searcher che ha pubblicato |
| `status` | text | NO | 'open' | CHECK: open, accepted, canceled | Stato della richiesta |
| `service_type` | varchar | NO | — | CHECK: non vuoto | Tipo di servizio richiesto |
| `description` | text | SI | — | — | Descrizione dettagliata |
| `location` | varchar | NO | — | CHECK: non vuoto | Indirizzo/area del servizio |
| `date` | timestamp | NO | — | — | Data/ora richieste |
| `hours` | integer | NO | 1 | CHECK: > 0 | Ore di lavoro |
| `selected_cleaners` | uuid[] | NO | '{}' | — | Array di cleaner selezionati |
| `budget` | jsonb | NO | '{}' | — | Mappa cleaner_id → prezzo offerto |
| `requested_at` | timestamp | NO | now() | — | Quando e stata inserita |
| `accepted_at` | timestamp | SI | — | — | Quando e stata accettata |
| `canceled_at` | date | SI | — | — | Quando e stata cancellata |

### reviews (2 righe) — RLS attiva

Recensioni lasciate dai Searchers ai Cleaners dopo un servizio.

| Campo | Tipo | Nullable | Default | Vincoli | Descrizione |
|-------|------|----------|---------|---------|-------------|
| `id` | uuid | NO | gen_random_uuid() | PK | ID recensione |
| `job_id` | uuid | NO | — | FK → jobs.id | Lavoro associato |
| `cleaner_id` | uuid | NO | — | FK → cleaners.user_id, FK → profiles.user_id | Cleaner recensito |
| `searcher_id` | uuid | NO | — | FK → searchers.user_id, FK → profiles.user_id | Searcher autore |
| `rating` | integer | NO | — | CHECK: 1-5 | Valutazione stelle |
| `comment` | text | SI | — | — | Testo recensione |
| `date` | timestamp | NO | now() | — | Data recensione |

### notifications (0 righe) — RLS attiva

Notifiche inviate agli utenti in tempo reale.

| Campo | Tipo | Nullable | Default | Vincoli | Descrizione |
|-------|------|----------|---------|---------|-------------|
| `id` | uuid | NO | gen_random_uuid() | PK | ID notifica |
| `user_id` | uuid | NO | — | FK → auth.users.id | Destinatario |
| `type` | varchar | NO | — | CHECK: non vuoto | Tipo (es. new_request, new_offer) |
| `message` | text | NO | — | CHECK: non vuoto | Contenuto |
| `created_at` | timestamp | SI | now() | — | Data/ora |

### pushtokens (0 righe) — RLS **disattivata**

Token push per notifiche ai dispositivi.

| Campo | Tipo | Nullable | Default | Vincoli | Descrizione |
|-------|------|----------|---------|---------|-------------|
| `user_id` | uuid | NO | — | PK (composita), FK → auth.users.id | Utente |
| `token` | text | NO | — | PK (composita), UNIQUE | Token dispositivo |
| `device_info` | text | NO | — | — | Info dispositivo |
| `updated_at` | timestamp | SI | now() | — | Ultimo aggiornamento |

### service_type (9 righe) — RLS attiva

Tabella di riferimento per i tipi di servizio, con traduzioni multilingua.

| Campo | Tipo | Nullable | Default | Vincoli | Descrizione |
|-------|------|----------|---------|---------|-------------|
| `id` | text | NO | — | PK | ID mnemonico (basato sul nome EN) |
| `name_it` | text | NO | — | — | Nome in italiano |
| `name_en` | text | SI | — | — | Nome in inglese |
| `name_es` | text | SI | — | — | Nome in spagnolo |
| `updated_at` | timestamptz | NO | now() | — | Ultimo aggiornamento |

---

## Relazioni (Foreign Keys)

```
auth.users.id ──────┬── profiles.user_id (PK)
                     ├── notifications.user_id
                     └── pushtokens.user_id

profiles.user_id ───┬── cleaners.user_id (PK)
                    ├── searchers.user_id (PK)
                    ├── reviews.cleaner_id (fk1)
                    └── reviews.searcher_id (fk1)

cleaners.user_id ───┬── jobs.cleaner_id
                    └── reviews.cleaner_id

searchers.user_id ──┬── jobs.searcher_id
                    ├── requests.searcher_id
                    └── reviews.searcher_id

jobs.id ────────────── reviews.job_id

service_type.id ────── jobs.type
```

**Nota:** Alcune FK sono duplicate (es. `reviews.cleaner_id` punta sia a `cleaners.user_id` che a `profiles.user_id`, e `jobs.searcher_id` punta sia a `searchers.user_id` che a `profiles.user_id`). Questo e intenzionale per permettere JOIN diretti senza passare dalla tabella intermedia.

---

## Policy RLS

### profiles

| Policy | Operazione | Ruoli | Condizione | Scopo |
|--------|-----------|-------|------------|-------|
| all can see profiles | SELECT | anon, authenticated | true | Tutti possono vedere i profili |
| Allow authenticated users to view their own profiles | SELECT | authenticated | auth.uid() = user_id | Ridondante con la precedente |
| Allow all users to create profiles | INSERT | anon, authenticated | true (with_check) | Chiunque puo creare un profilo (necessario per la registrazione) |
| update_own_profile | UPDATE | public | auth.uid() = user_id | Ogni utente modifica solo il proprio profilo |

### cleaners

| Policy | Operazione | Ruoli | Condizione | Scopo |
|--------|-----------|-------|------------|-------|
| Allow read access to all users | SELECT | public | true | Tutti possono vedere i cleaner |
| Allow insert for authenticated users | INSERT | public | auth.uid() = user_id | Si puo creare solo il proprio record cleaner |
| insert_own_cleaner | INSERT | public | auth.uid() = user_id | Duplicato della precedente |
| update_own_cleaner | UPDATE | public | auth.uid() = user_id | Ogni cleaner modifica solo il proprio profilo |
| allow_server_update_for_trigger | UPDATE | public | true | Permette al trigger di aggiornare rating/reviews_count |

### searchers

| Policy | Operazione | Ruoli | Condizione | Scopo |
|--------|-----------|-------|------------|-------|
| Authenticated users can select from searchers | SELECT | authenticated | true | Utenti autenticati vedono tutti i searcher |
| Any user can insert into searchers | INSERT | anon, authenticated | true | Chiunque puo creare un record searcher |
| Users can update their own searchers records | UPDATE | authenticated | auth.uid() = user_id | Ogni searcher modifica solo il proprio record |
| Users can delete their own searchers records | DELETE | authenticated | auth.uid() = user_id | Ogni searcher puo cancellare il proprio record |

### jobs

| Policy | Operazione | Ruoli | Condizione | Scopo |
|--------|-----------|-------|------------|-------|
| Allow read access to everyone | SELECT | public | true | Tutti vedono i lavori |
| Authenticated users can view all jobs | SELECT | authenticated | true | Ridondante con la precedente |
| Allow insert for authenticated searchers | INSERT | public | auth.uid() = searcher_id | Solo il searcher crea il proprio job |
| Authenticated users can update any job | UPDATE | authenticated | true | Qualsiasi utente autenticato puo aggiornare un job |

### requests

| Policy | Operazione | Ruoli | Condizione | Scopo |
|--------|-----------|-------|------------|-------|
| Only authenticated users can view requests | SELECT | authenticated | true | Solo utenti autenticati vedono le richieste |
| Only authenticated searchers can insert requests | INSERT | authenticated | auth.uid() in searchers | Solo chi e searcher puo creare richieste |
| Only authenticated users can update requests | UPDATE | authenticated | true | Qualsiasi utente autenticato puo aggiornare |

### reviews

| Policy | Operazione | Ruoli | Condizione | Scopo |
|--------|-----------|-------|------------|-------|
| Allow read access to everyone | SELECT | public | true | Tutti vedono le recensioni |
| Allow searchers to insert reviews | INSERT | authenticated | searcher_id = auth.uid() AND role = 'searcher' | Solo il searcher puo lasciare la propria recensione |

### notifications

Nessuna policy RLS definita (tabella con RLS attiva ma senza policy = nessun accesso via API).

### pushtokens

| Policy | Operazione | Ruoli | Condizione | Scopo |
|--------|-----------|-------|------------|-------|
| select_own_push_token | SELECT | public | auth.uid() = user_id | Vedi solo i propri token |
| insert_own_push_token | INSERT | public | auth.uid() = user_id | Inserisci solo i propri token |
| update_own_push_token | UPDATE | public | auth.uid() = user_id | Aggiorna solo i propri token |

### service_type

| Policy | Operazione | Ruoli | Condizione | Scopo |
|--------|-----------|-------|------------|-------|
| Enable read access for all users | SELECT | public | true | Tabella di riferimento leggibile da tutti |

---

## Funzioni

### Funzioni di query

| Funzione | Argomenti | Ritorna | Scopo |
|----------|-----------|---------|-------|
| `get_profile_by_uid` | uid uuid | profiles | Ritorna il profilo di un utente |
| `get_jobs_by_cleaner` | cleaner_uuid uuid | SETOF jobs | Tutti i lavori di un cleaner |
| `get_jobs_by_searcher` | searcher_uuid uuid | SETOF jobs | Tutti i lavori di un searcher |
| `get_requests_by_cleaner` | cleaner_uuid uuid | TABLE(request_id uuid) | ID richieste dove il cleaner e selezionato |
| `get_total_earnings_by_cleaner` | cleaner_uid uuid | numeric | Guadagni totali di un cleaner |
| `get_total_earnings_last_30_days` | cleaner_uid uuid | numeric | Guadagni ultimi 30 giorni |
| `get_user_email_by_id` | uid uuid | text | Email da auth.users |
| `get_account_created_at` | uid uuid | timestamp | Data creazione account da auth.users |

### Funzioni di business logic

| Funzione | Argomenti | Ritorna | Scopo |
|----------|-----------|---------|-------|
| `assign_cleaners_to_request` | request_id uuid, cleaner_ids uuid[] | requests | Assegna un array di cleaner a una richiesta |
| `add_cleaner_offer_to_budget` | req_id uuid, cleaner_id uuid, offer numeric | void | Aggiunge l'offerta di un cleaner al budget di una richiesta (verifica che sia tra i selezionati) |

### Funzioni di migrazione/utility

| Funzione | Argomenti | Ritorna | Scopo |
|----------|-----------|---------|-------|
| `copy_emails_to_profiles` | — | void | Copia email da auth.users a profiles (migrazione) |
| `update_emails_in_profiles` | — | void | Aggiorna email in profiles da auth.users |

### Funzioni trigger

| Funzione | Ritorna | Scopo |
|----------|---------|-------|
| `update_cleaner_average_rating` | trigger | Ricalcola rating e reviews_count del cleaner dopo INSERT/UPDATE/DELETE su reviews |

---

## Trigger

| Trigger | Tabella | Evento | Timing | Funzione |
|---------|---------|--------|--------|----------|
| `trg_update_rating` | reviews | INSERT, UPDATE, DELETE | AFTER | `update_cleaner_average_rating()` |

Quando una recensione viene creata, modificata o cancellata, il trigger ricalcola automaticamente la media delle stelle e il conteggio recensioni sulla tabella `cleaners`.

---

## Edge Functions

Nessuna Edge Function presente nel progetto.

---

## Autenticazione

- **Provider attivo:** solo `email`
- Nessun provider OAuth configurato (Google, Facebook, ecc.)
- Presenti campi per gestione migrazione password dal vecchio database (`migrated_psw`, `legacy_hash` in profiles)

---

## Estensioni PostgreSQL attive

| Estensione | Versione | Scopo |
|------------|----------|-------|
| plpgsql | 1.0 | Linguaggio procedurale PL/pgSQL |
| uuid-ossp | 1.1 | Generazione UUID |
| pgcrypto | 1.3 | Funzioni crittografiche |
| pgjwt | 0.2.0 | Gestione JWT |
| pgsodium | 3.1.8 | Crittografia libsodium |
| supabase_vault | 0.3.1 | Gestione secrets |
| pg_graphql | 1.5.11 | API GraphQL automatica |
| pg_stat_statements | 1.10 | Statistiche query |

---

## Note architetturali

1. **Modello utente a 3 livelli:** `auth.users` → `profiles` → `cleaners`/`searchers`. Il profilo base e condiviso, le tabelle specializzate contengono i dati specifici per ruolo.

2. **Doppia FK su reviews e jobs:** Alcune tabelle hanno foreign key ridondanti (es. `reviews.cleaner_id` punta sia a `cleaners` che a `profiles`). Questo semplifica le JOIN ma crea duplicazione di vincoli.

3. **Sistema di richieste vs job diretti:** Coesistono due flussi:
   - **Jobs:** prenotazione diretta searcher → cleaner
   - **Requests:** il searcher pubblica una richiesta, seleziona cleaner, questi fanno offerte via `budget` (jsonb), poi si accetta

4. **RLS permissiva sugli UPDATE di jobs:** Qualsiasi utente autenticato puo aggiornare qualsiasi job. Questo e un punto di attenzione per la sicurezza — probabilmente dovrebbe essere ristretto a cleaner e searcher coinvolti.

5. **Policy duplicate:** Ci sono alcune policy ridondanti (es. due INSERT su cleaners, due SELECT su jobs e profiles). Non causano problemi ma andrebbero pulite.

6. **RLS disattivata su pushtokens:** Nonostante le policy siano definite, RLS non e attiva sulla tabella. I token push sono accessibili senza restrizioni via API.

7. **Notifications senza policy:** La tabella ha RLS attiva ma nessuna policy definita, il che blocca qualsiasi accesso via API Supabase. Le notifiche probabilmente vengono gestite solo lato server.

8. **Migrazione dal vecchio DB:** Il campo `legacy_hash` in profiles e il flag `old_cleaner` in cleaners indicano una migrazione da un database precedente. `legacy_hash` viene nullato dopo il primo login nel nuovo sistema.

9. **Instant booking:** I campi `instant_booking` e `instant_booking_offset` su cleaners supportano un sistema di prenotazione immediata con un offset di ore minimo.

10. **Multilingua limitata:** Solo la tabella `service_type` ha traduzioni (IT/EN/ES). Il resto dei contenuti e in italiano.
