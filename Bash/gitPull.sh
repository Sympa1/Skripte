#!/bin/bash
# Pull-Script (gitPull.sh)

# Einlesen der .env Datei
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_PATH="$SCRIPT_DIR/../.env"
REPO_PATH="."

if [ -f "$ENV_PATH" ]; then
    REPO_PATH_LINE=$(grep "^\s*REPO_PFAD_UNIX\s*=" "$ENV_PATH" 2>/dev/null)
    if [ -n "$REPO_PATH_LINE" ]; then
        REPO_PATH=$(echo "$REPO_PATH_LINE" | sed 's/^\s*REPO_PFAD_UNIX\s*=\s*\(.*\)\s*$/\1/' | tr -d '"' | tr -d "'" | xargs)
    fi
else
    echo -e "\033[33mWARNUNG: .env-Datei nicht gefunden unter: $ENV_PATH\033[0m"
fi

# Wechsel zum Repository-Verzeichnis
if [ -d "$REPO_PATH" ]; then
    cd "$REPO_PATH" || exit 1

    # Git Pull ausführen
    echo -e "\033[32mPullen der Aenderungen aus dem GitHub Repo...\033[0m"
    if git pull; then
        echo -e "\033[32mPull erfolgreich!\033[0m"
    else
        echo -e "\033[31mPull fehlgeschlagen!\033[0m"
    fi
else
    echo -e "\033[31mFEHLER: Das Repository-Verzeichnis existiert nicht: $REPO_PATH\033[0m"
fi
