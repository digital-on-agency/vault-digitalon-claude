---
name: manutenzione-vault
description: Skill di manutenzione automatica del vault. Invocata dal cron job ogni mattina. Controlla i trigger, esegue le skill necessarie, committa e notifica su Discord.
allowed-tools: bash, read, write, edit, glob
---

# Skill: manutenzione-vault

## Obiettivo
Eseguire la manutenzione automatica quotidiana del vault: controllare i trigger, invocare le skill necessarie, committare e notificare.

## Quando viene invocata
- Dal cron job ogni giorno alle 7:30 ora italiana
- Mai da sessioni interattive (usa le skill singole direttamente)

## Processo

1. Esegui git pull per sincronizzare il vault
2. Controlla inbox/: se ci sono file → invoca skill svuota-inbox
3. Controlla trigger compressione memoria:
   - Leggi claude/compression-log.md per il numero dell'ultimo commit di compressione
   - Esegui git log --oneline | wc -l per il numero attuale di commit
   - Se differenza >= 20 → invoca skill comprimi-memoria
   - Controlla anche dimensioni file soggetti con du -b → se qualcuno supera 50KB → invoca skill comprimi-memoria
4. Controlla daily-notes/: se ci sono 7+ file YYYY-MM-DD.md → invoca skill handle-daily-notes
5. Componi il messaggio di riepilogo con cosa è stato fatto (o "nessuna azione necessaria" se tutto ok)
6. Esegui git add -A e git commit con il messaggio di riepilogo nel formato:
   manutenzione: YYYY-MM-DD — [lista azioni eseguite o "nessuna azione necessaria"]
7. Esegui git push
8. Invia il messaggio di riepilogo su Discord con: bash ~/vault-digitalon/claude/scripts/notify-discord.sh "messaggio"

## Gestione token Claude scaduto
Questa skill viene invocata dal cron job in modo non interattivo. Se Claude Code non è autenticato, il cron job fallirà. In quel caso il cron job stesso (non questa skill) deve mandare una notifica Discord con queste istruzioni:
"⚠️ Manutenzione vault fallita — token Claude scaduto. Per rinnovare: 1) Sul server lancia: cd ~/vault-digitalon && npx -y mcp-remote@0.1.30 https://mcp-ga.stape.ai/mcp 2) Sul Mac apri tunnel SSH sulla porta indicata 3) Apri l'URL nel browser e completa il login"

## Formato messaggio Discord
✅ Manutenzione vault YYYY-MM-DD completata
- inbox: [N file classificati / nessun file]
- memoria: [compressa / nessuna azione]
- daily-notes: [settimana WXX archiviata / nessuna azione]
- commit: [hash breve]
