#!/bin/bash

# Crear la carpeta base del equipo
mkdir /home/greendevcorp/
chgrp -R greendevcorp /home/greendevcorp/

# Crear la carpeta bin y asignarle los permisos minimos a los usuarios
mkdir -p /home/greendevcorp/bin
chmod 750 /home/greendevcorp/bin

# Crear la carpeta shared y asignarle los permisos minimos a los usuarios
mkdir -p /home/greendevcorp/shared
chmod 3770 /home/greendevcorp/shared

# Crear el archivo done.log, establecer dev1 como su dueño, greendevcorp como su grupo y asignar permisos mínimos
touch /home/greendevcorp/done.log
chown dev1:greendevcorp /home/greendevcorp/done.log
chmod 640 /home/greendevcorp/done.log

