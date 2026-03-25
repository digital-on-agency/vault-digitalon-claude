# Pattern confermati

Approcci, workflow e soluzioni che hanno funzionato e sono riutilizzabili tra progetti e clienti diversi.
Formato: titolo — contesto — pattern — perché funziona.

---

## Design system come fonte di verità visiva

**Contesto**: Ogni volta che si genera UI, grafiche social, post, landing page o qualsiasi asset visivo per un cliente.

**Pattern**: Prima di generare qualsiasi asset visivo — che sia una landing page, un post social, una grafica Canva, un componente UI o un mockup Figma — controllare sempre se esiste `clients/[cliente]/design-system/tokens.md`. Se esiste, leggere i valori di colori, font e spaziature e applicarli nell'output. Non inventare palette o font diversi da quelli estratti.

**Come applicarlo**:
1. Controlla `clients/[cliente]/design-system/tokens.md`
2. Se esiste → usa quei valori come fonte primaria per colori (hex esatti), font families, border radius
3. Se non esiste → segnalalo all'utente e suggerisci di estrarlo prima con `design-system-extractor` + `salva-design-system`
4. Passa i valori estratti a qualsiasi tool di generazione (ui-ux-pro-max, Canva MCP, figma-design-system)

**Perché funziona**: Garantisce coerenza visiva tra web, social e print senza dover ricordare i valori ogni volta. Il vault diventa la fonte di verità unica per tutta l'identità visiva del cliente.

**Tool coinvolti**: design-system-extractor → salva-design-system → ui-ux-pro-max / Canva MCP / figma-design-system
