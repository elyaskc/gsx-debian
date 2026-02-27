#!/bin/bash

echo "Actualizando paquetes..."
sudo apt update

PACKAGES=(
   openssh-server
)

echo "Instalando paquetes..."
sudo apt install -y "${PACKAGES[@]}"

echo "Hecho. Todos los paquetes se han instalado correctamente"
