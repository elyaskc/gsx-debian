#/bin/bash

# Entra en el usuario dev1 e intenta ejecutar  60 procesos que duran 10s en segundo plano
su - dev1 -c 'for i in {1..60}; do sleep 10 & done'
# Aquí se verá un error por pantalla si funciona el límite

# El comando unlimit -n muestra la cantidad de archivos que podemos abrir al mismo tiempo, debe ser 1024
su - dev1 -c 'ulimit -n'
# Se imprimirá por pantalla el límite de dev1

# Intentamos reservar más memoria de la que está permitida, deberia fallar
su - dev1 -c 'python3 -c "a = \" \" * (600 * 1024 * 1024)"' 2>/dev/null || echo "Limite de memoria funciona"
