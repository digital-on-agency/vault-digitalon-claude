# Call 12/03/2026 — Categorizzazione Fornitori + Listino

**Data**: 2026-03-12
**Partecipanti**: Guido (Digital On), Niccolò (Digital On — backend), Francesco Leo
**Durata**: ~50 min

## Riepilogo
Definita categorizzazione fornitori. Aggiornato DB disegni tecnici (file non obbligatorio). Listino da ricostruire da zero. Pagamento predefinito su fornitore. Attivo/inattivo fornitori. Avviato tema scheda operatore per tracciamento ore.

## Punti chiave

### Categorizzazione fornitori
- Categorie definite: Meccanica / Verniciatura / Laser / Altre lavorazioni
- Francesco deve aggiornare i fornitori esistenti con la categoria e catalogare i nuovi
- Possibilità di aggiungere nuovi fornitori con categoria direttamente al momento dell'inserimento
- Visualizzazione: limite 100 record + filtro per tipologia

### DB Disegni Tecnici
- Mantenuto il nome "Disegni Tecnici"
- Rimossa obbligatorietà del file di disegno → si possono inserire codici anche senza file
- Il DB contiene tutti i codici: disegni con file, codici figli senza disegno interno, codici fornitori
- DB usato anche per salvare i costi delle lavorazioni dei fornitori

### Sistema prezzi/fornitori sul disegno
- Ogni disegno tecnico può avere associati i "lavori fornitori" tramite bottone dedicato
- Tipologia lavoro auto-selezionata in base al fornitore (ogni fornitore svolge un solo tipo)
- Campo "Descrizione" nei lavori fornitori: per codici interni usati per comunicare con il fornitore (es. codici Milesi)
- Macro-disegno cliente (es. 1452P rev.3) → sottodisegni corrispondenti ai codici interni fornitore (es. SP60*195*96) → prezzi sui sottodisegni

### Listino prezzi
- Decisione: ricostruire listino da zero nel nuovo DB (non migrazione automatica vecchi Excel)
- Motivo: uniformare i dati e semplificare il processo
- Una volta completato: lavoro principale su scheda commessa, aggiornamento prezzi solo quando fornitori li modificano

### Gestione fornitori
- Pagamento predefinito associato direttamente alla scheda fornitore (non nel modulo ordine)
- Gestione attivo/inattivo come alternativa alla cancellazione

### Verniciatura
- Prezzo: peso al chilo (€/kg)
- Allegato "ciclo verniciatura" PDF incluso nell'ordine

### Sviluppo futuro
- Prossima fase: scheda operatore per tracciamento ore di lavoro interno

## Decisioni prese
[DEFAULT] File disegno non obbligatorio nel DB Disegni Tecnici
[DEFAULT] Listino prezzi ricostruito da zero nel nuovo DB
[DEFAULT] Pagamento predefinito sulla scheda fornitore
[DEFAULT] Attivo/inattivo fornitori (no cancellazione)
[DEFAULT] Verniciatura: prezzo €/kg + allegato ciclo verniciatura

## Prossimi passi
- Francesco aggiorna categorie fornitori esistenti
- Digital On sviluppa scheda operatore per tracciamento ore
- Allineamento su sistema prezzi/fornitori per RDO (anticipato problemi che emergeranno in call 17/03)
