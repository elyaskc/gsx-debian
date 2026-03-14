###El servidor se siente lento. Que se debe revisar?

Lo primero es identificar que está consumiendo recursos. Se puede hacer mediante un script, en nuestro caso el script top-resources.sh o manualmente.
De manera manual podemos ver los procesos que más CPU o Memoria esten usando con: 'ps aux --sort=-%cpu' o 'ps aux --sort=-%mem'
También se puede ejecutar htop para monitorear en tiempo real.
Haciendo esto, buscamos procesos con CPU muy alta de forma sostenida, muchos procesos zombies o consumiendo mucha memoria.

El siguiente paso serñia verificar el estado de servicios críticos usando 'systemctl status' o 'systemctl --failed' para ver los servicios fallidos.

Después, una vez analizado las métricas, debemos tomar acciones. Si el proceso funciona pero consume demasiado, podemos probar a bajarle prioridad con 'renice', y si por otro lado el proceso no responde, podemos hacerle kill, primero con -SIGTERM y si sigue vivo, usar -SIGKILL.

Si por ejemplo, lo que falla es un servicio systemd, podemos ver sus logs con 'journalctl' y reiniciar el servicio con 'systemctl restart'.

Por último, debemos verificar que el problema está resuelto. Para eso volvemos a ver el uso de recursos y verificar el estado de servicios críticos con 'systemctl status'. También podemos comprobar logs por errores recientes con 'journalctl -p -err'
