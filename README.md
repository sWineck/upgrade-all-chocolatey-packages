# upgrade all chocolatey packages
A PowerShell script that executes the command "choco upgrade all -y". A log file with timestamp shows the upgraded packages and the subsequent lines.

Dependencies: Chocolatey Package Manager has to be installed.
Replace "USERNAME" with the your user name for saving the log file in the correct path.
 
The script can be automated with the Task Scheduler, so that the packages are always kept up to date. E.g. you could run the script every time a user logs in.
Start the Task Scheduler as administrator and create a "Simple Task". Enter name and description. Select the desired trigger. Select "Start program" for the action. Now enter the path to your Powershell or find the .exe with the explorer via "Browse". For me it is this path: "C:\Program Files\PowerShell\7\pwsh.exe".
Add the following arguments:

-NoExit -ExecutionPolicy Bypass -File "C:\Users\USERNAME\files\choco_upgrade.ps1".

Again, make sure the path to the script is correct. Now click on "Next" and then "Finish".
Now find your newly created task and display the properties by right clicking on the task.
In the tab "General" an admin account should be selected, which will be used to execute the task. If this is not the case change it by clicking the "Change user or group" button.
Now select "Run independently of user login" and set the "Run with highest privileges" checkbox.
Under the "Trigger" tab, if the "On login" trigger is set, the desired user should be selected. If this is not the case, select the trigger and click on "Edit", then another window will open, now click "Change user" or simply select "Every user", so that the task will be executed, no matter who logs in.

# aktualisiere alle Chocolatey Pakete
Ein PowerShell Skript, welches den Befehl "choco upgrade all -y" auszuführt. Eine Log-Datei mit Zeitstempel zeigt die aktualisierten Pakete und die darauffolgenden Zeilen an.

Abhängigkeiten: Chocolatey Package Manager muss installiert sein.
Ersetze "USERNAME" mit deinem Benutzernamen für das Speichern der Log-Datei im korrekten Pfad.
 
Das Skript kann mit dem Task Scheduler automatisiert werden, sodass die Pakete immer aktuell gehalten werden. Z.B. könnte man das Skript bei jeder Anmeldung eines Benutzers ausführen.
Starte dafür den Task Scheduler als Administrator und erstelle eine "Einfache Aufgabe". Gebe Namen und Beschreibung an. Wähle den gewünschten Trigger. Bei Aktion "Programm starten" wählen. Gebe nun den Pfad zu deiner Powershell ein oder finde die .exe mit dem Explorer über "Durchsuchen". Bei mir ist es dieser Pfad: "C:\Program Files\PowerShell\7\pwsh.exe".
Füge folgende Argumente hinzu:

-NoExit -ExecutionPolicy Bypass -File "C:\Users\USERNAME\files\choco_upgrade.ps1"

Achte auch hier auf den korrekten Pfad zum Skript.
Jetzt auf "Weiter" klicken und anschließend auf "Fertig stellen".
Finde nun deine neu erstellte Aufgabe und lasse dir die Eigenschaften über einen Rechtsklick auf die Aufgabe anzeigen.
Im Reiter "Allgemein" sollte ein Admin-Konto ausgewählt sein, welches verwendet wird um die Aufgabe auszuführen. Wenn das nicht der Fall ist, ändere dies über den Button "Benutzer oder Gruppe ändern".
Wähle nun "Unabhängig von der Benutzeranmeldung ausführen" und setze die Checkbox "Mit höchsten Privilegien ausführen".
Unter dem Reiter "Trigger" sollte, wenn der Trigger "Bei Anmeldung" gesetzt ist, der gewünschte Benutzer ausgewählt sein.
Wenn das nicht so ist, markiere den Trigger und klicke auf "Bearbeiten", dann öffnet sich ein weiteres Fenster, dort auf "Benutzer ändern" gehen oder einfach "Jeder Benutzer" auswählen, sodass die Aufgabe bei jeder Benutzeranmeldung ausgeführt wird, egal wer sich anmeldet.
