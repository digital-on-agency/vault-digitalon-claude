#!/bin/bash
# Cron job manutenzione vault Digital On
# Orario: 30 6 * * * (06:30 UTC = 07:30 ora italiana)

export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
# Token Discord letto da file env separato
BOT_TOKEN=$(grep DISCORD_BOT_TOKEN /home/niccolo/.env-digitalon | cut -d'=' -f2 | tr -d '"' | tr -d "'")
export DISCORD_BOT_TOKEN="$BOT_TOKEN"

TIMESTAMP=$(date -u '+%Y-%m-%d %H:%M UTC')
VAULT="/opt/vault-digitalon"
NOTIFY="$VAULT/claude/scripts/notify-discord.sh"

echo "[$TIMESTAMP] Inizio manutenzione vault"

OUTPUT=$(cd "$VAULT" && claude --dangerously-skip-permissions -p "esegui la skill manutenzione-vault" 2>&1)
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
  DISCORD_BOT_TOKEN="$BOT_TOKEN" bash "$NOTIFY" "⚠️ Manutenzione vault fallita — errore Claude Code."
  echo "[$TIMESTAMP] Errore: $OUTPUT"
  exit 1
fi

RIEPILOGO=$(echo "$OUTPUT" | tail -10)
DISCORD_BOT_TOKEN="$BOT_TOKEN" bash "$NOTIFY" "🔧 Manutenzione vault $(date '+%Y-%m-%d'):
$RIEPILOGO"

echo "[$TIMESTAMP] Manutenzione completata con successo"
