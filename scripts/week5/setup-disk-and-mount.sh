#!/bin/bash

set -e
set -u

DISK="/dev/sdb"
PARTITION="/dev/sdb1"
MOUNTPOINT="/mnt/backup"

echo "Verificando si la particion existe..."
if ! lsblk "$PARTITION" &>/dev/null; then
   echo "ERROR: La particion $PARTITION no se encontro, comprueba que el disco se ha añadido en VirtualBox"
   exit 1
fi

echo "Creando mount point..."
sudo mkdir -p "$MOUNTPOINT"

echo "Creando sistema de ficheros ext4 si no existe..."
if ! sudo blkid "$PARTITION" | grep -q "ext4"; then
   sudo mkfs.ext4 "$PARTITION"
else
   echo "El sistema de ficheros ya existe"
fi

echo "Configurando el montaje persistente en /etc/fstab"
UUID=$(sudo blkid -s UUID -o value "$PARTITION")
if ! grep -q "$UUID" /etc/fstab; then
   echo "UUID=$UUID  /mnt/backup  ext4  defaults  0  2" | sudo tee -a /etc/fstab
   echo "Montaje añadido a fstab"
else
   echo "El montaje ya existe en fstab"
fi

echo "Montando disco..."
sudo mount -a

echo "Verificando..."
if df -h | grep -q "$MOUNTPOINT"; then
   SIZE=$(df -h "$MOUNTPOINT" | awk 'NR==2{print $2}')
   echo "Disco montado en $MOUNTPOINT ($SIZE)"
else
   echo "ERROR: disco no montado"
   exit 1
fi
