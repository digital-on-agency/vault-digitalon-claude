# Call 14/01/2026 — Test Ordine Reale TESMEC + Migrazione

**Data**: 2026-01-14
**Partecipanti**: Guido (Digital On), Francesco Leo
**Durata**: ~60 min

## Riepilogo
Test su ordine reale TESMEC (PO 2025937). Emerse richieste UX, problemi caricamento multiplo disegni, discussione migrazione storico e struttura DB disegni come doppio listino.

## Punti chiave

### Test ordine TESMEC
- Ordine: PO 2025937 per cliente TESMEC
- Problema: caricamento disegni uno alla volta — caricamento multiplo richiede implementazione futura via automazione
- Sistema genera numero progressivo commessa automaticamente (es. 032 per 2026)
- Flusso ideale: caricare disegni + NDT nell'ordine → poi creare commessa che aggrega tutto

### Disegni tecnici
- File DVG non visualizzabili in anteprima nel gestionale e non letti automaticamente → solo PDF/immagini
- Francesco dovrà mantenere cartella di lavoro separata per sviluppo in AutoCAD
- Disegni esistenti con NDT preesistenti possono essere collegati; altrimenti inserimento come nuovi

### Migrazione storico
- Vecchie NDT in Excel: possono essere esportate come PDF e salvate, ma non registrate come NDT "millimetriche" nel nuovo sistema
- Migrazione complessa per mancanza di schema preciso e variabilità tra file
- Proposta: raggruppare file per tipologia per tentare migrazione assistita
- Per nuovi ordini: inserimento da zero nel nuovo gestionale

### Macro-disegni (TRS 1150)
- Macro-disegno composto da diversi sottodisegni con NDT specifiche
- Una volta ricreato e inserito nel gestionale, il sistema moltiplica automaticamente le quantità per ordini futuri

### Richieste UX
- Scroll infinito per lista commesse (non paginazione)
- Popup creazione commessa più grande
- Dopo creazione commessa: aprire direttamente la sua pagina
- Aprire pagina ordine in nuova scheda (per non perdere la lista)
- Visualizzare data di consegna nella schermata ordini
- Tab separata per referenti cliente (contatti, note, settore)
- Visualizzare numero commessa accanto all'ordine
- Campo "lunghezza" nelle NDT (era stato erroneamente rimosso)
- Campo "materiale" nelle NDT: facoltativo
- "Anno commessa" rinominato in "anno di consegna"

### DB disegni come doppio listino
- Discusso utilizzo DB disegni tecnici come listino cliente + listino fornitore
- Codici interni fornitori trattati come "codici figli"
- Nota: questa impostazione sarà poi ripensata nella call del 17/03/2026

## Decisioni prese
- Campi NDT: lunghezza (obbligatorio), materiale (facoltativo), disegno operatore (facoltativo)
- Quantità totale NDT = lunghezza × numero pezzi
- Per storico: export PDF degli Excel come soluzione pratica

## Prossimi passi
- Digital On implementa tutte le richieste UX emerse
- Digital On aggiunge funzionalità storico commesse per codice disegno
- Valutare migrazione dati storici per tipologia
