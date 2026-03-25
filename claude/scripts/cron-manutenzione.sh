#!/bin/bash
# Cron job manutenzione vault Digital On
# Orario: 30 6 * * * (06:30 UTC = 07:30 ora italiana)

set -a
source /home/niccolo/.env-digitalon 2>/dev/null || true
set +a

export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

TIMESTAMP=$(date -u '+%Y-%m-%d %H:%M UTC')
VAULT="/opt/vault-digitalon"
NOTIFY="$VAULT/claude/scripts/notify-discord.sh"

echo "[$TIMESTAMP] Inizio manutenzione vault"

OUTPUT=$(cd "$VAULT" && claude --dangerously-skip-permissions -p "esegui la skill manutenzione-vault" 2>&1)
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
  bash "$NOTIFY" "⚠️ Manutenzione vault fallita — errore Claude Code."
  echo "[$TIMESTAMP] Errore: $OUTPUT"
  exit 1
fi

RIEPILOGO=$(echo "$OUTPUT" | tail -10)
bash "$NOTIFY" "🔧 Manutenzione vault $(date '+%Y-%m-%d'):
$RIEPILOGO"

echo "[$TIMESTAMP] Manutenzione completata con successo"
