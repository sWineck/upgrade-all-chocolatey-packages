# upgrade all chocolatey packages
 Verwendet die Powershell 7 mit Admin-Rechten um den Befehl "choco upgrade all -y" auszuführen. Die aktualisierten Pakete werden mit Datum und Uhrzeit in ein Logfile geschrieben.
 
Passe die Pfade für das Logfile im Skript wenn nötig an und ersetze "USERNAME" mit deinem richtigen Benutzernamen unter Windows.
 
Das Skript kann mit dem Task Scheduler automatisiert werden, sodass die Pakete immer aktuell gehalten werden. Z.B. könnte man das Skript bei jeder Anmeldung eines Benutzers ausführen.
Starte dafür den Task Scheduler als Administrator und erstelle eine "Einfache Aufgabe". Gebe Namen und Beschreibung an. Wähle den gewünschten Trigger. Bei Aktion "Programm starten" wählen. Gebe nun den Pfad zu deiner Powershell ein oder finde die .exe mit dem Explorer über "Durchsuchen". Bei mir ist es dieser Pfad: "C:\Program Files\PowerShell\7\pwsh.exe".
Füge folgende Argumente hinzu: -NoExit -ExecutionPolicy Bypass -File "C:\Users\USERNAME\files\choco_upgrade.ps1"
Achte auch hier auf den korrekten Pfad zum Skript.
Jetzt auf "Weiter" klicken und anschließend auf "Fertig stellen".

Finde nun deine neu erstellte Aufgabe und lasse dir die Eigenschaften über eine Rechtsklick auf die Aufgabe anzeigen.
Im Reiter "Allgemein" sollte ein Admin-Konto ausgewählt sein, welches verwendet wird um die Aufgabe auszuführen. Wenn das nicht der Fall ist, ändere dies über den Button "Benutzer oder Gruppe ändern".
Wähle nun "Unabhängig von der Benutzeranmeldung ausführen" und setze die Checkbox "Mit höchsten Privilegien ausführen".
Unter dem Reiter "Trigger" sollte, wenn der Trigger "Bei Anmeldung" gesetzt ist, der gewünschte Benutzer ausgewählt sein. Wenn das nicht so ist, markiere den Trigger und klicke auf "Bearbeiten", dann öffnet sich ein weiteres Fenster, dort auf "Benutzer ändern" gehen oder einfach "Jeder Benutzer" auswählen, sodass die Aufgabe bei jeder Benutzeranmeldung ausgeführt wird, egal wer sich anmeldet.
Die Aufgabe sollte nun bei ausgelöstem Trigger ausgeführt werden.