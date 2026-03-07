# Guía de Configuración SSH

### Requisitos previos

El servidor SSH debe estar instalado y corriendo en la VM. 
Para verificarlo, en la terminal bash ejecutamos `systemctl status ssh`

Si no esta instalado, hay que ejecutar el script install_SSH.sh en el directorio gsx-debian/scripts/setup/

Al ejecutar ese script no solamente instala SSH en nuestra máquina sino que también lo configura, cambia el puerto del predeterminado (22) al 2222, y modifica la opción PermitRootLogin de forma que no se permitirá el acceso remoto a root.

Finalmente, hay que habilitar el Port Forwarding de la VM, ya que la IP interna no es accesible directamente desde Windows.
Para hacer esto tenemos que ir a la configuración de VirtualBox y en el apartado red hacer click en la opción de reenvio de puertos y añadir una nueva regla con los campos:

- Name: SSH
- Protocolo: TCP
- IP anfitrion: 127.0.0.1
- Puerto anfitrion: 2222
- IP invitado: (dejar vacío)
- Puerto invitado: 2222

###  Paso 1 — Generar Par de Claves SSH (en el servidor)

Primero hay que ejecutar el comando `ssh-keygen -t ed25519 -C "gsx-practica"` en la terminal indicando un nombre a la clave, en este caso gsx-practica. 
Al ejecutar esto, nos pedira guardar la clave en un directorio, que por defecto es (`~/.ssh/id_ed25519`). Y en este caso elegimos esa ubicacion clicando Enter. Y después le añadimos una contraseña.

###  Paso 2 — Añadir la clave pública en el servidor (por ejemplo en .ssh/authorized_keys)

Después de generar la clave vamos a añadirla a authorized_keys en la parte del servidor, para hacer esto ejecutamos:

`cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys` 

Y le damos permisos al propietario:
  
`chmod 600 ~/.ssh/authorized_keys`

###  Paso 3 — Conectarse desde la terminal del host Windows

Para hacer esto, desde la maquina Windows escribimos cmd y accedemos a la terminal. Una vez dentro ejecutamos el siguiente comando:

`ssh -p 2222 gsx@127.0.0.1`

La primera vez que lo ejecutemos nos pedirá confirmar el fingerprint del servidor, y escribimos yes.
Una vez hecho esto cuando nos conectemos via SSH a la VM, no nos volverá a preguntar y podremos acceder al sistema Debian.
