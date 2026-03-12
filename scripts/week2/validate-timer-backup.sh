#!/bin/bash

# Comprobar que los archivos de configuración existan en su ruta, sinó copiarlos donde deben estar dandoles los permisos necesarios
if [ ! -f /etc/systemd/system/gsx-backup.service ]; then
	sudo install -m 644 /home/gsx/gsx/gsx-debian/config/gsx-backup.service /etc/systemd/system
fi

if [ ! -f /etc/systemd/system/gsx-backup.timer ]; then
        sudo install -m 644 /home/gsx/gsx/gsx-debian/config/gsx-backup.timer /etc/systemd/system
fi

# Reiniciar el servicio de timers para que detecte los nuevos archivos
sudo systemctl daemon-reload

# Si el servicio no está activado, activarlo
if [ ! systemctl is-enabled gsx-backup.timer ]; then
	sudo systemctl enable gsx-backup.timer
	sudo systemctl start gsx-backup.timer
fi

# Comprobar que toda la configuración se ha hecho correctamente y el timer ya está activo
if systemctl list-timers --all | grep -q "gsx-backup"; then
	echo "Timer del backup funcionando."
fi
