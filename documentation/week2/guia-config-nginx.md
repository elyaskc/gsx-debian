# Como instalar y configurar nginx

## Descripción
Nginx es un paquete que actua como servidor web, proxy interno, balanceador de carga y caché HTTP de código abierto.

## Instalación
Para instalarlo basta con ejecutar el script nginx_install.sh en el directorio gsx-debian/scripts/week2

## Configuración
Una vez instalado debemos configurarlo para que se inicie junto al sistema, esto lo conseguiremos gracias a los servicios de systemd.
Iremos al directorio /lib/systemd/system y modificaremos el archivo nginx.server de la siguiente manera:

- Una vez dentro se pueden distinguir 3 apartados:
	- [ Unit ] : Describe el servicio y indica cuando debe arrancarse el servicio nginx
	- [ Service ] : Describe como se ejecuta el servicio, rutas, comandos...
	- [ Install ] : Define cuando se tiene que activar el servicio, el apartado WantedBy indica para que tipo de usuario se va a arrancar

- Lo que nos interesa modificar es la parte del Service, añadiremos al final los siguientes campos junto a sus valores:
	- Restart=on-failure : Esto significa que cuando haya un error con el servicio se reiniciará automáticamente
	- RestartSec=5 : Esto indica cuantos segundos debe esperar entre el apagado y encendido del servicio al reiniciarse

Ahora debemos decirle al sistema que cuando arranque en el mode multi-agent (que viene por defecto en nginx.service) arranque también nginx.
Primero comprobaremos si está activado con el comando `systemctl is-enabled nginx` esto responderá con un enabled o disabled, en caso que no esté activado, habrá que ejecutar el comando `sudo systemctl enable nginx`.

