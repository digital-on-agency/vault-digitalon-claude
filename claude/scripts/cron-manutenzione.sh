#!/bin/bash
# Cron job manutenzione vault Digital On
# Orario: 30 6 * * * (06:30 UTC = 07:30 ora italiana)

source /root/.env-digitalon 2>/dev/null || true
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

TIMESTAMP=$(date -u '+%Y-%m-%d %H:%M UTC')
VAULT="/opt/vault-digitalon"
NOTIFY="$VAULT/claude/scripts/notify-discord.sh"

echo "[$TIMESTAMP] Inizio manutenzione vault"

# Esegui Claude Code con la skill manutenzione-vault
OUTPUT=$(cd "$VAULT" && claude --dangerously-skip-permissions -p "esegui la skill manutenzione-vault" 2>&1)
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
  bash "$NOTIFY" "⚠️ Manutenzione vault fallita — errore Claude Code. Per rinnovare il token: cd /opt/vault-digitalon && claude"
  echo "[$TIMESTAMP] Errore manutenzione: $OUTPUT"
  exit 1
fi

# Invia riepilogo su Discord
RIEPILOGO=$(echo "$OUTPUT" | tail -10)
bash "$NOTIFY" "🔧 Manutenzione vault $(date '+%Y-%m-%d'):
$RIEPILOGO"

echo "[$TIMESTAMP] Manutenzione completata con successo"
