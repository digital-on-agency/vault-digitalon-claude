# Trovapulizie S.R.L.

## Identità cliente
**Ragione sociale**: Trovapulizie S.R.L.
**Settore**: Marketplace digitale — prenotazione e gestione servizi pulizia, sanificazione, facility management
**Dimensione**: Startup innovativa early-stage — team core snello con specialisti part-time/esterni
**Da quando è cliente**: 2026-02-20
**Contratto**: Misto — componente continuativa su GTM, prodotto, CRM, tracking
**Priorità account**: Alta

## Comunicazione
**Referente principale**: Guido — accountable GTM, prodotto, decisioni go/no-go <!-- DA COMPLETARE: contatto -->
**Altri contatti**: Christian — governance <!-- DA COMPLETARE: contatto -->
**Canale preferito**: WhatsApp / Meet
**Frequenza aggiornamenti**: Settimanale
**Tono da usare**: Diretto, operativo, KPI-driven
**Note relazionali**: Guido è il decisore principale. Christian coinvolgere su governance. Team interno: Nicolò, Mattia + specialisti part-time su reliability e security.

## Vincoli e decisioni trasversali
[BLOCCATO] 2026-04-01 — Go-live commerciale Roma-first — strategia approvata
[ATTENZIONE] Pre-go-live: decisioni tecniche e GTM hanno impatto diretto su fundraising
[DEFAULT] 2026-03-23 — Espansione per microaree (qualità > copertura), no lancio aggressivo su tutta Roma
[DEFAULT] 2026-03-23 — Priorità assoluta sull'assorbimento offerta (cleaner) prima di generare domanda
[DEFAULT] 2026-03-23 — Metodo di lavoro: brain dump settimanale → call → task in roadmap
[DEFAULT] 2026-03-23 — Nuovi stati task: "Bloccato" e "Collo di bottiglia"
[DEFAULT] 2026-03-24 — Video promozionale investor: SaaS trailer UI-only, 20–30s, freelancer Fiverr
[DEFAULT] 2026-03-24 — Feature video investor: AI assistant cleaner + checklist + reminder + riepilogo guadagni
[ATTENZIONE] 2026-03-24 — Route ottimizzata ESCLUSA dal video: non rispecchia il funzionamento reale (slot fissi)
[DEFAULT] 2026-03-24 — Matchmaking AI (preferenze implicite da feedback) = feature investor-facing prioritaria, da valutare per inclusione nel video

## Ecosistema tecnico condiviso
**Domini**: trovapulizie.it
**Stack**: TypeScript full-stack — frontend asset statici, backend API separato
**Analytics**: GA4 — property ID 428236871
**Ads**: In setup/go-live 2026 — Google Search local intent + Meta/retargeting
**Repository**: GitHub (TypeScript full-stack) — https://github.com/digital-on-agency/trovapulizie.git
**Repo locale VPS**: /home/niccolo/trovapulizie (clonata 2026-03-29)
**Airtable Record ID (Business)**: rec84e8gl0Ga4abrb
**Integrazioni trasversali**: Airtable (single source of truth operativa/CRM), Supabase
**Google Workspace**: trovapulizie.it@gmail.com
**Hosting strategy**: Backend su VPS esterno (non Bluehost — incompatibilità Node), frontend statico su Bluehost (public_html/), DB su Supabase
**Target risorse**: 2 vCPU, 2GB RAM, 20GB SSD; ~5k utenti registrati, 50-100 concorrenti attivi
**Brand & UI**: Colore primario `#00C896` (verde), background secondario `#F0FBF7`, testo `#1A1A1A`. Font Inter. Tailwind default senza custom config — colori applicati direttamente nei componenti.
**Figma Design System**: https://www.figma.com/design/UiW4TPgvqCODW5bhyFV5eK — v2.0, aggiornato 2026-03-29 (Cover + Styles + Components + Screens Searcher Mobile)
**Accessi sensibili**: → clients/trovapulizie/secrets.md

## Progetti
| ID | Nome progetto | Tipo | Stato | Path |
|----|---------------|------|-------|------|
| reckfYqRUf9oFIV9q | Portale Transazionale | Sito Web | Attivo | clients/trovapulizie/projects/portale-transazionale/ |
| recKGTVY9wYbKM24z | Paid Ads | Ads | Attivo | clients/trovapulizie/projects/paid-ads/ |
| recE1N3FD5rpVlJWf | SEO | SEO | Attivo | clients/trovapulizie/projects/seo/ |
| recYVmZc1Ty5HFelf | CRM & Tracking | CRM | Attivo | clients/trovapulizie/projects/crm-tracking/ |
| rec3TrvmAcx5qaWcx | Partnership PM | Generico | Attivo | clients/trovapulizie/projects/partnership-pm/ |
| recOy0DaOECLLZsEh | Acquisizione Cleaner | Generico | Attivo | clients/trovapulizie/projects/brand-identity/ |
| recJm38vTzSikTZxY | GTM & Lancio Roma | Generico | Attivo | clients/trovapulizie/projects/gtm-lancio-roma/ |
| recQIdbGIE4T4lcxU | Brand Identity | Generico | Attivo | clients/trovapulizie/projects/brand-identity/ |

## Storico attività
<!-- 2026-03-29 — Figma sessione 3: 10 nuove schermate Profilo & Settings + flusso referral + verifica identità. Nuove schermate: Aggiungi Metodo di Pagamento (19e), Menu Profilo 3 puntini con 7 voci (19f), Assistenza FAQ con 6 domande accordion (19g), Contattaci bottom sheet Email/WhatsApp/In-app (19h), Invita un Amico con codice referral + share WhatsApp (19i), Impostazioni Notifiche con toggle canali + tipo (19j), Lingua con 5 opzioni (19k), Verifica Documento upload CI/Patente/Passaporto + numero (20a), Documento Inviato conferma (20b), Bottom sheet verifica richiesta nel checkout (13c2), Step 4 Conferma + Sconto Applicato con -€10 (13b). Aggiunte al profilo originale (19): banner verifica identità arancione con 3 stati (non verificato/pending/verificato). Aggiunto campo codice sconto permanente nel checkout Step 4 (13a). Icone SVG custom su tutte le voci menu profilo (campanella, globo, invita, assistenza, termini, esci, cestino), bottom sheet cambia foto (camera, galleria, cestino), dropdown notifiche (campanella, archivio). Fix bottom sheet corner radius (solo top rounded). Rimossi 3 puntini da tutte le schermate secondarie — restano solo su Profilo (19), Notifiche (6/6b), Profilo Cleaner (09/9c/9d/9e). Note sviluppo aggiunte: CTA dinamico 20b (origin checkout/profile), banner verifica profilo (3 stati + campo DB), Termini e Privacy (link esterno nuova scheda). Schermate mancanti identificate per prossima sessione: Lascia recensione, Elimina account conferma, Cambio password, Ricevuta pagamento. -->
<!-- 2026-03-29 — Figma sessione 2: 7 nuove schermate (dropdown Notifiche 6b, dropdown Profilo Cleaner 9c, bottom sheet Segnala 9d, Condividi 9e, skeleton Dettaglio Prenotazione 16f, Cambia Foto 19c, Aggiungi Indirizzo 19d). Icone SVG custom su Profilo Utente (casa, ufficio, carta) e Modifica Profilo (fotocamera solid). Icone dropdown Notifiche (double-check, ingranaggio, archivio). Riordinamento frame Searcher Mobile per sezione. Search bar Home v2 spostata sotto hero card. Fix bottom bar Home v2. Rimossi 3 puntini Risultati Ricerca. -->
<!-- 2026-03-29 — Figma: dropdown menu 3 puntini Notifiche (6b): 3 voci (Segna tutte come lette verde, Impostazioni notifiche, Archivia lette) con icone Lucide-style, separatori, backdrop semitrasparente. Aggiornato sitemap. -->
<!-- 2026-03-29 — Figma: revisione design system (spaziature Modifica Prenotazione, uniformità border-radius CTA 24→12 su 4 pulsanti, margini bottom sheet). Toggle Instant Booking nei Filtri (sostituisce chip, icona SVG da Home v2, posizionato tra Servizio e Prezzo). 5 nuove schermate/elementi: pulsante Aggiungi al calendario (14), toast conferma modifica (16c), modale annulla prenotazione (16d), bottom sheet contatta cleaner con Chiama/WhatsApp/Messaggio in-app (16e), Modifica Profilo (19b). Revisione Profilo Utente: rimosse freccette Dati Personali. -->
<!-- 2026-03-27 — Figma: 7 nuove schermate Searcher Mobile (risultati ricerca caricamento/empty, profilo cleaner caricamento, pagamento + caricamento + fallito, filtri bottom sheet). Search bar aggiornata a posizione (non servizio). Filtri: tipo servizio (chip) al posto di zona. Tasto filtri aggiunto accanto search bar. Decisione architetturale: split subdomain trovapulizie.it (landing SEO) + app.trovapulizie.it (SPA loggata). -->
<!-- 2026-03-27 — Figma: Home v2 Dual Flow (hero card Flow B AI Match + divider + servizi). Stepper prenotazione Flow A completo: Step 1 Servizio (6 servizi + add-on vetri/stiratura/balcone), Step 2 Data/Ora (calendario + fasce orarie), Step 3 Dettagli (indirizzo, durata, piano, note), Step 4 Conferma (riepilogo + breakdown prezzo), Success. Decisione: Vetri → add-on (non servizio isolato), Condomini sostituisce Vetri nella griglia. Servizio pre-selezionato se utente arriva da ricerca. -->
<!-- 2026-03-27 — Figma: create 14 schermate Searcher Mobile (prenotazioni 5 varianti + dettaglio, assistente AI 4 varianti, risultati ricerca, profilo cleaner). Aggiunto componente Empty State/Error. Diagramma FigJam flusso prenotazione unificato (Flow A: utente sceglie cleaner, Flow B: match AI). Definita architettura stepper condiviso A+B. -->
<!-- 2026-03-26 — Elaborato design system, componenti dashboard searcher, componenti AI assistant, sitemap portale (tutto su Figma) -->
<!-- 2026-03-24 — Aggiornato CLAUDE.md con colori reali portale (#00C896 verde) e nota palette Figma da aggiornare -->
<!-- 2026-03-24 — Creato Figma Design System v1.0: Cover, Styles (palette + tipografia), Components, Screens — Video Demo -->
<!-- 2026-03-24 — Call video promozionale: definito formato SaaS trailer UI-only 20-30s, feature confermate (AI assistant, checklist, reminder, riepilogo), route ottimizzata esclusa, matchmaking AI come feature investor-facing. Partecipanti: Guido, Matti. Vedi calls/2026-03-24-video-promozionale.md -->
<!-- 2026-03-23 — Call strategia lancio: definito metodo lavoro (brain dump settimanale), focus Instant Booking, espansione microaree, recupero 120 cleaner, marketing organico/volantinaggio, logo da rifare, assistente AI in-app futuro. Partecipanti: Guido, Niccolò, Matti, Christian. Vedi calls/2026-03-23-strategia-lancio.md -->
<!-- 2026-03-23 — Creati 3 nuovi progetti: Acquisizione Cleaner, GTM & Lancio Roma, Brand Identity -->
<!-- 2026-02-20 — inizio collaborazione -->
