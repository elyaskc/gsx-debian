#!/bin/bash

set -e
set -u

if [ $# -eq 0 ]; then
   echo "Uso del script: $0 <nombre_proceso>"
   echo "Por ejemplo: $0 nginx"
   exit 1 
fi

PROCESS=$1
PID=$(pgrep "$PROCESS" | head -1)

if [ -z "$PID" ]; then
   echo "ERROR: El proceso '$PROCESS' no se encontró"
   exit 1
fi

echo "Metricas para: $PROCESS (PID: $PID)"

echo ""

#Mostrar la información general del proceso
echo "Información general"
ps -p "$PID" -o pid,ppid,user,%cpu,%mem,vsz,rss,stat,start,time,cmd | cat

echo ""

#Mostrar los valores de las metricas de ese proceso
echo "Estado: $(awk '/^State/{print $2, $3}' /proc/$PID/status)"
echo "Threads: $(awk '/^Threads/{print $2}' /proc/$PID/status)"
echo "Memoria: $(awk '/^VmRSS/{print $2, $3}' /proc/$PID/status)"
