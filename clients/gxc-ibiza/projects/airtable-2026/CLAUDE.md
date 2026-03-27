# GXC Ibiza — Airtable 2026

## Stato progetto
**Avanzamento**: Moduli Case e Finanza — struttura creata ✅
**Ultimo aggiornamento**: 2026-03-27
**Base Airtable**: GXC 2026 (`appGAocDZYn4vznWZ`)

## Contesto
Nuova base Airtable costruita da zero nel 2026 per sostituire quella vecchia ("Global X Connect", `appJ8ezwrxeJI1t40`), diventata troppo complessa e stratificata. Obiettivo: struttura pulita, scalabile, compatibile con Softr come front-end.

La base vecchia esiste ancora e può essere usata come riferimento di contesto, ma NON va replicata.

## Tabelle esistenti (pre-esistenti, non toccate)
| Tabella | ID | Scopo |
|---|---|---|
| User Group | `tblyNGER0nZVFezfE` | Gruppi/ruoli utenti |
| Users | `tblUZSu2Goo77rTf5` | Team interno GXC |
| Partners | `tbloXp3UDtaTaoZVB` | Partner esterni |
| Projects | `tblylhAgyc47wEal2` | Progetti in corso |
| Task | `tblhrxCxAzWKOaKCW` | To-do con subtask e priorità |
| Tickets (To Rebuild) | `tblAgd4HlH7uALGvm` | Sistema supporto interno, WIP |
| Lead Generation | `tblxpQO4YrF3cK3Rd` | Lead dal sito web |

## Modulo Case — Creato il 2026-03-27

### Tabelle create
| Tabella | ID | Scopo |
|---|---|---|
| **Houses** | `tblqI7eeziHVaai90` | Anagrafica case gestite da GXC |
| **Stays** | `tbl5PjBjRoxZK4MAx` | Soggiorni promoter nelle case |
| **Stay Payments** | `tblxqxFCAR69b6UBd` | Pagamenti ricevuti per ogni soggiorno |

### Struttura Houses
- `House Name` (primary), `Address`, `Beds`, `Season Start`, `Season End`, `Monthly Rent Cost` (€), `Status` (Available/Occupied/Maintenance), `Notes`
- Rollup da aggiungere: `Total Revenue` (da Stays.Total Paid), `Expected Revenue` (da Stays.Total Due)
- Formula da aggiungere: `Total Margin` = Total Revenue − Monthly Rent Cost

### Struttura Stays
- `Stay Name` (primary), `Check-in Date`, `Check-out Date`, `Price per Night` (€), `Status` (Active/Completed/Cancelled), `Notes`
- Link: `House` → Houses, `Promoter` → Users
- Link inversi creati automaticamente su Houses e Users
- Campi di calcolo da aggiungere:
  - `Total Days` (formula): `DATETIME_DIFF({Check-out Date}, {Check-in Date}, 'days')`
  - `Total Paid` (rollup da Stay Payments → Amount Paid → SUM)
  - `Total Due` (formula): `{Total Days} * {Price per Night}`
  - `Balance Due` (formula): `{Total Due} - {Total Paid}`

### Struttura Stay Payments
- `Payment Name` (primary), `Amount Paid` (€), `Payment Date`, `Payment Method` (Cash/Bank Transfer/Card), `Notes`
- Link: `Stay` → Stays

## Modulo Finanziario — Creato il 2026-03-27

### Tabelle create
| Tabella | ID | Scopo |
|---|---|---|
| **Accounts** | `tbl3u1UAb0LMYQW0I` | Contenitori di denaro (casse, conti, wallet) |
| **Transactions** | `tblQ5cn5oWesVqp2E` | Log unico di tutti i movimenti economici |

### Struttura Accounts
- `Account Name` (primary), `Account Type` (Cash/Bank/Personal), `Notes`
- Link inversi ricevuti da Transactions: `Transactions Out` (Origin Account), `Transactions In` (Destination Account)
- Rollup da aggiungere: `Total In` (da Transactions In → Amount → SUM), `Total Out` (da Transactions Out → Amount → SUM)
- Formula da aggiungere: `Balance` = Total In − Total Out

### Struttura Transactions
- `Transaction Name` (primary), `Date`, `Type` (Income/Expense/Transfer), `Amount` (€)
- `Category`: House Rent / Ticket Sales / Deposit Received / Other Income / House Cost / Marketing / Operations / Staff / Other Expense / Internal Transfer
- `Subcategory` (testo libero), `Department` (Houses/Sales/Marketing/Operations/General)
- `Payment Method` (Cash/Bank Transfer/Card), `Attachment`, `Notes`
- Link: `House` → Houses, `Stay` → Stays, `Promoter` → Users, `Managed By` → Users, `Origin Account` → Accounts, `Destination Account` → Accounts

## Relazioni tra moduli
```
Houses ←→ Stays ←→ Stay Payments
  ↓             ↓
Transactions ←——————————
  ↓      ↓
Accounts  Users (Promoter / Managed By)
```

## Prossimi step
- [ ] Aggiungere formule e rollup su Stays (Total Days, Total Paid, Total Due, Balance Due)
- [ ] Aggiungere rollup su Houses (Total Revenue, Expected Revenue, Total Margin)
- [ ] Aggiungere rollup su Accounts (Total In, Total Out, Balance)
- [ ] Popolare Accounts con i contenitori reali di GXC (cassa, conto, wallet team)
- [ ] Inserire dati reali di test (2-3 case, 3-4 soggiorni, qualche pagamento e transazione)
- [ ] Creare viste su Softr (scheda casa, scheda promoter, dashboard finanziaria, scadenze)
- [ ] Verificare calcoli con Nick

## Decisioni di design
- [2026-03-27] Transactions è il libro mastro unico — tutto passa da lì
- [2026-03-27] Stay Payments e Houses sono tabelle di dettaglio collegate a Transactions, non parallele
- [2026-03-27] Accounts rappresentano contenitori fisici/bancari reali, non categorie contabili
- [2026-03-27] Rollup e formule non ancora creati — richiede dati reali per test prima di validare
- [2026-03-27] Softr come front-end: struttura progettata per essere leggibile e filtrabile per Softr
