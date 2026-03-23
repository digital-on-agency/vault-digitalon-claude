# SEO legalepompei.it — Studio Legale Pompei
Tipo: SEO

## Obiettivo
Costruire visibilità organica locale per Studio Legale Pompei su Cassino, Formia, Latina, Frosinone. Obiettivo secondario: citabilità nei motori AI (GEO). Risultati attesi: Local SEO 90-180gg, SEO organico 6-12 mesi.

## Stato attuale
**Stato**: In corso
**Ultimo aggiornamento**: 2026-03-23
**Fase**: Fase 1 — Fondamenta tecniche (2 fix completati in sessione 2026-03-23)
**Dominio**: legalepompei.it
**CMS**: Webflow (hosted)
**Accesso CMS**: → secrets.md

## Tool
**Google Search Console**: legalepompei.it (accesso attivo)
**Google Analytics**: <!-- DA COMPLETARE: GA4 property ID -->
**Rank tracker**: Ahrefs
**Semrush**: usato per site audit
**Screaming Frog**: usato in audit iniziale

## Webflow IDs
**Site ID**: `6880ea2eb3476597aea49e88`
**Collection Blog Posts ID**: `6881f26f814b583b23bf927b`
**Collection Recensioni ID**: `68dfe72c7d925fd6a8cd91be`
**Campo SEO Title (Blog Posts)**: `dee1fa1876fe528fd6402c0521f557e2`

**Pagine statiche:**
| Page ID | Slug |
|---|---|
| `6880ea2eb3476597aea49ec8` | Home (/) |
| `68a59b1d4c3e9132071c8f5f` | Contatti (/contatti) |
| `68ee62e93d514f93fa1b0e92` | Metodologia (/metodologia) |
| `68ac2cb9c5904990b5190d64` | Articoli (/articoli) |
| `69297655d0af8ac9228ebf49` | Privacy Policy (/privacy-policy) |
| `6881f26f814b583b23bf92a2` | Blog Posts Template (/post) |
| `68dfe72d7d925fd6a8cd91c5` | Recensioni Template (/recensione) |
| `6880ea2eb3476597aea49ecd` | 404 |

**Domini per pubblicazione:** `legalepompei.it`, `www.legalepompei.it`, `legalepompei.com`, `www.legalepompei.com`
**⚠️ Rate limit 429 su publish**: attendere 30s e riprovare, oppure chiedere all'utente di pubblicare manualmente dal Designer.

## Keyword e settore
**Settore**: Diritto di famiglia — separazione, divorzio, avvocato matrimonialista
**Keyword principali**:
- separazione consensuale/giudiziale Cassino/Formia
- divorzio consensuale/giudiziale Cassino/Formia
- avvocato matrimonialista Cassino/Formia (attuale pos. 86)
**Keyword escluse**: <!-- DA COMPLETARE -->
**Geolocalizzazione**: Cassino, Formia, Latina, Frosinone e province limitrofe

## Stato SEO attuale (dati al 2026-03-06)
**Traffico organico**: 0
**Keyword posizionate**: 1 (avvocato matrimonialista, pos. 86)
**Domain Rating**: 0 — 27 referring domains
**Posizione media GSC**: <!-- DA COMPLETARE -->
**NAP consistency**: 32% (16 piattaforme)
**Site Health Semrush**: 83%
**LCP mobile**: 6.0s — critico
**CLS desktop**: 0.29 — critico
**AI Citations**: 0
**Rank locale Google Maps**: #1 a Formia

## Problemi identificati
**Critici**: pagina 4XX, sitemap assente, LCP mobile 6.0s, NAP consistency 32%, assenza pagine servizio, pagina Chi Sono assente
**Alti**: 2 pagine senza H1, canonical mancanti, CLS desktop 0.29, GBP non ottimizzato, 22 recensioni (competitor: 108)

## Roadmap
**Fase 1** (sett. 1-3): fix tecnici urgenti
**Fase 2** (sett. 4-8): contenuti e Local SEO
**Fase 3** (sett. 9-16): SEO organica e autorità
**Fase 4** (mese 4+): GEO/AI visibility

## Decisioni strategiche
[BLOCCATO] 2026-03-03 — 6h/mese a €35/h per 12 mesi — accordo con Michele
[DEFAULT] Formato contenuti citation-ready: summary 80-100 parole, tabelle, FAQ, schema — copre SEO e GEO simultaneamente
[DEFAULT] SEO title blog post: formato `{{seo-title}} | Avv. Pompei` — titoli coinvolgenti, max 60 car.

## Prossimi passi
- [ ] Fix pagina 4XX — ID: POMPEI-26-001 — entro: 2026-03-31
- [ ] Creare e inviare sitemap.xml a GSC — ID: POMPEI-26-002 — entro: 2026-03-31
- [x] Correggere meta description duplicate — ID: POMPEI-26-003 — completato: 2026-03-23
- [ ] Aggiungere H1 mancanti (2 pagine) — ID: POMPEI-26-004 — entro: 2026-03-31
- [x] Correggere 5 title tag troppo lunghi — ID: POMPEI-26-005 — completato: 2026-03-23
- [ ] Aggiungere canonical tag — ID: POMPEI-26-006 — entro: 2026-03-31
- [ ] Ottimizzare immagini WebP + lazy loading — ID: POMPEI-26-007 — entro: 2026-03-31
- [ ] Fix LCP mobile — ID: POMPEI-26-008 — entro: 2026-03-31

## Problemi aperti
Webflow limita accesso diretto al codice — fix tecnici (lazy loading, render-blocking) potrebbero richiedere workaround o custom code embed.

## Note operative
Audit completo in: clients/studio-legale-pompei/projects/seo-legalepompei/audit-marzo-2026.pdf
Accessi GSC e Ahrefs → secrets.md
Webflow: modifiche solo tramite editor — nessun accesso FTP/server

## Storico
2026-02-25 — call conoscitiva — budget 6h/mese confermato, priorità Formia/Cassino, SEO prima di GEO
2026-02-25 — preventivo non necessario, accordo diretto — POMPEI-26-009 annullato
2026-02-25 — accessi ricevuti (host, sito, GTM, GSC) — POMPEI-26-010 completato
2026-03-06 — audit SEO+GEO iniziale completato — POMPEI-26-011 completato
2026-03-22 — onboarding portale report in corso — POMPEI-26-012 in corso
2026-03-23 — POMPEI-26-003 completato: corretta meta description duplicata su pagina Metodologia
2026-03-23 — POMPEI-26-005 completato: creato campo SEO Title CMS, aggiornati 5 post con titoli ottimizzati e coinvolgenti
