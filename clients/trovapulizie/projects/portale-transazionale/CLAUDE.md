# Portale Transazionale — Trovapulizie S.R.L.
Tipo: Sito Web

## Obiettivo
Piattaforma transazionale per prenotazione e pagamento di servizi di pulizia. Booking flow completo fino a payment_success. Go-live commerciale Roma-first previsto 1 aprile 2026.

## Stato attuale
**Stato**: In corso
**Ultimo aggiornamento**: 2026-03-22
**Fase attuale**: Pre-go-live — test controllati completati, in attesa di go-live commerciale
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

## Prossimi passi
<!-- [ ] task — ID: TROVAPULIZIE-26-001 — entro: YYYY-MM-DD -->

## Problemi aperti
<!-- DA COMPLETARE dopo prima sessione di lavoro -->

## Note operative
Hardening tecnico (serverplan, monitoring, alerting, reliability, release gates) è parte integrante di questo progetto — non un progetto separato.
Accessi → secrets.md

## Storico
<!-- 2026-02-20 — inizio sviluppo con Digital On come socio -->
<!-- 2026-03-22 — onboarding vault — test controllati completati, pre-go-live -->
