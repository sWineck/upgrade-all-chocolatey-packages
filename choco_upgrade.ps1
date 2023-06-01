# Überprüft, ob das Skript als Administrator ausgeführt wird
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $isAdmin) {
    # Führt das Skript als Administrator aus, falls es nicht bereits als Administrator ausgeführt wird
    Start-Process -FilePath "pwsh.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

Write-Host "Upgrade für alle Chocolatey-Pakete wird gestartet..."

# Benutzername und Zeitstempel für den Logdateipfad
$userName = "USERNAME"
$dateTime = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$logFilePath = "C:\Users\$userName\Documents\logs\$dateTime-choco_upgrade_all-log.txt"

# Führt das Chocolatey-Upgrade aus und speichert die Ausgabe in $chocoOutput
$chocoOutput = choco upgrade cpu-z -y | ForEach-Object { Write-Host $_; $_ }

# Initialisiert die Variable $foundUpgrade
$foundUpgrade = $false

# Filtert die Zeilen ab und einschließlich "Chocolatey upgraded"
$chocoUpgraded = ($chocoOutput -split "`n" | ForEach-Object {
    if ($_ -match "Chocolatey upgraded") {
        $foundUpgrade = $true
    }
    if ($foundUpgrade) {
        $_
    }
}) -join "`n"

# Fügt die gefilterte Ausgabe zur Logdatei hinzu, wenn sie vorhanden ist
if ($chocoUpgraded) {
    $timestamp = Get-Date -Format "dddd, dd. MMMM yyyy HH:mm:ss"
    $logContent = "$timestamp`n`n$chocoUpgraded"

    # Erstellt die Logdatei, falls sie noch nicht existiert
    if (-not (Test-Path $logFilePath)) {
        New-Item -ItemType File -Path $logFilePath -Force | Out-Null
    }

    # Fügt die gefilterte Ausgabe zur Logdatei hinzu
    Add-Content -Path $logFilePath -Value $logContent
}

# Beendet das Skript
$Host.SetShouldExit(0)
