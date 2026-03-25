#!/bin/bash
# Cron job manutenzione vault Digital On
# Orario: 30 6 * * * (06:30 UTC = 07:30 ora italiana)

export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

# Leggi token Discord
source /home/niccolo/.env-digitalon 2>/dev/null || true

TIMESTAMP=$(date -u '+%Y-%m-%d %H:%M UTC')
VAULT="/opt/vault-digitalon"
CHANNEL_ID="1485585935424028724"

send_discord() {
  local MSG="$1"
  curl -s -X POST "https://discord.com/api/v10/channels/${CHANNEL_ID}/messages" \
    -H "Authorization: Bot ${DISCORD_BOT_TOKEN}" \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"${MSG}\"}" > /dev/null
}

echo "[$TIMESTAMP] Inizio manutenzione vault"
echo "[$TIMESTAMP] Token: ${DISCORD_BOT_TOKEN:0:20}..."

OUTPUT=$(cd "$VAULT" && claude --dangerously-skip-permissions -p "esegui la skill manutenzione-vault" 2>&1)
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
  send_discord "⚠️ Manutenzione vault fallita — errore Claude Code."
  echo "[$TIMESTAMP] Errore: $OUTPUT"
  exit 1
fi

RIEPILOGO=$(echo "$OUTPUT" | tail -10)
send_discord "🔧 Manutenzione vault $(date '+%Y-%m-%d'): $RIEPILOGO"

echo "[$TIMESTAMP] Manutenzione completata con successo"
