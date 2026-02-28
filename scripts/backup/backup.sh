#!/bin/bash

BACKUP_DIR="/var/backup/daily"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Directorios para hacerle backup
SOURCES=(
    /etc/ssh
    /opt/admin
    /var/log/admin
)

echo "Iniciando backup..."
echo "El backup se ha guardado en: $BACKUP_FILE"

# -p preserves file attributes and permissions
# -z compresses with gzip
sudo tar -czpf "$BACKUP_FILE" "${SOURCES[@]}"

echo "Verificando backup..."
if [ -f "$BACKUP_FILE" ]; then
    SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
    echo "[OK] Backup creado: $BACKUP_FILE ($SIZE)"
else
    echo "[FAIL] El archivo backup no se encontró"
    exit 1
fi

echo "Hecho."
