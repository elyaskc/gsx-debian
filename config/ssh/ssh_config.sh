#!/bin/bash

SSH_CONFIG="/etc/ssh/sshd_config"
SSH_PORT=2222

echo "Haciendo backup de la confi original de SSH..."

if [ ! -f "${SSH_CONFIG}.bak" ]; then
    sudo cp "$SSH_CONFIG" "${SSH_CONFIG}.bak"
    echo "Backup created at ${SSH_CONFIG}.bak"
else
    echo "Backup already exists, skipping..."
fi

echo "Configurando SSH..."

# Cambiamos puerto 22 (default) al puerto 2222
sudo sed -i "s/^#Port 22/Port $SSH_PORT/" "$SSH_CONFIG"

# Deshabilitar root login
sudo sed -i "s/^#PermitRootLogin.*/PermitRootLogin no/" "$SSH_CONFIG"

echo "Reiniciando servicio SSH..."
sudo systemctl restart ssh

echo "Verificando que SSH esta ejecutandose..."
if systemctl is-active --quiet ssh; then
    echo "SSH se esta ejecutando en el puerto $SSH_PORT"
else
    echo "ERROR: SSH falló al iniciar"
    exit 1
fi

echo "==> Done."
