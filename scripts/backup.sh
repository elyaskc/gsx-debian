#!/bin/bash

BACKUP_DIR="/var/backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Directorios para hacerl el backup
SOURCES=(
    /etc/configs
    /opt/scripts
)

# Creamos la  copia comprimida y manteniendo permisos
sudo tar -czpf "$BACKUP_FILE" "${SOURCES[@]}"

# Comprobamos que existe el backup creado e imprimimos su nombre y tamaño
if [ -f "$BACKUP_FILE" ]; then
    SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
    echo "Backup creado: $BACKUP_FILE ($SIZE)"
else
    echo "El archivo backup no se ha podido crear correctamente."
    exit 1
fi

