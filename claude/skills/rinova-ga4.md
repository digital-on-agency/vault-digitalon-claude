---
name: rinova-ga4
description: Rinnova il token di autenticazione del MCP GA4 (Stape). Invocata automaticamente da Claude quando GA4 è disconnesso, o esplicitamente dall'utente.
allowed-tools: bash
---

# Skill: rinova-ga4

## Obiettivo
Rinnovare il token OAuth del MCP GA4 Stape in modo semi-automatico, guidando l'utente nei passi che richiedono interazione locale (tunnel SSH e browser).

## Quando viene invocata
- Automaticamente da Claude Code quando rileva che il MCP GA4 è disconnesso (Failed to connect)
- Esplicitamente dall'utente con frasi come "rinnova GA4", "riautentica GA4", "GA4 non funziona"

## Processo
1. Avvisa l'utente: "Il MCP GA4 deve essere riautenticato. Avvio il processo..."
2. Esegui `bash ~/vault-digitalon/claude/scripts/renew-ga4.sh`
3. Lo script stamperà:
   - Il comando SSH tunnel da eseguire sul Mac
   - L'URL da aprire nel browser
4. Aspetta che l'utente dica "fatto" o "ok" o simile
5. Verifica con `claude mcp list` che GA4 risulti Connected
6. Se connesso: conferma "GA4 riautenticato con successo. Riprendo l'operazione."
7. Se ancora Failed: informa l'utente e chiedi di riprovare

## Note
- La porta OAuth cambia ad ogni riavvio — lo script la rileva automaticamente
- Il tunnel SSH deve essere aperto sul Mac PRIMA di aprire l'URL nel browser
- Non tentare di automatizzare i passi che richiedono interazione browser
