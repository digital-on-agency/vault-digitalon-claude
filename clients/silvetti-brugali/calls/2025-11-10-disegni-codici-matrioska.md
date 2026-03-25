# Call 10/11/2025 — Disegni, Codici Complessi, Matrioska

**Data**: 2025-11-10
**Partecipanti**: Guido (Digital On), Francesco Leo
**Durata**: ~60 min

## Riepilogo
Analisi approfondita del sistema disegni e codici. Emersa struttura matrioska (codice padre → codici figli) per cliente Fraste. Chiarite regole listino e revisioni.

## Punti chiave

### Gestione ordini e disegni (cliente TESMEC)
- File TESM: archivio con "Liste vendite TESMEC" e "prezzi tesatura TESMEC" — codici, prezzi di vendita/sconti, costi verniciatura
- Sconto 6% sulla quantità (richiesto da TESMEC in base al volume ordine)
- Inserendo un codice il sistema traccia l'ultima commessa in cui è stato usato → storico revisioni
- I disegni del cliente diventano il listino e lo storico, suddiviso per cliente

### DB disegni tecnici
- Campi da aggiungere: prezzi, numero esecuzioni, commesse collegate, cliente associato
- Codici già usati → si riutilizzano i disegni AutoCAD cambiando solo la quantità
- Quantità unitaria = 1 nel DB — moltiplicazioni gestite in commessa
- Nome file = codice disegno (confermato)

### Verniciatura
- Fornitori: Carlas, Commi
- Commi: inserimento codici calcola automaticamente peso e prezzo totale (costo variabile al chilo)
- Documento ordine verniciatura include: riferimento ordine cliente + ciclo verniciatura
- Verniciatura = tipo di ordine distinto, pagato al chilo

### Struttura matrioska (Fraste)
- Ordini Fraste: elenco di codici con revisioni, ogni codice può contenere altri codici
- Codice madre ha tabella con tutti i sottocodici componenti
- Sottocodici di categorie diverse (es. laser tubo, meccanica)
- Obiettivo: archivio interno per associare codice principale ai sottocodici
- Una volta creato l'archivio: sistema automatico identifica fornitore appropriato per ogni sottodisegno

### AutoCAD
- Francesco usa Excel in locale con collegamento nativo ad AutoCAD
- Digital On lavora in cloud → connessione diretta non possibile
- Soluzione esplorata: screenshot come ultima risorsa, ma obiettivo è DB che riduca lavoro manuale nel tempo

## Decisioni prese
- DB disegni = listino + storico + archivio codici
- Quantità unitaria nel DB, moltiplicazioni in commessa
- Verniciatura = categoria separata con pricing al chilo

## Prossimi passi
- Aggiungere campi prezzi, esecuzioni, commesse, cliente al DB disegni
- Creare bottone genera NDT unico (aggrega tutte le NDT dei disegni)
- Studiare collegamento AutoCAD o soluzioni alternative
