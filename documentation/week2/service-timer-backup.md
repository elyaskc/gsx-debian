# Como configurar el service y timer para el backup

Los archivos gsx-backup.service y gsx-backup.timer se encargan conjuntamente de ejecutar el script backup.sh situado en /opt/scripts.
Su objetivo es que se cree una copia de seguridad todos los dias a las 00:00.

## Configuración
Ambos archivos deben estar en la carpeta /etc/systemd/system para poder funcionar correctamente.

Una vez esten en esa carpeta hay que ejecutar el siguiente comando para que el timer interno los detecte:
	**sudo systemctl daemon-reload**

Luego hay que activarlos de la siguiente manera:
	**sudo systemctl enable gsx-backup.timer**
	**sudo systemctl start gsx-backup.timer**

Finalmente, para poder ver cuando será la siguiente vez que se tiene que ejecutar podemos utilizar el comando:
	**systemctl list-timers --all**
