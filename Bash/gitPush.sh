#!/bin/bash
# Push-Script (gitPush.sh)

# Einlesen der .env Datei
SCRIPT_VERZEICHNIS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_PFAD="$SCRIPT_VERZEICHNIS/../.env"
REPO_PFAD="."

if [ -f "$ENV_PFAD" ]; then
    # REPO_PATH_LIN statt REPO_PFAD_UNIX verwenden
    REPO_PFAD_LIN=$(grep "^\s*REPO_PFAD_LIN\s*=" "$ENV_PFAD" 2>/dev/null)
    if [ -n "$REPO_PFAD_LIN" ]; then
        REPO_PFAD=$(echo "$REPO_PFAD_LIN" | sed 's/^\s*REPO_PFAD_LIN\s*=\s*\(.*\)\s*$/\1/' | tr -d '"' | tr -d "'" | xargs)
    fi
    echo "RepoPfad aus .env-Datei: $REPO_PFAD"
else
    echo -e "\033[33mWARNUNG: .env-Datei nicht gefunden unter: $ENV_PFAD\033[0m"
fi

# Wechsel zum Repository-Verzeichnis
echo "Wechsel zu Repository-Verzeichnis: $REPO_PFAD"
cd "$REPO_PFAD" || exit 1

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
        exit 1
    fi
else
    echo -e "\033[34mKeine Aenderungen gefunden.\033[0m"
fi