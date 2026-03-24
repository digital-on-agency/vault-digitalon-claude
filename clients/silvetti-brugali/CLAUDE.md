# SILVETTI & BRUGALI S.R.L.

## Identità cliente
**Ragione sociale**: SILVETTI & BRUGALI S.R.L.
**C.F. / P.IVA**: 01703450161
**Sede**: Via Guzzanica, 50 - 24040 Stezzano (BG) - Italia
**Email**: carpenteria@silvettibrugali.com
**Tel**: +39 035 593555
**Sito**: https://carpenteriasilvettibrugali.it
**Settore**: Carpenteria / lavorazioni metalliche su commessa e disegno tecnico
**Dimensione**: PMI — processo storico dipendente dal know-how di Francesco Leo
**Da quando è cliente**: 2025-09
**Contratto**: Pacchetto ore — progetto gestionale custom, finanziato voucher Regione Lombardia
**Priorità account**: Alta

## Comunicazione
**Referente principale**: Francesco Leo — operatività, knowledge, processo, listini
**Altri contatti**: Luca — coinvolgibile su alcune parti del progetto
**Canale preferito**: WhatsApp / Meet
**Frequenza aggiornamenti**: Call settimanali/bisettimanali durante sviluppo
**Tono da usare**: Diretto, tecnico, operativo
**Note relazionali**: Francesco è il referente tecnico principale e il detentore del know-how. Luca viene coinvolto su parti specifiche. Il cliente si aspettava "gestionale completo entro le ore" — importante rendicontare l'evoluzione dei requisiti e le attività di standardizzazione. Francesco ha espresso delusione nella call 17/02 per il gap tra aspettative e realtà del budget.

## Vincoli e decisioni trasversali
[BLOCCATO] 2025-09 — Progetto finanziato voucher Regione Lombardia ~10k€, rimborso ~90%
[BLOCCATO] 2026-02-17 — Ore pacchetto ~70% consumate — perimetro da chiudere nel budget residuo
[BLOCCATO] 2026-02-17 — Perimetro voucher: chiudere ordini cliente + ordini fornitori + generazione NDT — consuntivo rimandato a nuovo voucher
[BLOCCATO] 2026-03-17 — Fornitore NON fisso sul disegno — solo "tipo lavorazione" — scelta fornitore dinamica in commessa (RDO multiple)
[DEFAULT] AutoCAD Web + export PDF — nessuna integrazione nativa replicabile in cloud
[DEFAULT] Quantità gestita per riga ordine (per disegno) — NDT mostra pezzi già moltiplicati, quantità NON stampata nel documento
[DEFAULT] DB Disegni Tecnici = listino prezzi + archivio codici (anche senza file associato)
[DEFAULT] Listino prezzi ricostruito da zero nel nuovo DB (non migrazione automatica)
[ATTENZIONE] Budget ore: ogni nuova funzionalità va valutata rispetto al perimetro chiudibile
[ATTENZIONE] Relazione delicata dopo call 17/02 — Francesco ha accettato il compromesso ma con riserva

## Ecosistema tecnico condiviso
**Domini**: carpenteriasilvettibrugali.it
**Frontend**: Softr
**Database**: Airtable
**Backend/API/Automazioni**: Make, Airtable Automations, Softr Automations
**Generazione PDF**: Server interno Digital On (chiamato via Softr)
**Auth/utenti**: Softr Users
**Hosting**: <!-- DA COMPLETARE -->
**CMS sito**: WordPress + Elementor
**Analytics/Tracking**: Google Tag Manager + Microsoft Clarity (da confermare)
**Storage disegni**: Google Drive (PDF esportati da AutoCAD Web)
**AutoCAD**: Francesco usa AutoCAD LT (~€460/anno) — AutoCAD Web incluso nella licenza
**Accessi sensibili**: → clients/silvetti-brugali/secrets.md

## Clienti principali di Silvetti & Brugali
- **TESMEC** — cliente principale, ordini con revisioni e listino prezzi/sconti
- **Fraste** — ordini complessi con struttura matrioska (codice padre → codici figli)
- **Picardi** — caso speciale per fornitore Milesi (impaginazione ordine dedicata)

## Fornitori principali
- **Milesi** — meccanica, doppia impaginazione (normale + Picardi)
- **Rondifer** — meccanica
- **Carlas** — verniciatura
- **Commi** — verniciatura (prezzo €/kg)
- **Laser Rap Metal** — taglio laser

## Progetti
| ID | Nome progetto | Tipo | Stato | Path |
|----|---------------|------|-------|------|
|    | Gestionale operativo custom | Sviluppo | Attivo | clients/silvetti-brugali/projects/gestionale/ |

## Storico attività
2025-09-25 — Prima call demo — presentazione dashboard fornitori, revisione processo Excel su NAS, condivisione file su Drive per studio sistema
2025-10-20 — Call costo commessa — definito: ore interne + costi fornitori + margine 10% su esterni; problema listini mancanti → template RFQ
2025-10-29 — Call note di taglio + AutoCAD + ore — struttura NDT definita, 3 tipologie disegni, collegamento AutoCAD chiarito, avviato tema consuntivo ore
2025-11-10 — Call disegni e codici complessi — sistema matrioska Fraste, DB disegni con quantità unitaria=1, nome file = codice disegno, verniciatura al chilo
2025-11-28 — Call decisione AutoCAD Web — confermato workflow: AutoCAD Web → export PDF → upload gestionale; Google Drive come storage
2026-01-09 — Call ordini fornitori + accesso gestionale — Francesco riceve accesso app, ordine unico per fornitore, bottone "Crea commessa" su ordine, conto lavoro
2026-01-14 — Call test ordine reale TESMEC — inserimento PO 2025937, problema caricamento multiplo disegni, DVG non visualizzabile, DB disegni come doppio listino
2026-02-02 — Call revisioni + quantità + stati commessa — anti-duplicati codici, bottone "Crea revisione", revisioni interne+esterne, stati commessa definiti, quantità per disegno
2026-02-17 — Call critica budget — ore ~70%, Francesco deluso, accordo: chiudere ordini cliente+fornitori+NDT, consuntivo rimandato
2026-02-20 — Call template ordini fornitori — descrizione revisione unificata, 3 categorie template (meccanica/laser/verniciatura), caso Milesi+Picardi
2026-03-12 — Call categorizzazione fornitori + listino — categorie fornitori definite, file disegno non obbligatorio, listino da zero, pagamento su fornitore, attivo/inattivo
2026-03-17 — Call cambio strutturale RDO — fornitore dinamico in commessa, riprogettazione prezzi/fornitori, quantità codici figli, approvato modulo Conto Ore
