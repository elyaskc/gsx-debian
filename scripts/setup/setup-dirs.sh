#!/bin/bash

DIRS=(
	/opt/scripts
	/etc/configs
	/var/backup
	/documentation
)

sudo mkdir -p "${DIRS[@]}"

sudo chown -R gsx:gsx "${DIRS[@]}"
sudo chmod -R 750 "${DIRS[@]}"

echo "La estructura de directorios se ha creado correctamente y se han otorgado los permisos necesarios."
