#!/bin/bash
#
# Ordner für Konfigurationsdateien
CONFIG=/home/$USER/homebackup
#
# Variablen aus der Datei "variables" werden eingelesen
#
source $CONFIG/homebackup.conf
#
# Passwort-Datei
PASSWDFILE=$CONFIG/rsync-pw.conf
#
# Exclude-File
EXCLDFILE=$CONFIG/rsync-exclude.conf
#
# Hauptprogramm
read -p "Starte Backup von $HOME. Danach den Computer herunterfahren? [J]a, [N]ein, [A]bbrechen." -n 1 -r
echo # neue Zeile
if [[ $REPLY =~ ^[Jj]$ ]]
then
  echo "Computer wird 2 Minuten nach Fertigstellen des Backup heruntergefahren."
  echo "Schreibe Backup-Zeitpunkt nach $HOME"
  date > $HOME/00_time-of-backup.txt
  echo "Schreibe Installierte Pakete nach $HOME"
  pacman -Qe > $HOME/00_installed_packages.txt
  echo "Starte Backup von $HOME"
  rsync -axvhrtgopqlD --update --delete --delete-excluded --protect-args --exclude-from=$EXCLDFILE --password-file=$PASSWDFILE --progress --stats $HOME/ $BACKUP/
  echo "Das Backup ist fertig! Fahre den Computer in 2 Minuten herunter."
  sudo shutdown +2
elif [[ $REPLY =~ ^[Nn]$ ]]
then
  echo "Der Computer wird nicht heruntergefahren."
  echo "Schreibe Backup-Zeitpunkt nach $HOME"
  date > $HOME/00_time-of-backup.txt
  echo "Schreibe Installierte Pakete nach $HOME"
  pacman -Qe > $HOME/00_installed_packages.txt
  echo "Starte Backup von $HOME"
  rsync -axvhrtgopqlD --update --delete --delete-excluded --protect-args --exclude-from=$EXCLDFILE --password-file=$PASSWDFILE --progress --stats $HOME/ $BACKUP/
  echo "Das Backup ist beendet."
else
	echo "Breche ab."
fi
