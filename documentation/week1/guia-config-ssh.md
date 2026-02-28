# Guía de Configuración SSH

## Requisitos previos

El servidor SSH debe estar instalado y corriendo en la VM. 
Para verificarlo, en la terminal bash ejecutamos systemctl status ssh. Si no esta instalado, hay que ejecutar el script install-packages en el directorio Prac1/gsx-debian/scripts/install-packages.sh

Después ejecutamos el script ssh_config.sh en el directorio Prac1/gsx-debian/config/ssh/ssh_config.sh y al ejecutarlo ahora el servidor usa el puerto 2222 y se le ha deshabilitado el root login.
También para verificar que el puerto se ha configurado correctamente podemos ejecutar en la terminal ssh ss -tlnp | grep ssh

Por ultimo hay que habilitar el Port Forwarding de la VM, ya que la IP interna (10.0.2.15) no es accesible directamente desde Windows.
Para hacer esto tenemos que ir a la configuración de VirtualBox y en el apartado red clickar en la opcion de reenvio de puertos y añadir una nueva regla con los campos:

Name: SSH
Protocolo: TCP
IP anfitrion: 127.0.0.1
Puerto anfitrion: 2222
IP invitado: 10.0.2.15
Puerto invitado: 2222

###  Paso 1 — Generar Par de Claves SSH (en el servidor)

Primero hay que ejecutar el comando ssh-keygen -t ed25519 -C "gsx-practica" en la terminal indicando un nombre a la clave, en este caso gsx-practica. 
Al ejecutar esto, nos pedira guardar la clave en un directorio, que por defecto es (`~/.ssh/id_ed25519`). Y en este caso elegimos esa ubicacion clickando Enter. Y después le añadimos una contraseña

###  Paso 2 — Añadir la clave pública en el servidor (por ejemplo en .ssh/authorized_keys)

Después de generar la clave vamos a añadirla a authorized_keys en la parte del servidor, para hacer esto ejecutamos:

cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

###  Paso 3 — Conectarse desde la terminal del host Windows

Para hacer esto, escribimos cmd y accedemos a la terminal. Una vez dentro ejecutamos el siguiente comando:

ssh -p 2222 gsx@127.0.0.1 

La primera vez que lo ejecutemos nos pedirá confirmar el fingerprint del servidor, y escribimos yes

Una vez hecho esto cuando nos conectemos via SSH a la VM, no nos volverá a preguntar y podremos acceder al sistema Debian.
