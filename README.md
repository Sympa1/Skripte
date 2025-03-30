# Skripte-Repository

Dieses Repository enthält eine Sammlung von nützlichen Skripten.

## Überblick

Die Skripte dienen der Automatisierung wiederkehrender Aufgaben und der Vereinfachung von Workflows. Aktuell enthält das Repository Skripte zum Pullen und Pushen von GitHub-Repositories unter Verwendung von Pfaden, die in `.env`-Dateien gespeichert werden. Diese Umgebungsvariablen-Dateien werden nicht im Repository gespeichert, um sensible Informationen zu schützen.

## Verzeichnisstruktur

```
.
├── powershell/
│   ├── gitPull.ps1
│   └── gitPush.ps1
├── bash/
│   ├── pull-repo.sh
│   └── push-repo.sh
├── .gitignore
├── .env
├── README.md
└── LICENSE
```

## Installation

1. Klone dieses Repository:
   ```
   git clone https://github.com/Sympa1/Skripte
   ```

2. Navigiere in das Verzeichnis:
   ```
   cd Skripte
   ```

3. Erstelle nach der untenstehenden Anleitung ein `.env` File.

## Umgebungsvariablen

Die Skripte verwenden `.env`-Dateien, um Pfade und andere Konfigurationen zu speichern. Diese werden nicht im Repository gespeichert.

Beispiel für eine `.env`-Datei für Git-Skripte:
```
# Repository-Pfad
REPO_PATH_WIN=C:/Pfad/zum/Repository
REPO_PATH_LIN=
```

## Verwendung

### PowerShell Git-Skripte

Um ein Repository zu pullen:
```powershell
./powershell/gitPull.ps1
```

Um ein Repository zu pushen:
```powershell
./powershell/gitPush.ps1
```

### Bash Git-Skripte

Um ein Repository zu pullen:
```bash
./bash/gitPull.sh
```

Um ein Repository zu pushen:
```bash
./bash/gitPush.sh
```
## .gitignore

Die folgende `.gitignore`-Datei wird verwendet:

```
# Umgebungsvariablen-Dateien
.env
**/.env
```

## Lizenz

Dieses Projekt ist unter der GPL-3.0 lizenziert - siehe die [LICENSE](LICENSE)-Datei für Details.