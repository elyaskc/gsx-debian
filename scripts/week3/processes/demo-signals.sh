#!/bin/bash

#Funcion de formateo de un log
log(){
   echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

#Programa de prueba que utiliza trap para capturar la señal SIGTERM y permite ver la diferencia entre una parada SIGTERM y una parada SIGKILL
trap 'log "Recibido SIGTERM - guardando el estado y saliendo de manera graceful..."; sleep 2; log "Limpieza hecha"; exit 0' SIGTERM

log "Proceso iniciado (PID: $$)"
log "Usa: kill -SIGTERM $$ para hacer una parada graceful"
log "Usa: kill -SIGKILL $$ para una parada forzada"

while true; do
    sleep 1
done
