#!/bin/bash
cd ~/vault-digitalon
echo "Inizio task — $(date '+%Y-%m-%d %H:%M')"
git pull --rebase 2>&1
echo "Vault sincronizzato."
