# Gestionale Operativo Custom — Silvetti & Brugali

## Stato progetto
**Stato**: Attivo — fase finale
**Obiettivo**: Sostituire ecosistema Excel/NAS con gestionale cloud tracciabile, replicabile e utilizzabile da più operatori
**Perimetro attuale (voucher)**: Chiudere ordini cliente + generatore NDT + ordini fornitori. Consuntivo ore rimandato.

## Stack tecnico
- **Frontend**: Softr
- **Database**: Airtable
- **Automazioni**: Make + Airtable Automations + Softr Automations
- **Generazione PDF**: Server interno Digital On (chiamato via Softr)
- **Storage disegni**: Google Drive (PDF esportati da AutoCAD Web)

## Funzionalità completate ✅
- Clienti, ordini cliente, righe ordine con quantità per disegno
- Archivio disegni tecnici (DB) — codici anche senza file associato
- Revisioni disegni — bottone "Crea revisione" duplica disegno, opzione duplica NDT+ordini
- Descrizione revisione unificata nel campo descrizione (append con sezione "REVISIONE")
- Creazione commessa da ordine (bottone "Crea commessa")
- Stati commessa: da cominciare / in produzione / evasa / annullata
- Fornitori: categoria (Meccanica/Laser/Verniciatura/Altre), pagamento predefinito, attivo/inattivo
- Modulo operatori + Conto Ore per commessa (data, operatore, commessa, tipo attività, ore)

## In corso / da chiudere 🔄
- **Quantità codici figli** — quantità sulla relazione padre→figlio, non sul figlio globale (priorità alta, più semplice)
- **Generatore NDT** — logica moltiplicazione pezzi operativa, documento da finalizzare e testare
- **Generatore Ordini Fornitori** — template per categoria (meccanica / laser+lavorazioni speciali / verniciatura)
- **Sistema RDO multiple** — riprogettazione: fornitore dinamico in commessa, prezzi multipli per fornitore/commessa, confronto offerte

## Decisioni tecniche
[BLOCCATO] Fornitore NON fisso sul disegno — solo "tipo lavorazione" — scelta dinamica in commessa
[BLOCCATO] NDT: pezzi = pezzi_unitari × quantità — quantità NON stampata nel documento finale
[BLOCCATO] AutoCAD Web + PDF — nessuna integrazione nativa. Workflow: AutoCAD Web → export PDF → upload gestionale
[BLOCCATO] DB Disegni Tecnici funziona anche da listino prezzi — codici anche senza file
[BLOCCATO] Listino prezzi ricostruito da zero nel nuovo DB (non migrazione automatica vecchi Excel)
[DEFAULT] API generazione documenti: parametro codice commessa, recupero righe da tabella ordine cliente
[DEFAULT] Due pulsanti separati: "Genera NDT" / "Genera Ordini Fornitori"
[DEFAULT] Quantità gestita per riga ordine (per singolo disegno nell'ordine)
[DEFAULT] Anti-duplicati codici disegno: notifica se codice già presente
[DEFAULT] Template ordini fornitori: 3 categorie — Meccanica / Laser+lavorazioni speciali / Verniciatura
[DEFAULT] Caso speciale Milesi: doppia impaginazione (normale + Picardi)
[DEFAULT] Verniciatura: prezzo €/kg — allegato "ciclo verniciatura" PDF

## Flusso operativo implementato
```
Ordine cliente ricevuto
  → Inserimento ordine + righe (codice disegno + quantità)
  → Caricamento disegni (PDF da AutoCAD Web) sul DB disegni tecnici
  → Bottone "Crea commessa" → commessa collegata all'ordine
  → Genera NDT → documento unico per commessa (pezzi × quantità)
  → Genera Ordini Fornitori → documento per fornitore (per categoria)
  → [futuro] Conto ore operatori → consuntivo commessa
```

## Regole operative chiave
- **Quantità**: per riga ordine (per disegno) — non globale per commessa
- **NDT**: un documento unico per commessa, aggrega tutti i disegni, pezzi già moltiplicati
- **Posizione NDT**: campo testo libero (es. "24a") — non numero sequenziale
- **Operazioni interne**: taglio / assemblaggio / saldatura
- **Revisioni**: bottone duplica disegno — revisione cliente o interna — storico in descrizione
- **Codici figli**: struttura matrioska (codice padre → sottocodici) — quantità su relazione, non sul figlio globale
- **File disegno**: non obbligatorio nel DB — si possono inserire codici senza file

## Prossimi passi
- [ ] SB-2026-001 — Implementare quantità per codici figli (relazione padre→figlio)
- [ ] SB-2026-002 — Finalizzare e testare generatore NDT su caso reale con Francesco
- [ ] SB-2026-003 — Chiudere generatore Ordini Fornitori + 3 template categorie
- [ ] SB-2026-004 — Riprogettare sistema RDO multiple (nuovo modello dati + UI scelta fornitore dinamica)
- [ ] SB-2026-005 — Allineamento con Francesco su 2-3 casi reali (laser + meccanica) per UX minimale
- [ ] SB-2026-006 — Test finale su casi reali e rilascio versione stabile
- [ ] SB-2026-007 — Aggiornare rendiconto ore per pratica voucher Regione Lombardia

## Materiali da ricevere dal cliente
- [ ] Esempi PDF ordini fornitori per categoria (meccanica / laser / verniciatura)
- [ ] File ordine Milesi normale + Milesi Picardi
- [ ] 2-3 commesse reali con codici padre+figli e lavorazioni multi-fornitore

## Storico decisioni superate
- ~~DB disegni come "doppio listino" cliente+fornitore con fornitore fisso~~ → superato 17/03/2026 con riprogettazione RDO
- ~~File disegno obbligatorio nel DB~~ → rimosso 12/03/2026
