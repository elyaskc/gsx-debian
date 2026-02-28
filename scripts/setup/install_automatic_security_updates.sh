#!/bin/bash
sudo apt install -y unattended-upgrades

# Generar y configurar el archivo de configuración
sudo dpkg-reconfigure -f noninteractive unattended-upgrades

# Habilitar servicio
sudo systemctl enable --now unattended-upgrades

if systemctl is-active --quiet unattended-upgrades; then
    	echo "Actualizaciones de seguridad automáticas habilitadas."
else
    	echo "No se pudo activar unattended-upgrades."
	exit 1
fi
