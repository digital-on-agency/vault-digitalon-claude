---
name: airtable-task-manager
description: Gestisce le task sul portale Digital On tramite Airtable. Usa questa skill ogni volta che l'utente dice "cerca task", "aggiorna stato task", "crea task", "segna come completata", "che task ci sono" o simili. Supporta ricerca, aggiornamento stato e creazione di nuove task collegate al progetto corretto.
---

# Airtable Task Manager — Digital On Agency

Questa skill gestisce le task sulla base Airtable DigitalOn App: ricerca, aggiornamento stato e creazione.

## Riferimenti Airtable

**Base:** `appHtzPRdNURXVvgo` — DigitalOn App

**Tabella Task:** `tblhrxCxAzWKOaKCW`
- Titolo: `fldswLgF1Yohk2WOK`
- Descrizione: `fldOLPGIECXPdeiq4`
- Stato: `fldzSIQ7vjVsPfxrg` (singleSelect — **sempre typecast: true**)
- Deadline: `fld2Ze39cTWjkxjk5` (YYYY-MM-DD)
- Priorità: `fld7rTopKaduH38fb` (singleSelect — **sempre typecast: true**)
- Progetto: `fldbCZdpMKBDsrPcW` (link a Progetti/Servizi)
- Categoria: `fldLkHgbTurLRQXGn` (singleSelect — **sempre typecast: true**, es. "SEO", "Ads", "Web")

**Tabella Progetti/Servizi:** `tblylhAgyc47wEal2`
- Nome: `fldhGdGhIRk8Op4uL`

**Progetti noti (Record ID):**
- SEO legalepompei.it: `recR3UEgRAE8u2u16`

## Come leggere il token Airtable

```bash
AIRTABLE_TOKEN=$(cat /home/niccolo/vault-digitalon/.mcp.json | python3 -c "
import sys,json
config=json.load(sys.stdin)
token = config['mcpServers']['airtable'].get('headers',{}).get('Authorization','').replace('Bearer ','')
if not token:
    args = config['mcpServers']['airtable'].get('args',[])
    for i,a in enumerate(args):
        if '--header' in a and i+1 < len(args):
            token = args[i+1].replace('Authorization:Bearer ','')
print(token.strip())
" 2>/dev/null)
```

---

## Operazioni

### 1. Cercare una task per titolo

```bash
SEARCH_TERM="sitemap"

curl -s "https://api.airtable.com/v0/appHtzPRdNURXVvgo/tblhrxCxAzWKOaKCW" \
  -H "Authorization: Bearer $AIRTABLE_TOKEN" \
  --data-urlencode "filterByFormula=SEARCH(LOWER('$SEARCH_TERM'),LOWER({fldswLgF1Yohk2WOK}))" \
  | python3 -c "
import sys,json
data=json.load(sys.stdin)
for r in data.get('records',[]):
    f = r['fields']
    print(f'ID: {r[\"id\"]}')
    print(f'  Titolo: {f.get(\"fldswLgF1Yohk2WOK\",\"\")}')
    print(f'  Stato: {f.get(\"fldzSIQ7vjVsPfxrg\",\"\")}')
    print(f'  Priorità: {f.get(\"fld7rTopKaduH38fb\",\"\")}')
    print(f'  Deadline: {f.get(\"fld2Ze39cTWjkxjk5\",\"\")}')
    print(f'  Categoria: {f.get(\"fldLkHgbTurLRQXGn\",\"\")}')
    print()
"
```

---

### 2. Aggiornare lo stato di una task

```bash
RECORD_ID="recXXXXXXXXXXXXXX"
NUOVO_STATO="Completata"

curl -s -X PATCH "https://api.airtable.com/v0/appHtzPRdNURXVvgo/tblhrxCxAzWKOaKCW/$RECORD_ID" \
  -H "Authorization: Bearer $AIRTABLE_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"typecast\": true,
    \"fields\": {
      \"fldzSIQ7vjVsPfxrg\": \"$NUOVO_STATO\"
    }
  }"
```

**Valori Stato:** Da iniziare · In corso · Da Revisionare · Completata

---

### 3. Creare una nuova task

```bash
curl -s -X POST "https://api.airtable.com/v0/appHtzPRdNURXVvgo/tblhrxCxAzWKOaKCW" \
  -H "Authorization: Bearer $AIRTABLE_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "typecast": true,
    "records": [{
      "fields": {
        "fldswLgF1Yohk2WOK": "[TITOLO]",
        "fldOLPGIECXPdeiq4": "[DESCRIZIONE]",
        "fldzSIQ7vjVsPfxrg": "Da iniziare",
        "fld2Ze39cTWjkxjk5": "[YYYY-MM-DD]",
        "fld7rTopKaduH38fb": "Media",
        "fldbCZdpMKBDsrPcW": ["[REC_PROGETTO]"],
        "fldLkHgbTurLRQXGn": "[CATEGORIA]"
      }
    }]
  }'
```

**Valori Priorità:** Bassa · Media · Alta
**Valori Categoria:** SEO · Ads · Web · CRM · Chatbot · Analytics · Call · Strategia · Supporto

---

### 4. Elencare tutte le task di un progetto

```bash
PROGETTO_ID="recR3UEgRAE8u2u16"

curl -s "https://api.airtable.com/v0/appHtzPRdNURXVvgo/tblhrxCxAzWKOaKCW" \
  -H "Authorization: Bearer $AIRTABLE_TOKEN" \
  --data-urlencode "filterByFormula=FIND('$PROGETTO_ID',ARRAYJOIN({fldbCZdpMKBDsrPcW}))" \
  | python3 -c "
import sys,json
data=json.load(sys.stdin)
for r in data.get('records',[]):
    f = r['fields']
    stato = f.get('fldzSIQ7vjVsPfxrg','')
    titolo = f.get('fldswLgF1Yohk2WOK','')
    print(f'{stato:15} | {titolo}')
"
```

---

## Regole

- Usare **sempre `typecast: true`** per tutti i campi singleSelect (Stato, Priorità, Categoria) — senza questo Airtable rifiuta valori non esistenti
- Usare SEMPRE curl per Airtable — non il connettore MCP (problemi OAuth)
- MAI creare task senza conferma esplicita dell'utente
- Per aggiornare lo stato: mostrare sempre titolo e stato attuale prima di procedere
- Collegare sempre la task al progetto corretto tramite il campo Progetto (`fldbCZdpMKBDsrPcW`)
- Se il progetto non è nella lista "Progetti noti", cercarlo prima nella tabella Progetti/Servizi
