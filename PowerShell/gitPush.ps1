# Einlesen der .env Datei
$scriptVerzeichnis = Split-Path -Parent $MyInvocation.MyCommand.Path
$envPfad = Join-Path $scriptVerzeichnis "..\.env"
$repoPfad = "."  

if (Test-Path $envPfad) {
    $repoPfad = (Get-Content $envPfad -ErrorAction SilentlyContinue | Select-String "^\s*REPO_PFAD_WIN\s*=\s*(.+)\s*$").Matches.Groups[1].Value.Trim()
    Write-Host "RepoPfad aus .env-Datei: $repoPfad"
} else {
    Write-Host "WARNUNG: .env-Datei nicht gefunden unter: $envPfad" -ForegroundColor Yellow
}

# Wechsel zum Repository-Verzeichnis
Write-Host "Wechsel zu Repository-Verzeichnis: $repoPfad"
Set-Location -Path $repoPfad

# Aktuellen Zeitstempel für Commit-Nachricht erstellen
$zeitstempel = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Status überprüfen
$status = git status --porcelain
Write-Host "Git Status: $status"

if ($status -ne "") {
    Write-Host "Aenderungen festgestellt. Bereite Commit und Push vor..." -ForegroundColor Yellow
   
    # Alle Änderungen stagen
    git add .
    Write-Host "Änderungen wurden gestaged."
   
    # Commit erstellen
    git commit -m "Automatischer Commit am: $zeitstempel"
    Write-Host "Commit wurde erstellt mit Nachricht: $zeitstempel"
   
    # Push durchführen
    Write-Host "Pushen der Aenderungen..." -ForegroundColor Green
    try {
        git push
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Push erfolgreich!" -ForegroundColor Green
        } else {
            Write-Host "Push fehlgeschlagen!" -ForegroundColor Red
        }
    } catch {
        Write-Host "Fehler beim Pushen: $_" -ForegroundColor Red # $_ --> zeigt den Fehler
    }
} else {
    Write-Host "Keine Aenderungen gefunden." -ForegroundColor Blue
}
