# GXC Ibiza — Airtable 2026

## Stato progetto
**Avanzamento**: Moduli Case e Finanza — struttura COMPLETA + dati di test inseriti ✅
**Ultimo aggiornamento**: 2026-03-29
**Base Airtable**: GXC 2026 (`appGAocDZYn4vznWZ`)

## Decisioni architetturali chiave
- [2026-03-29] **Stay Payments eliminata come flusso separato** — i pagamenti affitto promoter si registrano direttamente in Transactions (Type=Income, Category=House Rent, Stay collegato). Stay Payments rimane come tabella tecnica ma non viene esposta su Softr.
- [2026-03-29] Il campo `Total Paid` su Stays deve essere aggiornato manualmente: rollup da `Transactions` (campo Stay) → Amount → SUM con filtro Type=Income. Da fare su Airtable UI.
- [2026-03-29] `Created By` = singleLineText, compilato da Softr con `{{logged_in_user.full_name}}` come campo hidden nei form
- [2026-03-29] `Created At` = dateTime su tutte le tabelle principali
- [2026-03-27] Transactions è il libro mastro unico — tutto passa da lì
- [2026-03-27] Accounts rappresentano contenitori fisici/bancari reali
- [2026-03-27] Softr come front-end, piano Professional

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
| **Stay Payments** | `tblxqxFCAR69b6UBd` | NON usata — rimpiazzata da Transactions |

### Houses — Campi principali
| Campo | ID | Tipo |
|---|---|---|
| House Name (primary) | `fldgsDBfr8d2Sifcr` | singleLineText |
| Address | `flduV87lDnMewOthC` | singleLineText |
| Beds | `fld82clHIrTxjR5fy` | number |
| Season Start | `fldGtT0Azh9aOHRej` | date |
| Season End | `fldLIhssdnRkdofYN` | date |
| Monthly Rent Cost | `fldNC16uD5BMQTqAH` | currency (€) |
| Status | `fldAUjoIrIjPVC7q6` | singleSelect |
| Notes | `fldHIliE4400r0oJn` | multilineText |
| Stays (link) | `fldGzBBXhGV4eNezI` | → Stays |
| Transactions (link) | `fldtAppCryuksBCXK` | → Transactions |
| Total Revenue | `fldQALSoZIIUZZaNQ` | rollup (da Stays → Total Paid) |
| Expected Revenue | `fldcAdNxHDMBgsgGn` | rollup (da Stays → Total Due) |
| Total Margin | `fldcDgofYTy3pSjSG` | formula |
| Created At | `fldObhHnq1Rv2nLIH` | dateTime |
| Created By | `fldnJn45SchuRkMeN` | singleLineText |

### Stays — Campi principali
| Campo | ID | Tipo |
|---|---|---|
| Stay Name (primary) | `fldpzlR0OUjYD7WPS` | singleLineText |
| Check-in Date | `fldon9BufyfqPcYpe` | date |
| Check-out Date | `fldyLT21qlhir0XEZ` | date |
| Price per Night | `fldj2pDN5R4y3Uulb` | currency (€) |
| Status | `fldILCz8Wqcd5Vk3e` | singleSelect |
| Notes | `fld900Cv9T0ezFLbW` | multilineText |
| House (link) | `fldCWUgufPmjdBLvC` | → Houses |
| Promoter (link) | `fldXaF7pB9VLCKWpE` | → Users |
| Stay Payments (link) | `fldMDonrYFaJb3Mzs` | → Stay Payments (non usato) |
| Transactions (link) | `fldC18uQt2QvCb8s8` | → Transactions |
| Total Days | `fldvFfjrEEbElgxoQ` | formula |
| Total Paid | `fldIPjyWJpfT3lybw` | rollup — DA AGGIORNARE: puntare a Transactions invece di Stay Payments |
| Total Due | `fldxcuOw0sj0FKF24` | formula |
| Balance Due | `fldjQl0WP4aBS9Jvk` | formula |
| Created At | `fldqNjuZy5vTFvMBK` | dateTime |
| Created By | `fldHyL8fmdE1WmDLH` | singleLineText |

## Modulo Finanziario ✅ COMPLETO

### Tabelle
| Tabella | ID | Scopo |
|---|---|---|
| **Accounts** | `tbl3u1UAb0LMYQW0I` | Contenitori di denaro |
| **Transactions** | `tblQ5cn5oWesVqp2E` | Log unico movimenti |

### Accounts — Record predisposti
| Account | ID Record | Tipo |
|---|---|---|
| Office Cash | `recXXXrTCKdaRFq2i` | Cash |
| Bank Account — GXC | `recxjmSkLk1Rl3zWc` | Bank |
| Nick — Personal | `reck8HOM6cdwc9swK` | Personal |
| Petty Cash — Operations | `recJswI078Ja21Fgb` | Cash |

### Transactions — Campi principali
| Campo | ID | Tipo |
|---|---|---|
| Transaction Name (primary) | `fldg5mwcbOeN5o0Z2` | singleLineText |
| Date | `fldt3JDcQzxOGxVHg` | date |
| Type | `fld3tALMzkXUoGs4L` | singleSelect (Income/Expense/Transfer) |
| Amount | `fld2jaTU1l73dLASC` | currency (€) |
| Category | `fldSr6at0hxf1Uv06` | singleSelect |
| Department | `fldiNJnQQKmMg0VJq` | singleSelect |
| Payment Method | `fldPmm8gwRGtlswAw` | singleSelect |
| House (link) | `fldSIUKbsaz5Y6ch9` | → Houses |
| Stay (link) | `fldWKwwPPw6BRO7Lk` | → Stays |
| Origin Account (link) | `fldDQFcaxI9EJDXG8` | → Accounts |
| Destination Account (link) | `fldkgGvrIERg1WViT` | → Accounts |
| Created At | `fldoLMzDqqswDuUjS` | dateTime |
| Created By | `fldCjnQuV9hcykiAm` | singleLineText |

## Dati di test inseriti (2026-03-29)
### Houses (3 record)
- Casa Marina — Ibiza Town — 4 beds — €3.200/mese — Available
- Villa Sol — San Antonio — 6 beds — €4.800/mese — Occupied
- Apt Talamanca — Ibiza — 2 beds — €1.800/mese — Available

### Stays (3 record)
- Marco — Villa Sol — 1 mag / 30 set — €35/notte — Total Due €5.320
- Sofia — Casa Marina — 1 giu / 31 ago — €40/notte — Total Due €3.640
- Damian — Apt Talamanca — 1 lug / 15 ago — €30/notte — Total Due €1.350

### Transactions (6 record)
- House rent Marco May — Income €1.050 — House Rent — Cash
- House rent Sofia Jun — Income €1.200 — House Rent — Bank Transfer
- Meta Ads Week 14 — Expense €850 — Marketing — Card
- Monthly rent Villa Sol May — Expense €4.800 — House Cost — Bank Transfer
- Transfer Office Cash → Nick — Transfer €500 — Internal Transfer — Cash
- Google Ads April — Expense €620 — Marketing — Card

## Prossimi step
- [ ] Aggiornare rollup `Total Paid` su Stays: puntare a Transactions (Stay link) → Amount → SUM con filtro Type=Income (da fare in Airtable UI)
- [ ] Su Softr: nella Stay Detail rimuovere il List block Stay Payments e sostituire con List block Transactions filtrato per Stay = current record + Type = Income
- [ ] Aggiungere campo `Created By` come hidden in tutti i form Softr con valore `{{logged_in_user.full_name}}`
- [ ] Aggiungere tooltip in inglese su tutti i form (testi già definiti in conversazione)
- [ ] Configurare User Groups su Softr (Admin / Staff) e impostare visibilità pagina Finance
- [ ] Test end-to-end con Nick
