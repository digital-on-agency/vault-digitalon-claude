# GXC Ibiza — Airtable 2026

## Stato progetto
**Avanzamento**: Moduli Case e Finanza completi — Softr in costruzione
**Ultimo aggiornamento**: 2026-03-29
**Base Airtable**: GXC 2026 (`appGAocDZYn4vznWZ`)

## Decisioni architetturali chiave
- [2026-03-29] **Stay Payments eliminata** — i pagamenti affitto si registrano in Transactions (Type=Income, Category=House Rent, Stay collegato)
- [2026-03-29] **Stay Status = campo formula** basato su date + checkbox Cancelled. Valori: Active / Upcoming / Completed / Cancelled
- [2026-03-29] **House Status = campo formula** ibrido: Maintenance manuale (checkbox), Available/Occupied/Overbooked automatico da Available Beds Total
- [2026-03-29] **Available Beds Now** = Beds − Occupants Now (solo Active)
- [2026-03-29] **Available Beds Total** = Beds − Occupants Now − Occupants Upcoming
- [2026-03-29] **Occupants Now** = rollup COUNTIF Stay Status = "Active"
- [2026-03-29] **Occupants Upcoming** = rollup COUNTIF Stay Status = "Upcoming"
- [2026-03-29] House Status si basa su Available Beds Total — così il manager vede disponibilità pianificata, non solo real-time
- [2026-03-29] `Created By` = singleLineText hidden nei form Softr con `{{logged_in_user.full_name}}`
- [2026-03-29] `Created At` = dateTime su tutte le tabelle principali
- [2026-03-27] Transactions = libro mastro unico
- [2026-03-27] Softr piano Professional — app: gxcibiza.softr.app

## Referente cliente
**Niek** — owner GXC Ibiza (non "Nick")

## Tabelle GXC 2026

### Pre-esistenti (non toccare)
| Tabella | ID |
|---|---|
| User Group | `tblyNGER0nZVFezfE` |
| Users | `tblUZSu2Goo77rTf5` |
| Partners | `tbloXp3UDtaTaoZVB` |
| Projects | `tblylhAgyc47wEal2` |
| Task | `tblhrxCxAzWKOaKCW` |
| Tickets (To Rebuild) | `tblAgd4HlH7uALGvm` |
| Lead Generation | `tblxpQO4YrF3cK3Rd` |

### Modulo Case
| Tabella | ID | Note |
|---|---|---|
| **Houses** | `tblqI7eeziHVaai90` | Anagrafica case |
| **Stays** | `tbl5PjBjRoxZK4MAx` | Soggiorni promoter |
| ~~Stay Payments~~ | ~~`tblxqxFCAR69b6UBd`~~ | **ELIMINATA** — sostituita da Transactions |

### Modulo Finanziario
| Tabella | ID | Note |
|---|---|---|
| **Accounts** | `tbl3u1UAb0LMYQW0I` | Contenitori di denaro |
| **Transactions** | `tblQ5cn5oWesVqp2E` | Log unico movimenti |

## Campi chiave — Houses (`tblqI7eeziHVaai90`)
| Campo | ID | Tipo |
|---|---|---|
| House Name (primary) | `fldgsDBfr8d2Sifcr` | singleLineText |
| Address | `flduV87lDnMewOthC` | singleLineText |
| Beds | `fld82clHIrTxjR5fy` | number |
| Season Start | `fldGtT0Azh9aOHRej` | date |
| Season End | `fldLIhssdnRkdofYN` | date |
| Monthly Rent Cost | `fldNC16uD5BMQTqAH` | currency (€) |
| Status (vecchio, nascondere) | `fldAUjoIrIjPVC7q6` | singleSelect — da nascondere |
| Maintenance | `fldSAvQ2aQLARtYtX` | checkbox — manuale |
| Occupants Now | — | rollup COUNTIF "Active" su Stay Status |
| Occupants Upcoming | — | rollup COUNTIF "Upcoming" su Stay Status |
| Available Beds Now | — | formula: Beds − Occupants Now |
| Available Beds Total | — | formula: Beds − Occupants Now − Occupants Upcoming |
| House Status | — | formula: Maintenance > Overbooked > Occupied > Available |
| Total Revenue | `fldQALSoZIIUZZaNQ` | rollup da Stays → Total Paid |
| Expected Revenue | `fldcAdNxHDMBgsgGn` | rollup da Stays → Total Due |
| Total Margin | `fldcDgofYTy3pSjSG` | formula |
| Created At | `fldObhHnq1Rv2nLIH` | dateTime |
| Created By | `fldnJn45SchuRkMeN` | singleLineText |

## Campi chiave — Stays (`tbl5PjBjRoxZK4MAx`)
| Campo | ID | Tipo |
|---|---|---|
| Stay Name (primary) | `fldpzlR0OUjYD7WPS` | singleLineText |
| Check-in Date | `fldon9BufyfqPcYpe` | date |
| Check-out Date | `fldyLT21qlhir0XEZ` | date |
| Price per Night | `fldj2pDN5R4y3Uulb` | currency (€) |
| Cancelled | — | checkbox — manuale, priorità sullo status |
| Stay Status | — | formula: Cancelled > Upcoming > Active > Completed |
| House (link) | `fldCWUgufPmjdBLvC` | → Houses |
| Promoter (link) | `fldXaF7pB9VLCKWpE` | → Users |
| Transactions (link) | `fldC18uQt2QvCb8s8` | → Transactions |
| Total Days | `fldvFfjrEEbElgxoQ` | formula |
| Total Paid | `fldIPjyWJpfT3lybw` | rollup da Transactions → Amount (filtro Type=Income) |
| Total Due | `fldxcuOw0sj0FKF24` | formula |
| Balance Due | `fldjQl0WP4aBS9Jvk` | formula |
| Created At | `fldqNjuZy5vTFvMBK` | dateTime |
| Created By | `fldHyL8fmdE1WmDLH` | singleLineText |

## Accounts — Record predisposti
| Account | ID Record | Tipo |
|---|---|---|
| Office Cash | `recXXXrTCKdaRFq2i` | Cash |
| Bank Account — GXC | `recxjmSkLk1Rl3zWc` | Bank |
| Niek — Personal | `reck8HOM6cdwc9swK` | Personal |
| Petty Cash — Operations | `recJswI078Ja21Fgb` | Cash |

## Dati di test (da rimuovere prima del go-live)
Tutti i record con `Created By = "Digital On (test)"` sono dati fittizi.
- 3 case: Casa Marina, Villa Sol, Apt Talamanca
- 3 soggiorni: Marco, Sofia, Damian
- 6 transazioni: 2 income, 3 expense, 1 transfer

## Softr — Pagine costruite
| Pagina | Tipo | Gruppi |
|---|---|---|
| Home | Statica | Tutti |
| Houses | List block | Admin, Office |
| House Detail | Detail + List stays | Admin, Office |
| Stays | Table block | Admin, Office, Promoter |
| Stay Detail | Detail + List transactions | Admin, Office, Promoter |
| Finance | Tab container (Accounts + Transactions) | Solo Admin |
| Lead Generation | — | Admin, Office |

## Softr — User Groups
| Gruppo | Chi | Accesso |
|---|---|---|
| Admin | Niek | Tutto |
| Office | Team interno | Tutto tranne Finance |
| Promoter | Promoter esterni | Solo propri Stays — da configurare |

## Prossimi step
- [ ] Softr: impostare visibilità pagine per User Group (Finance solo Admin)
- [ ] Softr: aggiornare Houses List/Detail — sostituire campo Status con House Status
- [ ] Softr: aggiornare Add Stay form — aggiungere campo Cancelled come toggle
- [ ] Softr: testare filtro "Promoter = logged-in user" su pagina Stays per gruppo Promoter
- [ ] Airtable: nascondere/eliminare vecchio campo Status su Houses
- [ ] Pulire dati di test prima del go-live con Niek
- [ ] Test end-to-end completo con Niek
