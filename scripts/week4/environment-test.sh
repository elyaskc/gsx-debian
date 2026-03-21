#!/bin/bash

# Suplantamos la identidad del dev1 y comprobamos el path
su - dev1 -c 'echo $PATH | grep -q "/home/greendevcorp/bin" && echo "Path correcto" || echo "Path incorrecto"'

# Suplantamos identidad y comprobamos alias
su - dev1 -c 'alias task_list >/dev/null && echo "Alias existe" || echo "Alias no existe"'
su - dev1 -c 'alias shared_dir >/dev/null && echo "Alias existe" || echo "Alias no existe"'
