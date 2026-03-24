#!/bin/bash

set -e
set -u 

echo "Configurando limite de recursos para el servicio nginx..."

sudo mkdir -p /etc/systemd/system/nginx.service.d/

sudo tee /etc/systemd/system/nginx.service.d/override.conf > /dev/null << EOF
[Service]
CPUQuota=20%
MemoryMax=256M
MemoryHigh=200M
EOF

#Reiniciar systemd y nginx para aplicar los cambios
echo "Recargando systemd y reinciando nginx..."
sudo systemctl daemon-reload
sudo systemctl restart nginx

#Mostrar los valores de los limites aplicados
echo "Verificando límites aplicados..."
CPU=$(cat /sys/fs/cgroup/system.slice/nginx.service/cpu.max)
MEM=$(cat /sys/fs/cgroup/system.slice/nginx.service/memory.max)

echo "Límite CPU: $CPU"
echo "Límite Memoria: $MEM"
