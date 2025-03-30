#!/bin/bash
# Pull-Script (gitPull.sh)

# Einlesen der .env Datei
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_PATH="$SCRIPT_DIR/../.env"
REPO_PATH="."

# Debugging ausgeben
echo "Skript-Verzeichnis: $SCRIPT_DIR"
echo "Env-Pfad: $ENV_PATH"

if [ -f "$ENV_PATH" ]; then
    # Zeige den Inhalt der .env-Datei für Debugging
    echo "Inhalt der .env-Datei:"
    cat "$ENV_PATH"
    
    # Suche nach REPO_PATH_LIN
    REPO_PATH_LINE=$(grep "^\s*REPO_PATH_LIN\s*=" "$ENV_PATH" 2>/dev/null)
    if [ -n "$REPO_PATH_LINE" ]; then
        REPO_PATH=$(echo "$REPO_PATH_LINE" | sed 's/^\s*REPO_PATH_LIN\s*=\s*\(.*\)\s*$/\1/' | tr -d '"' | tr -d "'" | xargs)
        echo "Repo-Pfad gefunden: $REPO_PATH"
    else
        echo "REPO_PATH_LIN nicht in .env gefunden"
    fi
else
    echo -e "\033[33mWARNUNG: .env-Datei nicht gefunden unter: $ENV_PATH\033[0m"
fi

# Ins Repo-Verzeichnis wechseln
if [ -d "$REPO_PATH" ]; then
    echo "Wechsle in Verzeichnis: $REPO_PATH"
    cd "$REPO_PATH" || {
        echo -e "\033[0;31mFehler beim Wechsel in das Verzeichnis $REPO_PATH!\033[0m"
        exit 1
    }
else
    echo -e "\033[0;31mVerzeichnis $REPO_PATH existiert nicht!\033[0m"
    exit 1
fi

# Git Pull ausführen mit expliziter Merge-Strategie
echo -e "\033[0;34mPull aus dem Repository...\033[0m"
pull_output=$(git pull --no-rebase 2>&1)
pull_exit_code=$?

echo "Pull Ausgabe: $pull_output"

# Prüfe beide möglichen Ausgaben (deutsch und englisch)
if [[ $pull_output == *"Bereits aktuell"* ]] || [[ $pull_output == *"Already up to date"* ]]; then
    echo -e "\033[0;34mBereits aktuell.\033[0m"
elif [[ $pull_exit_code -eq 0 ]]; then
    echo -e "\033[0;34mPull erfolgreich abgeschlossen!\033[0m"
else
    echo -e "\033[0;31mPull fehlgeschlagen! Exit-Code: $pull_exit_code\033[0m"
    exit 1
fi