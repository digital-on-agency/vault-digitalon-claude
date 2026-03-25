# Call 09/01/2026 — Ordini Fornitori + Accesso Gestionale

**Data**: 2026-01-09
**Partecipanti**: Guido (Digital On), Francesco Leo
**Durata**: ~50 min

## Riepilogo
Francesco riceve accesso al gestionale. Definito flusso ordine→commessa con bottone "Crea commessa". Chiarito conto lavoro. Discusso workflow AutoCAD Web in pratica.

## Punti chiave

### Accesso gestionale
- Francesco riceve invito via email → configura password (scelta da lui, minimo 8 caratteri)
- Presentata homepage e menu: sezione principale "clienti" (elenco clienti, ordini, DB disegni tecnici)
- Nuovo ordine: bottone "nuovo ordine" → inserimento dettagli + data ricezione

### Flusso ordine → commessa
- Francesco assegna commessa interna dopo aver ricevuto l'ordine
- Implementato bottone "Crea commessa" sulla scheda ordine (appare solo se commessa non ancora creata, scompare dopo)
- Collegamento automatico disegni esistenti nel DB all'ordine

### Ordini fornitori
- Ordine unico per fornitore anche se coinvolge più codici/disegni diversi
- Codice fornito al fornitore include quantità di pezzi per tutti i codici figli (X1, X2, ecc.)

### Conto lavoro
- Definito come: materiale che Silvetti & Brugali fornisce al fornitore per essere lavorato
- Rilevante sia per i fornitori che per i clienti di Francesco

### AutoCAD Web in pratica
- Accesso via web.autocad.com/acad/
- Disegni salvati in locale, connettibili tramite terza opzione nel menu
- Francesco preferisce mantenere template DVG → esportare in PDF
- Possibile usare sia AutoCAD locale che Web, il gestionale fornirà bottone accesso diretto ad AutoCAD Web

## Decisioni prese
- Bottone "Crea commessa" su scheda ordine (visibile solo se commessa non esiste)
- Flusso consigliato: caricare disegni e NDT nell'ordine → poi creare commessa
- Per ora Francesco può continuare a creare PDF NDT in Excel e caricarli nel gestionale

## Prossimi passi
- Digital On implementa bottone "Crea commessa" e collegamento AutoCAD Web
- Francesco inizia a usare il gestionale e pone domande
