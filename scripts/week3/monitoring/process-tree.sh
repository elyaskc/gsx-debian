#!/bin/bash

#Script para mostrar el arbol de procesos de Linux y algunas metricas
echo "Arbol de procesos:"

if command -v pstree &>/dev/null; then
   pstree -p -u

else
   echo "no se encontró pstree, instalando pstree..."
   sudo apt install -y psmisc
   pstree -p -u
fi


echo "Resumen de procesos"
echo "Procesos totales: $(ps aux | awk 'END{print NR}')"
echo "Ejecutandose: $(ps aux | awk '$8=="R" {count++} END {print count+0}')"
echo "Procesos en reposo: $(ps aux | awk '$8=="S" {count++} END {print count+0}')"
echo "Procesos zombie: $(ps aux | awk '$8=="Z" {count++} END {print count+0}')"
