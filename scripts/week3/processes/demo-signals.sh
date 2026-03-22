#!/bin/bash

log(){
   echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}


trap 'log "Recibido SIGTERM - guardando el estado y saliendo de manera graceful..."; sleep 2; log "Limpieza hecha"; exit 0' SIGTERM

log "Proceso iniciado (PID: $$)"
log "Usa: kill -SIGTERM $$ para hacer una parada graceful"
log "Usa: kill -SIGKILL $$ para una parada forzada"

while true; do
    sleep 1
done
