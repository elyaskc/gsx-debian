# Como configurar el service y timer para el backup

Los archivos gsx-backup.service y gsx-backup.timer se encargan conjuntamente de ejecutar el script backup.sh situado en /opt/scripts.
Su objetivo es que se cree una copia de seguridad todos los dias a las 00:00.

## Configuración
Ambos archivos deben estar en la carpeta /etc/systemd/system para poder funcionar correctamente.
El script validate-timer-backup.sh se encarga de todo lo siguiente de forma idempotente, si algo ya está en su sitio no lo mueve, si ya está activo no lo activa.

### validate-timer-backup.sh
Esta es una breve descripción de las funciones del script que comprueba que todo esté bien configurado.

- Una vez esten en esa carpeta hay que ejecutar el siguiente comando para que el timer interno los detecte:  
	__sudo systemctl daemon-reload__

- Luego hay que activarlos de la siguiente manera:  
	__sudo systemctl enable gsx-backup.timer__  
	__sudo systemctl start gsx-backup.timer__  

- Finalmente, para poder ver cuando será la siguiente vez que se tiene que ejecutar podemos utilizar el comando:  
	__systemctl list-timers --all__
