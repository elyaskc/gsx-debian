#!/bin/bash


set -e
set -u

BACKUP_DIR="/mnt/backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
DAY=$(date +%u)  # 1=Monday, 7=Sunday
LOGFILE="/var/log/admin/backup.log"

SOURCES=(
    /etc
    /home/gsx/Prac1/gsx-debian
    /var/log/admin
)

#Función para crear el log 
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | sudo tee -a "$LOGFILE"
}

# Borrar backups de más de 30 dias
cleanup_old_backups() {
    log "Borrando backups de más de 30 dias..."
    sudo find "$BACKUP_DIR" -name "*.tar.gz" -mtime +30 -delete
    log "Borrado completado."
}

# Full backup
full_backup() {
    BACKUP_FILE="$BACKUP_DIR/full_$TIMESTAMP.tar.gz"
    log "Full Backup en: $BACKUP_FILE"

    sudo tar -czpf "$BACKUP_FILE" \
        "${SOURCES[@]}" 2>/dev/null

    SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
    log "Full backup completado: $BACKUP_FILE ($SIZE)"
}

# Incremental backup
incremental_backup() {
    BACKUP_FILE="$BACKUP_DIR/incremental_$TIMESTAMP.tar.gz"
    log "Backup incremental en: $BACKUP_FILE"

    sudo tar -czpf "$BACKUP_FILE" \
        "${SOURCES[@]}" 2>/dev/null

    SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
    log "Backup incremental completado: $BACKUP_FILE ($SIZE)"
}

# Main
log "Backup iniciado"

if [ "$DAY" -eq 7 ]; then
    log "Es domingo y toca Full Backup"
    full_backup
else
    log "Es un dia de cada dia y toca Backup incremental"
    incremental_backup
fi

cleanup_old_backups
