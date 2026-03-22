#!/bin/bash

echo "TOP consumidores de CPU"
ps aux --sort=-%cpu | awk 'NR<=6 {printf "%-10s %-8s %-8s %s\n", $1, $2, $3, $11}'

echo ""

echo "TOP consumidores de Memoria"
ps aux --sort=-%mem | awk 'NR<=6 {printf "%-10s %-8s %-8s %s\n", $1, $2, $4, $11}'

echo ""

echo "Resumen del Sistema"
echo "CPU cores: $(nproc)"

free -h | awk 'NR==1{print "Memoria: "$0} NR==2{print $0}'
df -h / | awk 'NR==2{print "Disco: usado "$3" de "$2" ("$5" usado)"}'
