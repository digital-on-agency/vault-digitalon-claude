#!/bin/bash
# Uso: task-end.sh "messaggio di commit"
# Il messaggio viene generato da Claude Code

cd ~/vault-digitalon

# Controlla se ci sono modifiche
if git diff --quiet && git diff --staged --quiet; then
  echo "Nessuna modifica al vault."
  exit 0
fi

# Il messaggio deve essere passato come primo argomento
if [ -z "$1" ]; then
  echo "Errore: nessun messaggio di commit fornito."
  exit 1
fi

git add -A
git commit -m "$1"
git push 2>&1
echo "Vault aggiornato e pushato."
