#!/bin/bash
VAULT_DIR="$(dirname "$(readlink -f "$0")")/../.."
cd "$VAULT_DIR"
git config --global --add safe.directory "$(pwd)" 2>/dev/null
echo "Inizio task — $(date '+%Y-%m-%d %H:%M')"
git pull --rebase 2>&1
echo "Vault sincronizzato."
