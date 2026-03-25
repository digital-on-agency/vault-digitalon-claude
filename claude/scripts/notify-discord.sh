#!/bin/bash
# Invia una notifica nel canale #sistema di Discord
# Uso: bash notify-discord.sh "messaggio"

CHANNEL_ID="1485585935424028724"
BOT_TOKEN="${DISCORD_BOT_TOKEN:-MTQ4MzgzMjAyMzA3MTA2ODIyMg.G3lMwP.Q8vDmBkdJLG3Mu7bg9FL4xMr3I4yLrRnvI7Mc0}"
MESSAGE="$1"

if [ -z "$MESSAGE" ]; then
  echo "Uso: $0 'messaggio'"
  exit 1
fi

curl -s -X POST "https://discord.com/api/v10/channels/${CHANNEL_ID}/messages" \
  -H "Authorization: Bot ${BOT_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{\"content\": \"$MESSAGE\"}" > /dev/null

echo "Notifica inviata: $MESSAGE"
