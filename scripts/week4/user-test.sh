#!/bin/bash

# Comprobar si un usuario no puede ver los directorios de otro
su - dev2 -c 'ls /home/dev1 >/dev/null 2>&1' && echo "dev2 puede ver el home del dev1" || echo "dev2 no puede ver el home del dev1"

# Comprobar acceso a los scripts compartidos en la carpeta /bin
su - dev2 -c 'ls /home/greendevcorp/bin >/dev/null 2>&1' && echo 'dev2 puede ver el contenido de la carpeta bin' || echo 'dev2 no puede ver el contenido de la carpeta bin'

# Comprobar sticky bit en /home/greendevcorp/shared
su - dev1 -c 'touch /home/greendevcorp/shared/codigo.txt'
su - dev3 -c 'rm -f /home/greendevcorp/shared/codigo.txt >/dev/null 2>&1' && echo "sticky bit en shared no activado" || echo 'sticky bit activado en shared'

# Comprobar si solo dev1 puede escribir en done.log
su - dev2 -c 'cat /home/greendevcorp/done.log >/dev/null 2>&1' && echo "dev2 puede leer done.log" || echo "dev2 no puede leer done.log"
su - dev2 -c 'echo "# Texto añadido para comprobar permisos" >> /home/greendevcorp/done.log >/dev/null 2>&1' && echo 'dev2 puede escribir en done.log' || echo 'dev2 no puede escribir en done.log'

