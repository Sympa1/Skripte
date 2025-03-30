# Pull-Script (gitPull.ps1)

$scriptVerzeichnis = Split-Path -Parent $MyInvocation.MyCommand.Path
$envPfad = Join-Path $scriptVerzeichnis "..\.env"
$repoPfad = "."  

if (Test-Path $envPfad) {
    $repoPfad = (Get-Content $envPfad -ErrorAction SilentlyContinue | Select-String "^\s*REPO_PFAD_WIN\s*=\s*(.+)\s*$").Matches.Groups[1].Value.Trim()
} else {
    Write-Host "WARNUNG: .env-Datei nicht gefunden unter: $envPfad" -ForegroundColor Yellow
}

# Wechsel zum Repository-Verzeichnis
if (Test-Path $repoPfad) {
    Set-Location -Path $repoPfad

    # Git Pull ausführen
    Write-Host "Pullen der Aenderungen aus dem GitHub Repo..." -ForegroundColor Green
    git pull
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Pull erfolgreich!" -ForegroundColor Green
    } else {
        Write-Host "Pull fehlgeschlagen!" -ForegroundColor Red
    }
} else {
    Write-Host "FEHLER: Das Repository-Verzeichnis existiert nicht: $repoPfad" -ForegroundColor Red
}