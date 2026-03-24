# Call — Strategia Lancio Trovapulizie

**Data**: 2026-03-23, ore 15:49 CET
**Partecipanti**: Guido (Digital On), Niccolò Fulgaro, Matti Sonetti, Christian Pascolini
**Durata**: ~1h 35min
**Progetti coinvolti**: Portale Transazionale, SEO, CRM & Tracking, Partnership PM

## Contesto
Brainstorming operativo e strategico per definire metodo di lavoro, strategia di lancio Instant Booking e acquisizione offerta (cleaner).

## Decisioni prese

### Metodo di lavoro
- [GENERICO] [DEFAULT] Brain dump settimanale: idee raccolte durante la settimana su Discord/Cloud, discusse nella call settimanale. Se approvate → task in roadmap
- [GENERICO] [DEFAULT] Nuovi stati task: aggiunti "Bloccato" e "Collo di bottiglia" per tracciare dipendenze e problemi di risorse
- [GENERICO] [DEFAULT] Commenti interni separati dalle task, con riferimento tramite ID — tabella separata su Airtable
- [GENERICO] [DEFAULT] Cron job lunedì mattina pre-call: elabora brainstorming + commenti e produce riassunto sintetico (~10 min di lettura)

### Brainstorming su Cloud
- [PORTALE TRANSAZIONALE] [DEFAULT] Cartella brainstorming centralizzata su Cloud, separata dai progetti ma filtrabile per progetto/cliente
- [PORTALE TRANSAZIONALE] [DEFAULT] Idee generali (non legate a un cliente) accolte nella stessa cartella

### Strategia Trova Pulizie — Lancio
- [PORTALE TRANSAZIONALE] [DEFAULT] Focus su Instant Booking come funzionalità core del lancio
- [PORTALE TRANSAZIONALE] [DEFAULT] Espansione per microaree (non lancio aggressivo su tutta Roma) — qualità > copertura
- [PORTALE TRANSAZIONALE] [DEFAULT] Recuperare i 120 vecchi cleaner iscritti, intervistarli telefonicamente per attivarli come primi utenti Instant Booking
- [PORTALE TRANSAZIONALE] [DEFAULT] Partenza con cleaner/ditte che collegano il calendario in una microarea, a prezzo fisso
- [PORTALE TRANSAZIONALE] [DEFAULT] Priorità assoluta sull'assorbimento dell'offerta prima di generare domanda

### Marketing e acquisizione
- [SEO] [DEFAULT] Posizionamento SEO per pagine targettizzate per quartiere ("keyword + quartiere")
- [PORTALE TRANSAZIONALE] [DEFAULT] Passaparola, volantinaggio geolocalizzato e traffico organico come strategie primarie (margini non permettono advertising aggressivo)
- [PORTALE TRANSAZIONALE] [DEFAULT] Attivazione pagina Facebook/Instagram per interazione nei gruppi locali + retargeting Meta
- [PORTALE TRANSAZIONALE] [DEFAULT] Annunci lavoro su gruppi Facebook locali in roadmap

### Prodotto e differenziazione
- [PORTALE TRANSAZIONALE] [DEFAULT] IA per matchmaking predittivo domanda/offerta, rerouting e gestione rimborsi
- [PORTALE TRANSAZIONALE] [DEFAULT] Sistema di ricompensa a doppia logica (crediti/sconti) per fidelizzazione utenti sulla piattaforma
- [PORTALE TRANSAZIONALE] [DEFAULT] Prova completamento servizio tramite foto/video per controllo qualità
- [PORTALE TRANSAZIONALE] [DEFAULT] Assistente AI in-app per cleaner (organizzazione lavoro, risposte recensioni, aggiornamento descrizioni) — effetto "wow" futuro

### Brand
- [PORTALE TRANSAZIONALE] [DEFAULT] Necessità di rifare il logo pensando già alla futura app mobile

### Organizzazione
- [GENERICO] [DEFAULT] Tutte le task su unico tenant, tracciamento KPI cleaner su tenant dedicato Trovapulizie
- [GENERICO] [DEFAULT] Prossima call preferibilmente venerdì mattina (non giovedì sera)
- [GENERICO] [DEFAULT] Canale Discord creato per Christian Pascolini

## Action item

- [ ] Implementare sezione brainstorming su Cloud (cartella centralizzata filtrabile) — **Niccolò Fulgaro** — entro: 2026-03-28
- [ ] Creare script intervista telefonica per cleaner (zone coperte, disponibilità instant booking, uso calendario) — **Digital On (Guido)** — entro: 2026-04-05 <!-- al ritorno di Guido il 5 aprile -->
- [ ] Contattare telefonicamente i 120 vecchi cleaner con lo script — **Digital On (Guido)** — entro: 2026-04-12
- [ ] Configurare visualizzazione dati/KPI piattaforma su software — **Matti Sonetti** — entro: 2026-04-04
- [ ] Completare onboarding cleaner per abilitare Instant Booking — **Niccolò Fulgaro** — entro: 2026-04-01
- [ ] Proporre idee per il nuovo logo (pensato per app mobile) — **Matti Sonetti** — entro: 2026-04-04
- [ ] Lavorare su posizionamento SEO pagine per quartiere — **Niccolò Fulgaro** — ongoing
- [ ] Preparare materiale volantinaggio per microarea di lancio — **Digital On** — entro: da definire dopo identificazione microarea
- [ ] Identificare microarea di partenza in base a copertura geografica cleaner — **Team** — entro: 2026-04-12
- [ ] Implementare cron job lunedì mattina per riassunto brainstorming/commenti — **Niccolò Fulgaro** — entro: 2026-03-28
- [ ] Creare canale Discord per Christian Pascolini — **Niccolò Fulgaro** — fatto/in corso

## Problemi emersi

- **Bilanciamento domanda/offerta**: squilibrio è il principale rischio (motivo uscita Helpling dall'Italia). Priorità all'offerta.
- **Cleaner poco digitalizzati**: molti non usano calendari digitali → conflitto con instant booking. Soluzioni: onboarding assistito (umano poi chatbot), notifiche multicanale (push, email, WhatsApp), calendario in-app.
- **Economia sommersa**: cleaner che lavorano in nero affrontano costi aggiuntivi sulla piattaforma → prezzo finale più alto. Mitigazione: valore aggiunto (assicurazione, reperibilità, garanzie).
- **Fidelizzazione**: rischio transazioni fuori piattaforma. Contromisure: garanzie, assicurazione, sistema crediti, servizi digitali gratuiti per cleaner.

## Note interne

- Christian Pascolini sta preparando una presentazione per investitori — leve: innovazione in settore tradizionale, team, IA per matchmaking predittivo
- Gli investitori in questo tipo di business "investono nelle persone" — la narrativa deve puntare sull'innovazione portata dal team, non solo sul marketplace
- Il B2B (ditte + appalti) potrebbe essere più semplice del B2C, ma va strutturato prima il B2C come modello replicabile
- L'agente AI Silver Bullet è stato mostrato a Christian — opera 24/7, raccoglie contesto, può integrarsi con Google Ads e Meta
- Idea tracciamento GPS tipo Uber per cleaner scartata per ora (privacy + utilità dubbia)
- Assicurazione e copertura danni da valutare attentamente in base a margini e volumi attuali
