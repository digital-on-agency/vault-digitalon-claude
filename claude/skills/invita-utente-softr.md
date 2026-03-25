---
name: invita-utente-softr
description: Invita un nuovo utente cliente sul portale Softr (digital-on.agency) e lo collega al cliente su Airtable. Usa questa skill ogni volta che l'utente dice "invita cliente su Softr", "crea accesso portale", "dai accesso al cliente" o simili. Chiede sempre conferma prima di procedere.
---

# Invita Utente Softr — Digital On Agency

Questa skill crea il profilo utente su Airtable, lo collega al cliente e al progetto, poi invia l'invito via API Softr.

## Riferimenti

**Portale Softr:** `https://digital-on.agency`
**API Softr base URL:** `https://studio-api.softr.io/v1/api`
**Softr-Domain header:** `digitalon.softr.app`
**API Key:** leggere da `agency/secrets.md` → sezione Softr

**Airtable:**
- Tabella Users: `tblUZSu2Goo77rTf5`
  - Nome: `fldgSde4cXK4QEzAh`
  - Email: `fldbBaFVRaRtb4ivM`
  - User Type: `fldveDXZqw548IAAo` → valore: `Client` (solo informativo, non usato da Softr per i gruppi)
  - User Group: `fldfrfb3UKRAovtxK` (link a tabella User Group)
- Tabella User Group: `tblyNGER0nZVFezfE` ← QUI Softr assegna i gruppi
  - Group: `fldFGnXiv12WqPVM7`
  - Users: `fldvd2Ln22rrHRhnQ`
  - Record ID gruppo Client: `recDvbTRzYAiSRCL5`
  - Record ID gruppo Agency: `recftK9cHonWFa98O`
  - Record ID gruppo Collaborator: `rec1Pb3NExJRhMHyR`
- Tabella Clienti/Business: `tbldMv8I4Wlo9s9BM`
  - Users: `fld4t8fcrVJV8S0DZ`
- Tabella Progetti/Servizi: `tblylhAgyc47wEal2`
  - Users: `fldFRHwtKtTdVnQa0`

**IMPORTANTE:** Softr assegna i gruppi tramite la tabella `User Group`, non tramite il campo `User Type`. Per assegnare il gruppo Client a un utente, aggiungere il suo record ID al campo Users (`fldvd2Ln22rrHRhnQ`) del record Client in User Group (`recDvbTRzYAiSRCL5`).

---

## Processo

### Step 1 — Raccogli le informazioni

**Obbligatori:**
- Nome completo utente
- Email
- Cliente di riferimento (per collegamento Airtable)
- Progetto/i a cui dare accesso

---

### Step 2 — Verifica se esiste già su Airtable

Cerca nella tabella Users (`tblUZSu2Goo77rTf5`) per email. Se esiste già, salta la creazione e vai al collegamento.

---

### Step 3 — Mostra riepilogo e chiedi conferma

```
Sto per:

1. Creare profilo su Airtable (se non esiste):
   👤 Nome: [nome]
   📧 Email: [email]
   🏷️ Tipo: Client

2. Collegare a:
   👥 Cliente: [nome cliente]
   📁 Progetto/i: [nomi progetti]

3. Inviare invito sul portale: digital-on.agency

Confermo?
```

Procedere SOLO dopo conferma esplicita.

---

### Step 4 — Crea il profilo su Airtable

Se non esiste ancora, usa `create_records_for_table` sulla tabella Users con nome ed email.
Salva il record ID restituito — serve per il passo successivo.

---

### Step 5 — Collega a cliente, progetti e gruppo Softr

1. Aggiorna il record cliente in Clienti/Business — aggiungi l'utente al campo `Users` (`fld4t8fcrVJV8S0DZ`)
2. Per ogni progetto, aggiorna il record in Progetti/Servizi — aggiungi l'utente al campo `Users` (`fldFRHwtKtTdVnQa0`)
3. **CRITICO per Softr** — aggiungi l'utente al gruppo Client nella tabella User Group:
   - Leggi prima i membri attuali del record `recDvbTRzYAiSRCL5` nella tabella `tblyNGER0nZVFezfE`
   - Aggiorna il campo `fldvd2Ln22rrHRhnQ` aggiungendo il nuovo record ID utente alla lista esistente
   - Senza questo passaggio Softr non riconosce il gruppo e l'utente vede tutto

---

### Step 6 — Invia invito via API Softr

Leggi la API key da `agency/secrets.md`, poi esegui via bash:

```bash
SOFTR_API_KEY=$(grep "API Key" /home/niccolo/vault-digitalon/agency/secrets.md | awk -F': ' '{print $2}')

curl -X POST "https://studio.softr.io/api/v1/applications/digitalon.softr.app/users/invite" \
  -H "Content-Type: application/json" \
  -H "Softr-Api-Key: $SOFTR_API_KEY" \
  -d '{
    "email": "[EMAIL]",
    "full_name": "[NOME]"
  }'
```

---

### Step 7 — Conferma e aggiorna il vault

Dopo l'invio:
1. Comunica: "Invito inviato a [email] ✓ — riceverà un'email per accedere a digital-on.agency"
2. Aggiorna `## Storico attività` nel CLAUDE.md cliente: `YYYY-MM-DD — invito portale inviato a [nome] ([email])`

---

## Regole

- MAI procedere senza conferma esplicita
- MAI leggere o loggare la API key di Softr — usarla solo inline nel comando curl
- Se l'invio dell'invito fallisce, segnalare l'errore curl e non aggiornare il vault
- Se l'utente esiste già su Softr, l'API restituirà errore — segnalarlo e chiedere se procedere solo con il collegamento Airtable
- Dopo l'invito, ricordare all'utente di configurare i filtri su Softr per limitare la visibilità ai soli dati del cliente
