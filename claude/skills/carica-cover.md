---
name: carica-cover
description: Carica un'immagine cover su Google Drive e aggiorna il campo Cover del progetto su Airtable. Usa questa skill ogni volta che l'utente dice "carica cover", "aggiungi immagine progetto", "aggiorna cover", "imposta copertina progetto" o simili. Verifica se il file esiste già su Drive prima di caricare. Chiede sempre conferma prima di aggiornare.
---

# Carica Cover Progetto — Digital On Agency

Questa skill carica un'immagine cover su Google Drive e aggiorna il campo Cover del progetto su Airtable, rendendola visibile su Softr.

## Riferimenti Airtable

**Base:** appHtzPRdNURXVvgo
**Tabella Progetti/Servizi:** tblylhAgyc47wEal2
- Nome: fldhGdGhIRk8Op4uL
- Cover: fldzVrkVeBcepZ5dq (multipleAttachments — URL pubblico Drive)

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

## Naming convention

Il file su Drive deve seguire sempre questo formato:
```
Cover/[slug-cliente]/[nome-progetto]-cover.[ext]
```

Esempi:
- Cover/studio-legale-pompei/seo-legalepompei-cover.jpg
- Cover/trovapulizie/portale-transazionale-cover.png

Lo slug del nome progetto è: minuscolo, spazi → trattini, no caratteri speciali.

---

## Processo

### Step 1 — Ricevi l'immagine e il progetto

Chiedi se non è chiaro:
- Immagine allegata o URL
- Nome del progetto

---

### Step 2 — Verifica se il file esiste già su Drive

Prima di caricare, usa il connettore workspace-digitalon per cercare il file nella cartella `Cover/[slug-cliente]/` con il nome `[nome-progetto]-cover.[ext]`.

Se esiste già:
```
Il file [nome-progetto]-cover.[ext] esiste già su Drive.
Vuoi sovrascriverlo o mantenere quello esistente e usare il link già presente?
```

Se non esiste, procedi con l'upload.

---

### Step 3 — Carica su Google Drive (solo se non esiste o si vuole sovrascrivere)

Cartella: `Cover/[slug-cliente]/`
Nome file: `[nome-progetto]-cover.[ext]`

Ottieni il link pubblico dopo l'upload.
IMPORTANTE: il link deve essere in formato diretto per Airtable:
https://drive.google.com/uc?export=download&id=[FILE_ID]
NON usare il link di condivisione (https://drive.google.com/file/d/.../view) — Airtable scaricherebbe la pagina HTML invece del file.
Per ottenere il FILE_ID dal link di condivisione: estrai la stringa tra /d/ e /view.

---

### Step 4 — Trova il Record ID del progetto

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

### Step 5 — Mostra riepilogo e chiedi conferma

```
Sto per aggiornare la cover su Airtable:

📁 Progetto: [nome progetto]
🖼️ File: [nome-progetto]-cover.[ext]
🔗 Link Drive: [link]

Confermo?
```

Procedere SOLO dopo conferma esplicita.

---

### Step 6 — Aggiorna il record su Airtable via curl

```bash
curl -s -X PATCH "https://api.airtable.com/v0/appHtzPRdNURXVvgo/tblylhAgyc47wEal2/[RECORD_ID]" \
  -H "Authorization: Bearer $AIRTABLE_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "fields": {
      "fldzVrkVeBcepZ5dq": [{"url": "[LINK_DRIVE]", "filename": "[NOME_FILE]"}]
    }
  }'
```

---

### Step 7 — Conferma

1. Comunica: "Cover aggiornata su Airtable e visibile su Softr nella pagina Progetti"

---

## Regole

- MAI caricare senza prima verificare se il file esiste già su Drive
- MAI aggiornare senza conferma esplicita
- Usare SEMPRE il formato nome: [nome-progetto]-cover.[ext]
- Usare SEMPRE curl per Airtable — non il connettore MCP
- Formati accettati: JPG, PNG, WebP
- Se il progetto non viene trovato su Airtable, segnalarlo e non procedere
- Eliminare Cover URL da Airtable se ancora presente — il campo corretto è Cover (fldzVrkVeBcepZ5dq)
