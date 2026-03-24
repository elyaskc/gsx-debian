# Tareas comunes:

### Como añadir un nuevo desarrollador al equipo?
- Ejecutar el script create-group-users.sh pasandole por parámetro el nombre del nuevo o nuevos desarrolladores.
### Como manejar la baja de un miembro?
- Avisar al usuario, bloquear el acceso, hacer una copia de seguridad, reasignar sus archivos compartidos, eliminar el usuario.
### Como comprobar si los servicios estan corriendo?
- Ejecutar el comando sudo systemctl status servicio*
### Como diagnosticar fallos si el sistema va lento?
- Se pueden utilizar los scripts del directorio /week3/monitoring para comprobar consumos
### Como nos recuperamos de un backup?
- ...


# Guía de Trobleshooting

### El servidor web Nginx no responde
1. Comprobar el estado del servicio con systemctl status nginx
2. Leer los logs con journalctl -u nginx -n 50
3. Reiniciar el servicio con sudo systemctl restart nginx

### El sistema va muy lento
1. Ejecutar top para identificar el proceso que consume demasiado y el usuario que lo ejecuta
2. Bajarle la prioridad con renice +10 *PID*
3. Si es un proceso huérfano o bloqueado, detenerlo con SIGTERM (kill -15 *PID*). Si no responde forzar su detención con SIGKILL (kill -9 *PID*).

### Un desarrollador no tiene permiso para escribir en la carpeta shared
1. Comprobar que pertenezca al grupo greendevcorp con id *usuario*
2. Si no pertenece añadirlo al grupo
3. Comprobar las carpetas padre por si no tiene permiso en ellas

### Las copias de seguridad automáticas no funcionan
1. Comprobar cuándo se ejecutó por última vez con systemctl list-timers | grep backup
2. Revisar los logs del servicio de backup con journalctl -u backup.service
3. Comprobar que haya espacio suficiente en el sistema, si no, eliminar copias antiguas de acuerdo con la política de retención


# Procedimiento de escalado

### Cuando pedir ayuda
- Pérdida de datos que no se puede recuperar con el útimo backup
- Caída prolongada de servicios críticos
- Brecha de seguridad, alguien ha conseguido escalar privilegios sin autorización
- Fallo de hardware

### A quién pedir ayuda
- Para problemas de código contactar con el Desarrollador Principal
- Para problemas de infraestructura, brechas de seguridad o pérdida de datos contactar con el Senion Operations Engineer o con el CTO.
