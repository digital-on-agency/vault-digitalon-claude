# GXC Ibiza — Airtable 2026

## Stato progetto
**Avanzamento**: Moduli Case e Finanza — struttura COMPLETA ✅
**Ultimo aggiornamento**: 2026-03-28
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

## Modulo Case ✅ COMPLETO

### Tabelle
| Tabella | ID | Scopo |
|---|---|---|
| **Houses** | `tblqI7eeziHVaai90` | Anagrafica case gestite da GXC |
| **Stays** | `tbl5PjBjRoxZK4MAx` | Soggiorni promoter nelle case |
| **Stay Payments** | `tblxqxFCAR69b6UBd` | Pagamenti ricevuti per ogni soggiorno |

### Houses — Campi
| Campo | ID | Tipo |
|---|---|---|
| House Name (primary) | `fldgsDBfr8d2Sifcr` | singleLineText |
| Address | `flduV87lDnMewOthC` | singleLineText |
| Beds | `fld82clHIrTxjR5fy` | number |
| Season Start | `fldGtT0Azh9aOHRej` | date |
| Season End | `fldLIhssdnRkdofYN` | date |
| Monthly Rent Cost | `fldNC16uD5BMQTqAH` | currency (€) |
| Status | `fldAUjoIrIjPVC7q6` | singleSelect (Available/Occupied/Maintenance) |
| Notes | `fldHIliE4400r0oJn` | multilineText |
| Stays (link) | `fldGzBBXhGV4eNezI` | multipleRecordLinks → Stays |
| Transactions (link) | `fldtAppCryuksBCXK` | multipleRecordLinks → Transactions |
| Total Revenue | `fldQALSoZIIUZZaNQ` | rollup (da Stays → Total Paid → SUM) |
| Expected Revenue | `fldcAdNxHDMBgsgGn` | rollup (da Stays → Total Due → SUM) |
| Total Margin | `fldcDgofYTy3pSjSG` | formula (Total Revenue − Monthly Rent Cost) |

### Stays — Campi
| Campo | ID | Tipo |
|---|---|---|
| Stay Name (primary) | `fldpzlR0OUjYD7WPS` | singleLineText |
| Check-in Date | `fldon9BufyfqPcYpe` | date |
| Check-out Date | `fldyLT21qlhir0XEZ` | date |
| Price per Night | `fldj2pDN5R4y3Uulb` | currency (€) |
| Status | `fldILCz8Wqcd5Vk3e` | singleSelect (Active/Completed/Cancelled) |
| Notes | `fld900Cv9T0ezFLbW` | multilineText |
| House (link) | `fldCWUgufPmjdBLvC` | multipleRecordLinks → Houses |
| Promoter (link) | `fldXaF7pB9VLCKWpE` | multipleRecordLinks → Users |
| Stay Payments (link) | `fldMDonrYFaJb3Mzs` | multipleRecordLinks → Stay Payments |
| Transactions (link) | `fldC18uQt2QvCb8s8` | multipleRecordLinks → Transactions |
| Total Days | `fldvFfjrEEbElgxoQ` | formula: `DATETIME_DIFF({Check-out Date},{Check-in Date},'days')` |
| Total Paid | `fldIPjyWJpfT3lybw` | rollup (da Stay Payments → Amount Paid → SUM) |
| Total Due | `fldxcuOw0sj0FKF24` | formula: `{Total Days}*{Price per Night}` |
| Balance Due | `fldjQl0WP4aBS9Jvk` | formula: `{Total Due}-{Total Paid}` |

### Stay Payments — Campi
| Campo | ID | Tipo |
|---|---|---|
| Payment Name (primary) | `fldrs9K7tk8qEjhg4` | singleLineText |
| Amount Paid | `fld8pAwMnFbM55y9B` | currency (€) |
| Payment Date | `fldV0TZTWxgH26KMe` | date |
| Payment Method | `fldG3vq4667xK3HMI` | singleSelect (Cash/Bank Transfer/Card) |
| Notes | `fldLQDadGW2VoyIHB` | multilineText |
| Stay (link) | `fldlyBeTiMcLCJifZ` | multipleRecordLinks → Stays |

## Modulo Finanziario ✅ COMPLETO

### Tabelle
| Tabella | ID | Scopo |
|---|---|---|
| **Accounts** | `tbl3u1UAb0LMYQW0I` | Contenitori di denaro (casse, conti, wallet) |
| **Transactions** | `tblQ5cn5oWesVqp2E` | Log unico di tutti i movimenti economici |

### Accounts — Campi
| Campo | ID | Tipo |
|---|---|---|
| Account Name (primary) | `fldvnEbv6qB8ifLHO` | singleLineText |
| Account Type | `fldWnN2Wtd8Cy0Ec8` | singleSelect (Cash/Bank/Personal) |
| Notes | `fldR7fid0kiMkTOWq` | multilineText |
| Transactions In (link) | `fldjWuiYZJ0Vrojx0` | multipleRecordLinks → Transactions (Destination Account) |
| Transactions Out (link) | `fldPE5b9HtWYZiAnx` | multipleRecordLinks → Transactions (Origin Account) |
| Total In | `flddbx5sJOu2dZu7R` | rollup (da Transactions In → Amount → SUM) |
| Total Out | `fldoU2UVilRTXPd7q` | rollup (da Transactions Out → Amount → SUM) |
| Balance | `fldVT1SvXIBKyIg6O` | formula: `{Total In}-{Total Out}` |

### Accounts — Record predisposti
| Account | Tipo | Note |
|---|---|---|
| Office Cash | Cash | Cassa fisica ufficio |
| Bank Account — GXC | Bank | Da aggiornare con istituto/IBAN reali |
| Nick — Personal | Personal | Wallet personale Nick |
| Petty Cash — Operations | Cash | Piccola cassa operativa |

### Transactions — Campi
| Campo | ID | Tipo |
|---|---|---|
| Transaction Name (primary) | `fldg5mwcbOeN5o0Z2` | singleLineText |
| Date | `fldt3JDcQzxOGxVHg` | date |
| Type | `fld3tALMzkXUoGs4L` | singleSelect (Income/Expense/Transfer) |
| Amount | `fld2jaTU1l73dLASC` | currency (€) |
| Category | `fldSr6at0hxf1Uv06` | singleSelect (House Rent/Ticket Sales/Deposit Received/Other Income/House Cost/Marketing/Operations/Staff/Other Expense/Internal Transfer) |
| Subcategory | `fldquPHhtQX5Ice0Y` | singleLineText |
| Department | `fldiNJnQQKmMg0VJq` | singleSelect (Houses/Sales/Marketing/Operations/General) |
| Payment Method | `fldPmm8gwRGtlswAw` | singleSelect (Cash/Bank Transfer/Card) |
| Attachment | `fldv7nE32IXe8KOUt` | multipleAttachments |
| Notes | `fldRn1pAHP7KitjkH` | multilineText |
| House (link) | `fldSIUKbsaz5Y6ch9` | multipleRecordLinks → Houses |
| Stay (link) | `fldWKwwPPw6BRO7Lk` | multipleRecordLinks → Stays |
| Promoter (link) | `fldzhxKGWln7hCPZL` | multipleRecordLinks → Users |
| Managed By (link) | `fldQNWPrLP3KzePh2` | multipleRecordLinks → Users |
| Origin Account (link) | `fldDQFcaxI9EJDXG8` | multipleRecordLinks → Accounts |
| Destination Account (link) | `fldkgGvrIERg1WViT` | multipleRecordLinks → Accounts |

## Decisioni di design
- [2026-03-27] Transactions è il libro mastro unico — tutto passa da lì
- [2026-03-27] Stay Payments e Houses sono tabelle di dettaglio collegate a Transactions
- [2026-03-27] Accounts rappresentano contenitori fisici/bancari reali, non categorie contabili
- [2026-03-27] Softr come front-end: struttura progettata per essere leggibile e filtrabile
- [2026-03-28] Struttura completamente verificata e funzionante — pronta per dati reali

## Prossimi step
- [ ] Inserire case reali di GXC nella tabella Houses
- [ ] Inserire soggiorni promoter stagione 2026 in Stays
- [ ] Aggiornare Account "Bank Account — GXC" con dati bancari reali
- [ ] Aggiungere eventuali altri Account (wallet altri membri del team)
- [ ] Test con dati reali: 2-3 soggiorni completi con pagamenti e transazioni
- [ ] Costruire viste Softr: scheda casa, scheda promoter, dashboard finanziaria, scadenze
- [ ] Verificare calcoli con Nick
