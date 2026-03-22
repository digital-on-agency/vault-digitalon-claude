#!/bin/bash

# Rinnovo token OAuth MCP GA4 (Stape)
# Uso: bash ~/vault-digitalon/claude/scripts/renew-ga4.sh

LOG_FILE="/tmp/ga4-mcp.log"

echo "=== Rinnovo autenticazione GA4 (Stape) ==="
echo ""

# 1. Cancella autenticazione precedente
rm -rf ~/.mcp-auth
echo "Cache autenticazione rimossa."

# 2. Avvia mcp-remote in background
echo "Avvio mcp-remote..."
npx -y mcp-remote@0.1.30 https://mcp-ga.stape.ai/mcp > "$LOG_FILE" 2>&1 &
MCP_PID=$!

# 3. Aspetta che il log si popoli
for i in $(seq 1 15); do
    sleep 1
    if grep -q "authorize this client" "$LOG_FILE"; then
        break
    fi
done

# 4. Estrai porta OAuth
PORT=$(grep -oP 'callback port: \K\d+' "$LOG_FILE" | head -1)
if [ -z "$PORT" ]; then
    echo "ERRORE: non riesco a trovare la porta OAuth nel log."
    echo "Contenuto del log:"
    cat "$LOG_FILE"
    kill "$MCP_PID" 2>/dev/null
    exit 1
fi

# 5. Estrai URL di autorizzazione
AUTH_URL=$(grep -A1 'Please authorize this client by visiting:' "$LOG_FILE" | tail -1 | tr -d '[:space:][:cntrl:]')
if [ -z "$AUTH_URL" ]; then
    echo "ERRORE: non riesco a trovare l'URL di autorizzazione nel log."
    echo "Contenuto del log:"
    cat "$LOG_FILE"
    kill "$MCP_PID" 2>/dev/null
    exit 1
fi

# 6. Istruzioni per l'utente
echo ""
echo "=========================================="
echo "  ISTRUZIONI PER COMPLETARE L'AUTENTICAZIONE"
echo "=========================================="
echo ""
echo "1. Sul tuo Mac, apri un terminale ed esegui:"
echo ""
echo "   ssh -L ${PORT}:localhost:${PORT} niccolo@$(hostname -I | awk '{print $1}')"
echo ""
echo "2. Con il tunnel aperto, apri questo URL nel browser:"
echo ""
echo "   ${AUTH_URL}"
echo ""
echo "3. Completa l'autorizzazione nel browser, poi torna qui."
echo "=========================================="
echo ""

# 7. Monitora il log per il completamento
echo "In attesa del completamento dell'autenticazione..."
while true; do
    if grep -q "Proxy established successfully" "$LOG_FILE" 2>/dev/null; then
        echo ""
        echo "Autenticazione completata."
        kill "$MCP_PID" 2>/dev/null
        exit 0
    fi
    if ! kill -0 "$MCP_PID" 2>/dev/null; then
        echo ""
        echo "ERRORE: il processo mcp-remote si è terminato inaspettatamente."
        echo "Contenuto del log:"
        cat "$LOG_FILE"
        exit 1
    fi
    sleep 2
done
