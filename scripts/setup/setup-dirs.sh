#!/bin/bash

echo "Inicializando la estrucura de directorios..."

DIRS=(
  /opt/admin/scripts/setup
  /opt/admin/scripts/backup
  /opt/admin/config/ssh
  /opt/admin/config/systemd
  /opt/admin/docs
  /var/backup/daily
  /var/log/admin
)

for DIR in "${DIRS[@]}"; do
    if [ ! -d "$DIR" ]; then
        sudo mkdir -p "$DIR"
        echo "Creado: $DIR"
    else
        echo "Este directorio ya existe: $DIR"
    fi
done

echo "Dando permisos..."
sudo chown -R gsx:gsx /opt/admin
sudo chmod -R 750 /opt/admin

echo "La estructura de directorios se ha creado correctamente."
