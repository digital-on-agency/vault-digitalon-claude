# CRM & Tracking — Trovapulizie S.R.L.
Tipo: CRM

## Obiettivo
Strutturare il tracking degli eventi chiave sulla piattaforma e configurare una dashboard KPI per monitorare le performance operative e di business in tempo reale.

## Stato attuale
**Stato**: Attivo
**Ultimo aggiornamento**: 2026-03-23
**Fase attuale**: Setup — configurazione dashboard KPI in corso

## Stack
**Analytics**: GA4 — property ID 428236871
**CRM/Ops**: Airtable (single source of truth operativa)
**Tag Management**: GTM — container ID `GTM-WKN46NRS`
**Dashboard**: DA DEFINIRE

## KPI da tracciare
<!-- DA DEFINIRE — da allineare con il team -->
- Prenotazioni completate
- Tasso di conversione booking
- Cleaner attivi / disponibili
- Transazioni completate vs abbandonate
- Retargeting audiences

## Integrazione GTM
GTM integrato su React Router via hook custom `useGTMPageView` (in `src/hooks/GTMTracker.tsx`):
- Hook usa `useLocation()` per tracciare cambi route come `virtual_pageview` su `window.dataLayer`
- Tre componenti GTM nell'app:
  1. Script GTM in `<head>` — loader asincrono gtm.js
  2. `<noscript>` iframe fallback in `<body>` — per utenti senza JS
  3. Hook React `useGTMPageView` in `AppContent` — SPA page tracking
- `dataLayer` dichiarato globalmente: `declare global { interface Window { dataLayer: Array<Record<string, any>> } }`
- Funzione `pushGtm` in `lib/analytics/gmt.ts` per push eventi custom (es. `flow_step`, `track_sign_up`, `track_payment_completed`, `track_ui_interaction`)

## Decisioni prese
[DEFAULT] 2026-03-23 — Configurare dashboard KPI piattaforma — Matti — entro 04/04/2026

## Prossimi passi
- [ ] Configurare dashboard KPI piattaforma — Matti — entro: 2026-04-04

## Problemi aperti
<!-- Nessun blocco attivo al momento -->

## Note operative
Airtable è il layer operativo/CRM — GA4 per analytics web.
Accessi → secrets.md

## Storico
<!-- 2026-03-23 — onboarding vault — KPI dashboard identificata come priorità pre-lancio -->
