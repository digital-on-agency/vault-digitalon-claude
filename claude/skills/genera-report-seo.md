---
name: genera-report-seo
description: Genera il report mensile SEO per un cliente a partire dai dati di Google Search Console. Usa questa skill ogni volta che l'utente dice "genera report", "fai il report SEO", "report mensile", "report di marzo" o simili. Produce un PDF professionale da allegare su Airtable nella tabella Report e da condividere con il cliente sul portale.
---

# Genera Report SEO Mensile — Digital On Agency

Questa skill prende i dati GSC incollati dall'utente, genera un PDF professionale e crea il record su Airtable nella tabella Report.

## Riferimenti Airtable
**Base:** appHtzPRdNURXVvgo
**Tabella Report:** tbl0DRee2zPm8R1uT
- Titolo: fldPnUMnEcT8Qyt8D
- Cliente: fldN5jvkouosBqYiG
- Progetto: fldKwd0UKF43Q0Ehj
- Mese: fldFBfSKwbMiaXHnw (YYYY-MM-DD primo giorno del mese)
- Tipo: fldrNt3YThDVBQVe5
- Report PDF: fld2o6Ib9j1FXXXBM (allegato manuale)
- Note: fldLhSuKvaVvlZO7w

## Step 1 — Raccogli i dati GSC
Chiedi all'utente di incollare per il mese di riferimento:
- Click organici totali
- Impressioni totali
- Posizione media
- Top 5 keyword per click (keyword + click + impressioni + posizione)
- Top 5 pagine per traffico (URL + click)
- Dati mese precedente per confronto (click e impressioni)

## Step 2 — Calcola variazioni mese su mese
- Variazione click: ((click_attuale - click_precedente) / click_precedente) * 100
- Variazione impressioni: stessa formula
- Freccia trend: ↑ positivo · ↓ negativo · → invariato (±5%)

## Step 3 — Genera il PDF
Usa il skill PDF per generare report con questa struttura:
- Intestazione: Digital On — Report SEO [Mese] [Anno] — Cliente — Dominio
- Sommario esecutivo: paragrafo narrativo 3-4 righe, tono chiaro e orientato al dato
- Numeri chiave: Click organici / Impressioni / Posizione media con variazione %
- Top 5 keyword: tabella Keyword | Click | Impressioni | Posizione
- Top 5 pagine: tabella URL | Click
- Attività del mese: dal log.md del cliente
- Prossimi passi: interventi pianificati
- Footer: Digital On Agency — digital-on.com — info@digital-on.com

Salva PDF in clients/[slug]/reports/YYYY-MM-[cliente]-seo.pdf

## Step 4 — Crea record su Airtable
Mostrare riepilogo e attendere conferma esplicita prima di creare.
Il campo Report PDF va lasciato vuoto — allegato manualmente dopo.
MAI creare senza conferma.

## Step 5 — Comunica il risultato
1. Invia notifica su Discord: `bash /opt/vault-digitalon/claude/scripts/notify-discord.sh "Report SEO creato per [cliente]"`
2. Comunica: "Report creato su Airtable ✓ — allega il PDF al record per renderlo visibile sul portale"
3. Aggiorna Storico attività nel CLAUDE.md cliente

## Tono del sommario
✅ Chiaro, positivo ma onesto, orientato al dato. Esempio: "A marzo il sito ha registrato X click organici, con una crescita del Y% rispetto a febbraio."
❌ Evitare tecnicismi, gergo SEO non spiegato, tono freddo.

## Regole
- Non generare senza almeno click, impressioni e posizione media
- Se mancano dati mese precedente: omettere confronto e segnalarlo
- MAI creare record Airtable senza conferma esplicita
- Il report è per il cliente — no note interne o dati riservati
