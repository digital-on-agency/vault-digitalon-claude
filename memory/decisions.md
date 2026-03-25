# Decisioni trasversali

Decisioni che valgono per più clienti o per l'agenzia nel suo complesso.
Formato: data — decisione — motivazione — impatto.

---

## 2026-03-25 — Formato ID Task nei log clienti

**Decisione**: Il formato standard per gli ID task in tutti i log clienti è:
`[SIGLA-CLIENTE]-[GG-MM-AAAA]-[CAT][NUM]`

Esempio: `GXC-25-03-2026-STR001`

**Categorie e abbreviazioni:**
- `SVL` — Sviluppo
- `CRM` — CRM
- `BOT` — Chatbot
- `ADS` — Ads
- `ANA` — Analytics
- `CALL` — Call
- `STR` — Strategia
- `SUP` — Supporto

**Sigle clienti attivi:**
- `GXC` — Global X Connect (GXC Ibiza)
- `TRP` — Trovapulizie
- `SVB` — Silvetti Brugali
- `SLP` — Studio Legale Pompei

**Motivazione**: Il vecchio formato `ACME-26-001` non indicava la data né la categoria, rendendo difficile leggere il log a colpo d'occhio. Il nuovo formato è immediatamente interpretabile da Claude e dagli operatori.

**Impatto**: Tutti i log clienti esistenti aggiornati il 25-03-2026. Il template `clients/_template/log.md` aggiornato — tutti i nuovi clienti useranno questo formato automaticamente. Quando si aggiunge un nuovo cliente, definire la sigla e aggiungerla a questa lista.
