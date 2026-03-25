# Call 17/03/2026 — RDO Multiple + Conto Ore (Cambio Strutturale)

**Data**: 2026-03-17
**Partecipanti**: Guido (Digital On), Francesco Leo
**Durata**: ~25 min

## Riepilogo
Call con cambio strutturale importante. Identificata necessità critica di quantità per codici figli e riprogettazione completa del sistema prezzi/fornitori per supportare RDO multiple. Approvato modulo Conto Ore.

## Punti chiave

### Quantità codici figli (problema critico)
- Problema: l'attuale sistema non permette di specificare quantità diverse per i codici figli all'interno di un codice padre
- La quantità non può stare sul figlio "globalmente" — deve stare sulla relazione padre→figlio o nel contesto dell'ordine/commessa
- Si applica sia agli ordini cliente che agli ordini fornitori
- Digital On accetta di implementare questa funzionalità

### Riprogettazione sistema prezzi/fornitori (cambio strutturale)
- Problema: codice disegno attualmente associato a fornitore specifico (es. Laser Rap Metal) → impedisce RFQ a più fornitori e split pezzi
- Francesco ha bisogno di: richiedere preventivi a più fornitori, confrontare prezzi, scegliere fornitore per singolo pezzo, eventualmente dividere pezzi tra fornitori diversi
- **Soluzione concordata**:
  - Sul disegno: solo "tipo lavorazione" (es. laser, meccanica) — NON fornitore fisso
  - Scelta fornitore + prezzo: in fase di creazione commessa/ordine
  - Supporto prezzi multipli per fornitore e per commessa
  - Digital On dovrà riprogettare modello dati e UI

### Aggiornamenti fornitori approvati
- Tipologia di pagamento associata direttamente al fornitore ✅
- Stato Attivo/Inattivo fornitori implementato ✅ (Francesco ha approvato)

### Conto Ore (approvato)
- Nuova sezione "Lavoro Interno" con gestione operatori e Conto Ore
- Funzionalità: registra data, operatore, commessa, tipo attività, ore lavorate
- Somma automatica monte ore di manodopera per commessa
- Francesco ha approvato la funzionalità ✅

## Decisioni prese
[BLOCCATO] Fornitore NON fisso sul disegno — solo "tipo lavorazione"
[BLOCCATO] Scelta fornitore dinamica in fase commessa/ordine
[BLOCCATO] Supporto prezzi multipli per fornitore/commessa
[DEFAULT] Quantità per codici figli: sulla relazione padre→figlio (non sul figlio globale)

## Prossimi passi
- [ ] SB-2026-001 — Implementare quantità per codici figli (più semplice, priorità alta)
- [ ] SB-2026-004 — Riprogettare sistema RDO multiple (più complesso — nuovo modello dati + UI)
- Digital On contatta Francesco nei prossimi giorni per definire la soluzione sul sistema prezzi/ordini
