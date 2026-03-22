#!/bin/bash

LOGFILE="/var/log/admin/workload.log"
WORKERS=()

log(){
   echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

start_workers(){
     log "Iniciando 3 workers en segundo plano..."
     for i in 1 2 3; do
	yes > /dev/null &
	WORKERS+=($!)
	log "El worker $i se ha iniciado con el PID ${WORKERS[-1]}"
     done
}

stop_workers(){
     log "Parando workers de manera graceful (SIGTERM)..."
     for PID in "${WORKERS[@]}"; do
	if kill -0 "$PID" 2>/dev/null; then
	   kill -SIGTERM "$PID"
	   log "Enviada la señal SIGTERM al PID $PID"
	fi
     done
}

status_report(){
     log "Recibido SIGUSR1 - reporte del estado:"
     for PID in "${WORKERS[@]}"; do
	 STATUS=$(ps -p "$PID" -o stat= 2>/dev/null || echo "dead")
	 log "PID del worker $PID: $STATUS"
     done
}

#Manejo de las señales
trap 'log "Recibido SIGINT - parando..."; stop_workers; exit 0' SIGINT
trap 'log "Recibido SIGTERM - parando graceful..."; stop_workers; exit 0' SIGTERM
trap 'status_report' SIGUSR1
trap 'log "Recibido SIGUSR2 - reiniciando workers..."; stop_workers; sleep 1; WORKERS=(); start_workers' SIGUSR2

log "script iniciado (PID: $$)"
start_workers

log "Ejecutando... Envia señales al PID $$ para interactuar:"
log "  kill -SIGUSR1 $$ -> reporte de estado"
log "  kill -SIGUSR2 $$ -> reinicio de workers"
log "  kill -SIGTERM $$ -> parada graceful"
log "  CTRL+C           -> parar SIGINT"


while true; do
    sleep 5
    log "workers ejecutandose: ${#WORKERS[@]}"
done




