#!/bin/bash
# Pull-Script (gitPush.sh)

# Einlesen der .env Datei
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_PATH="$SCRIPT_DIR/../.env"
REPO_PATH="."

if [ -f "$ENV_PATH" ]; then
    REPO_PATH_LINE=$(grep "^\s*REPO_PFAD_UNIX\s*=" "$ENV_PATH" 2>/dev/null)
    if [ -n "$REPO_PATH_LINE" ]; then
        REPO_PATH=$(echo "$REPO_PATH_LINE" | sed 's/^\s*REPO_PFAD_UNIX\s*=\s*\(.*\)\s*$/\1/' | tr -d '"' | tr -d "'" | xargs)
    fi
    echo "RepoPfad aus .env-Datei: $REPO_PATH"
else
    echo -e "\033[33mWARNUNG: .env-Datei nicht gefunden unter: $ENV_PATH\033[0m"
fi

# Wechsel zum Repository-Verzeichnis
echo "Wechsel zu Repository-Verzeichnis: $REPO_PATH"
cd "$REPO_PATH" || exit 1

# Aktuellen Zeitstempel für Commit-Nachricht erstellen
ZEITSTEMPEL=$(date "+%Y-%m-%d %H:%M:%S")

# Status überprüfen
STATUS=$(git status --porcelain)
echo "Git Status: $STATUS"

if [ -n "$STATUS" ]; then
    echo -e "\033[33mAenderungen festgestellt. Bereite Commit und Push vor...\033[0m"
   
    # Alle Änderungen stagen
    git add .
    echo "Änderungen wurden gestaged."
   
    # Commit erstellen
    git commit -m "Automatischer Commit am: $ZEITSTEMPEL"
    echo "Commit wurde erstellt mit Nachricht: $ZEITSTEMPEL"
   
    # Push durchführen
    echo -e "\033[32mPushen der Aenderungen...\033[0m"
    if git push; then
        echo -e "\033[32mPush erfolgreich!\033[0m"
    else
        echo -e "\033[31mPush fehlgeschlagen!\033[0m"
    fi
else
    echo -e "\033[34mKeine Aenderungen gefunden.\033[0m"
fi
