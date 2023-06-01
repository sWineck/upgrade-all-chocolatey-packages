# Überprüft, ob das Skript als Administrator ausgeführt wird
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
# Wenn das Skript nicht als Administrator ausgeführt wird, startet es sich selbst neu mit Administratorrechten
if (-not $isAdmin) {
    Start-Process -FilePath "pwsh.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

# Gibt eine Meldung aus, dass das Upgrade für alle Chocolatey-Pakete gestartet wird
echo "Starting upgrade for all chocolatey packages..."

# Führt `choco upgrade all -y` aus und speichert die Ausgabe sowohl in der Konsole als auch im temporären Logfile
choco upgrade all -y | Tee-Object -FilePath 'C:\Users\USERNAME\Documents\logs\choco-upgrade_temp_logfile.txt'

# Fügt das aktuelle Datum und die Uhrzeit zum endgültigen Logfile hinzu
Get-Date | Out-File -Append -FilePath 'C:\Users\USERNAME\Documents\logs\choco-upgrade_logfile.txt'

# Durchläuft die Ausgabe des temporären Logfiles und fügt Zeilen, die "Chocolatey upgraded" enthalten, und alle nachfolgenden Zeilen zum endgültigen Logfile hinzu
$foundUpgradeLine = $false
Get-Content -Path 'C:\Users\USERNAME\Documents\logs\choco-upgrade_temp_logfile.txt' | ForEach-Object {
    if ($_ -match "Chocolatey upgraded") {
        $foundUpgradeLine = $true
    }
    if ($foundUpgradeLine) {
        Out-File -Append -FilePath 'C:\Users\USERNAME\Documents\logs\choco-upgrade_logfile.txt' -InputObject $_
    }
}

# Löscht die temporäre Logfile
Remove-Item -Path 'C:\Users\USERNAME\Documents\logs\choco-upgrade_temp_logfile.txt'

# Fügt eine Trennlinie zum endgültigen Logfile hinzu
Out-File -Append -FilePath 'C:\Users\USERNAME\Documents\logs\choco-upgrade_logfile.txt' -InputObject "`n--------------------"

# Beendet das Skript mit dem Exitcode 0 (Erfolg)
$Host.SetShouldExit(0)
