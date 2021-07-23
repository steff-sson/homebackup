#!/bin/bash
#
read -p "Installiere Home Backup. Fortfahren? [J]a, [N]ein, [A]bbrechen." -n 1 -r
echo # neue Zeile
if [[ $REPLY =~ ^[Jj]$ ]]
then
  sudo cp homebackup.sh /usr/local/bin/homebackup.sh
  sudo chmod +x /usr/local/bin/homebackup.sh
  sudo cp homebackup-service.sh /usr/local/bin/homebackup-service.sh
  sudo chmod +x /usr/local/bin/homebackup-service.sh
  mkdir /home/$USER/.config/systemd
  mkdir /home/$USER/.config/systemd/user
  cp homebackup.service /home/$USER/.config/systemd/user/homebackup.service
  cp homebackup.timer /home/$USER/.config/systemd/user/homebackup.timer
  sudo systemctl daemon-reload
  echo "Applikation und Servicefiles kopiert."
  mkdir /home/$USER/homebackup
  cp -n homebackup.conf /home/$USER/homebackup/
  cp -n rsync-exclude.conf /home/$USER/homebackup/
  cp -n rsync-pw.conf /home/$USER/homebackup/
  chmod 600 /home/$USER/homebackup/rsync-pw.conf
  cp homebackup.desktop /home/$USER/.local/share/applications/homebackup.desktop
  update-desktop-database ~/.local/share/applications
  echo "Konfiguration nach /home/$USER/homebackup kopiert."
  echo "..."
  echo "..."
  echo "..."
  echo "Fertig!"
  echo "..."
  echo "Starte das Backup mit 'systemctl --user start homebackup.service'"
  echo "AUTOSTART des Backup mit 'systemctl --user enable homebackup.service'"
else
  echo "Breche ab."
fi
