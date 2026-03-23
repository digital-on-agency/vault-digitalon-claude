---
name: carica-cover
description: Carica un'immagine cover su Google Drive e aggiorna il campo Cover del progetto su Airtable. Usa questa skill ogni volta che l'utente dice "carica cover", "aggiungi immagine progetto", "aggiorna cover", "imposta copertina progetto" o simili. Chiede sempre conferma prima di aggiornare.
---

# Carica Cover Progetto — Digital On Agency

Questa skill carica un'immagine su Google Drive e aggiorna il campo Cover del progetto su Airtable, rendendola visibile su Softr.

## Riferimenti Airtable

**Base:** appHtzPRdNURXVvgo
**Tabella Progetti/Servizi:** tblylhAgyc47wEal2
- Nome: fldhGdGhIRk8Op4uL
- Cover: fldH90Nx5evEFikFW (attachment — URL pubblico)
- Business: fld1WwX7YCdV6l9U0
**Tabella Clienti/Business:** tbldMv8I4Wlo9s9BM

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
print(token)
" 2>/dev/null)
```

## Processo

### Step 1 — Ricevi l'immagine

L'immagine può arrivare in due modi:
- **File allegato** — l'utente allega l'immagine
- **URL** — l'utente fornisce un URL pubblico dell'immagine

Chiedi anche il nome del progetto a cui associare la cover se non è chiaro.

---

### Step 2 — Carica su Google Drive

Usa il connettore workspace-digitalon per caricare in:
Cover/[slug-cliente]/[nome-progetto]-cover.[ext]

Ottieni il link pubblico del file dopo l'upload.

---

### Step 3 — Trova il Record ID del progetto

Usa curl per cercare il progetto in Progetti/Servizi per nome:

```bash
curl -s "https://api.airtable.com/v0/appHtzPRdNURXVvgo/tblylhAgyc47wEal2" \
  -H "Authorization: Bearer $AIRTABLE_TOKEN" | python3 -c "
import sys,json
data=json.load(sys.stdin)
for r in data.get('records',[]):
    print(r['id'], r['fields'].get('fldhGdGhIRk8Op4uL',''))
"
```

---

### Step 4 — Mostra riepilogo e chiedi conferma

```
Sto per aggiornare la cover su Airtable:

📁 Progetto: [nome progetto]
🖼️ Immagine: [nome file]
🔗 Link Drive: [link]

Confermo?
```

Procedere SOLO dopo conferma esplicita.

---

### Step 5 — Aggiorna il record su Airtable via curl

```bash
curl -s -X PATCH "https://api.airtable.com/v0/appHtzPRdNURXVvgo/tblylhAgyc47wEal2/[RECORD_ID]" \
  -H "Authorization: Bearer $AIRTABLE_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "fields": {
      "fldH90Nx5evEFikFW": [{"url": "[LINK_DRIVE]", "filename": "[NOME_FILE]"}]
    }
  }'
```

---

### Step 6 — Conferma

Dopo l'aggiornamento:
1. Comunica: "Cover aggiornata su Airtable ✓ — visibile su Softr nella pagina Progetti"

---

## Regole

- MAI aggiornare senza conferma esplicita
- Cartella Drive: Cover/[slug-cliente]/
- Usare SEMPRE curl per Airtable — non il connettore MCP
- Formati accettati: JPG, PNG, WebP
- Se il progetto non viene trovato su Airtable, segnalarlo e non procedere
