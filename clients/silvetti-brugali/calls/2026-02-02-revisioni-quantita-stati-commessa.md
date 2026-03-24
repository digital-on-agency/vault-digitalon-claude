# Call 02/02/2026 — Revisioni, Quantità, Stati Commessa

**Data**: 2026-02-02
**Partecipanti**: Guido (Digital On), Francesco Leo
**Durata**: ~60 min

## Riepilogo
Molte migliorie UX e definizione regole fondamentali: anti-duplicati, revisioni interne/esterne, stati commessa, quantità per disegno, regola NDT su moltiplicazione pezzi.

## Punti chiave

### Anti-duplicati codici disegno
- Problema: impossibile bloccare inserimento codice già esistente
- Soluzione: notifica se codice già presente (workaround per blocco completo)

### Revisioni disegni
- Revisioni interne (es. "Revisione A"): modifiche per produzione fatte da Francesco
- Revisioni esterne (cliente): cambio da R0 a R1 quando cliente modifica disegno
- Entrambe le versioni mantenute per tracciabilità
- Bottone "Crea revisione": duplica il disegno, inserisci numero revisione (0,1,A,B...) e descrizione
- Problema risolto: descrizione revisione unificata nel campo descrizione principale (append con sezione "REVISIONE" in maiuscolo)

### Quantità
- Quantità riferita a ciascun disegno all'interno dell'ordine (non globale per commessa)
- Il sistema moltiplica automaticamente i pezzi della NDT per la quantità
- Quantità NON stampata nel documento NDT finale (per non confondere l'operatore — i pezzi risultano già moltiplicati)

### Stati commessa
- Definiti: "da cominciare" / "in produzione" / "evasa" / "annullata"

### Migliorie UX implementate o concordate
- Descrizione commessa copiata automaticamente dalla descrizione ordine cliente
- Popup creazione commessa più grande + apertura diretta pagina commessa dopo creazione
- Anno commessa rinominato "anno di consegna"
- Numero commessa visibile accanto all'ordine nella lista ordini
- Pagina ordine si apre in nuova scheda
- Data di consegna visibile nella schermata ordini
- Campo conto lavoro: posizione da definire in un secondo momento (NDT o disegno)

## Decisioni prese
[BLOCCATO] Quantità per riga ordine (per singolo disegno) — non globale
[BLOCCATO] NDT: pezzi × quantità — quantità NON stampata nel documento finale
[DEFAULT] Anti-duplicati: notifica se codice già presente
[DEFAULT] Revisioni: bottone "Crea revisione" duplica disegno — campo revisione + descrizione
[DEFAULT] Stati commessa: da cominciare / in produzione / evasa / annullata

## Prossimi passi
- Digital On implementa tutte le migliorie UX elencate
- Definire posizione campo conto lavoro sviluppando insieme una commessa reale
