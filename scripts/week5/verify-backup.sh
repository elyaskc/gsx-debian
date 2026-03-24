#!/bin/bash

set -e
set -u

BACKUP_DIR="/mnt/backup"
RESTORE_DIR="/tmp/backup-test"
LOGFILE="/var/log/admin/backup.log"

log() {
   echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | sudo tee -a "$LOGFILE"
}

#Obtener el ultimo backup
LATEST=$(ls -t "$BACKUP_DIR"/*.tar.gz 2>/dev/null | head -1)

if [ -z "$LATEST" ]; then
   log "No se han encontrado backups in $BACKUP_DIR"
   exit 1
fi

#Testear la integridad del backup
log "Comprobando la integridad del backup..."
if sudo tar -tzf "$LATEST" > /dev/null 2>&1; then
   log "La integridad del backup ha pasado la comprobacion"
else
   log "ERROR: El backup esta corrupto"
   exit 1
fi

#Testear el restore del backup en otro lugar
log "Testeando el restore a $RESTORE_DIR..."
sudo mkdir -p "$RESTORE_DIR"
sudo tar -xzpf "$LATEST" -C "$RESTORE_DIR" 2>/dev/null

#Verificar si los archivos estan presentes
if [ -d "$RESTORE_DIR/etc" ]; then
   log "/etc restaurado correctamente"
else
   log "ERROR: /etc no se ha encontrado en el restore"
   exit 1
fi

#Borrar el test de restore
sudo rm -rf "$RESTORE_DIR"
log "test restore borrado"

SIZE=$(du -sh "$LATEST" | cut -f1)
log "Backup verificado correctamente: $LATEST ($SIZE)"
log "Verificacion completada" 

