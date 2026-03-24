#!/bin/bash
# Verificar que todo esté instalado correctamente

USER_NAME="gsx"
SSH_PORT=2222
SSH_CONFIG="/etc/ssh/sshd_config"
DIRS=(
	/opt/scripts
	/etc/configs
	/var/backup
	/documentation
)

# Verificar que el usuario gsx tenga permisos sudo (pertenece al grupo sudo)
if getent group sudo | grep -qw  "$USER_NAME"; then
	echo "El usuario $USER_NAME tiene permisos sudo"
else
	echo "El usuario no tiene permisos sudo, dando permisos..."
	sudo usermod -aG sudo "$USER_NAME"
	echo "El usuario $USER_NAME ahora tiene permisos sudo"
fi

# Verificar si el servicio SSH está activo en el puerto 2222
if sudo systemctl is-active --quiet ssh; then
	echo "El servicio SSH está activo. Comprobando puerto..."
	if grep -q "^Port $SSH_PORT" "$SSH_CONFIG"; then
		echo "El puerto está establecido en 2222"
	else
		echo "El puerto no está establecido en 2222. Reconfigurando..."
		sudo ./install_SSH.sh
	fi
else
	echo "El servicio SSH no está activo. Activando..."
	if sudo systemctl -q start ssh; then
		echo "El servicio SSH ya se encuentra activo."
	else
		echo "No se encuentra el servicio SSH. Instalando..."
		sudo ./install_SSH.sh
	fi
fi

# Verificar actualizaciones de seguridad automáticas
if sudo systemctl is-active --quiet  unattended-upgrades; then
	echo "Las actualizaciones automáticas están activadas"
else
	echo "Las actualizacioens automáticas están desactivadas. Activando..."
	sudo ./install_automatic_security_updates.sh
fi

# Verificar que todas las carpetas estén creadas
folder_missing=0

for folder in "${folders[@]}"; do
	if [ ! -d "$folder" ]; then
		folder_missing=1
	fi
done

if [ $folder_missing -eq 1 ]; then
	echo "Creando carpetas restantes..."
	sudo ./setup-dirs.sh
	echo "Carpetas creadas"
fi
