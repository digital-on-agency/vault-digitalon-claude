#!/bin/bash
# Cron job per manutenzione automatica del vault
# Eseguito ogni giorno alle 06:30 UTC (07:30 ora italiana)

set -euo pipefail

# Carica variabili d'ambiente da .bashrc (PATH, DISCORD_BOT_TOKEN, ecc.)
source ~/.bashrc 2>/dev/null || true

# Assicura che node/npm/claude siano nel PATH
export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:/usr/local/bin:$PATH"

TIMESTAMP=$(date -u '+%Y-%m-%d %H:%M UTC')
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NOTIFY="$SCRIPT_DIR/notify-discord.sh"

echo "[$TIMESTAMP] Inizio manutenzione vault"

cd ~/vault-digitalon

if claude --dangerously-skip-permissions -p "esegui la skill manutenzione-vault"; then
    echo "[$TIMESTAMP] Manutenzione completata con successo"
else
    EXIT_CODE=$?
    echo "[$TIMESTAMP] Manutenzione fallita con exit code $EXIT_CODE"
    bash "$NOTIFY" "⚠️ Manutenzione vault fallita ($TIMESTAMP) — exit code $EXIT_CODE. Per rinnovare il token: 1) Sul server lancia: cd ~/vault-digitalon && npx -y mcp-remote@0.1.30 https://mcp-ga.stape.ai/mcp 2) Sul Mac apri tunnel SSH sulla porta indicata 3) Apri l'URL nel browser e completa il login"
fi
