# homebackup
Ein einfaches Skript zum Backup des HOME-Verzeichnisses unter Linux.

## To Do

## Abhängigkeiten
rsync

## Installation
* Konfiguration in **homebackup.conf** anpassen
* Passwort für rsync-Server (falls vorhanden) in **rsync-pw.conf** speichern
* Auszuschließende Dateien in **rsync-exclude.conf** anpassen
* Falls ein Systemd-Timer gewünscht ist: **homebackup.timer** anpassen
* **install.sh** ausführbar machen (chmod +x install.sh)
* **install.sh** ausführen

## Backup durchführen
* homebackup legt eine homebackup.desktop an, d.h. in KDE oder Gnome kann homebackup in den Apps manuell gestartet werden.
* Alternativ wird mit hombackup.service und homebackup.timer ein Systemd-Service installiert.
