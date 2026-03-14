###Como es matar un proceso usando SIGTERM diferente a usa SGKILL? Cuando se debe utilizar cada uno?

La señal -SIGTERM es una solicitud de terminación, en el cual el proceso la recibe y decide como responder. Puede capturarla, ejecutar código de limpieza (cerrar ficheros, guardar su estado o liberar recursos). Es la forma correcta de parar un proceso
En cambio la señal -SIGKILL es una orden del kernel, donde el proceso no puede capturarla ni ignorarla. El kernel lo mata de inmediato sin dar opción a liberar recursos o hacer limpieza.

La señal -SIGKILL se debe usar cuando el proceso no responde, o para hacer una parada de emergencia. Por otro lado, -SIGTERM se debe usar siempre primero para terminar un proceso o servicio de manera correcta.
 
###Si tu servicio recibe una señal, como debería responder? Debería guardar el estado antes de salirse?

Un servicio bien diseñado, debería responder a las señales de manera controlada:
-SIGTERM - para iniciar una parada graceful
-SIGUSR1/SIGUSR2 - para acciones personalizadas

En nuestro ejemplo del workload.sh, el comportamiento de las señales es el siguiente:
- SIGTERM: los workers terminan de manera graceful y salen
- SIGUSR1: muestra un reporte del estado sin interrumpir la ejecución
- SIGUSR2: reinicia los workers sin parar el proceso principal

El funcionamiento es mediante 2 terminales, una para ejecutar el script y la otra para enviar las señales al PID correspondiente del script.
Hay un bucle infinito donde cada 2 segundos va mostrando los workers y espera a las señales que se le envian

El guardar el estado depende del servicio, por ejemplo un servidor web como nginx no necesita guardar estado, ya que las peticiones se completan o se rechazan. Pero una base de datos si debería guardar el estado, ya que un SIGKILL podría corromper datos.

###Como verificas que un límite de recursos funciona correctamente?

En el script configure-resource-limits-nginx.sh se ve el funcionamiento de modificar el limite de recursos de CPU y Memoria por ejemplo y verificar su nuevo valor.
Primero se debe añadir los parámetros con los valores que se quieren en la configuración de nginx. En nuestro caso CPUQuota=20%, MemoryMax=256M y MemoryHigh=200M
Después se debe reiniciar systemctl con 'sudo systemctl daemon-reload' y reinicar nginx con 'sudo systemctl restart nginx'. 
Una vez reiniciado, para verificar que los límites de cgroups se han aplicado correctamente podemos hacer:
'cat /sys/fs/cgroup/system.slice/nginx.service/cpu.max' para ver el valor màximo de la CPU y lo mismo con la memoria máxima, accediendo a /memory.max en este caso.

También para verificar el uso actual de nginx, podemos ejecutar sudo systemctl status nginx o usar sudo systemctl show nginx | grep -E "CPUQuota|MemoryMax|MemoryHigh"

Y para probar que el límite se cumple bajo carga se puede utilizar la herramienta stress-ng y observar que el proceso no supera el límite configurado 


###Si el trabajo de un desarollador está usando un 90% de CPU, es un problema? Como se decide?

Depende del contexto, si está afectando al rendimiento de servicios críticos o si lleva mucho tiempo sin terminar (proceso zombie o bucle infinito) entonces si es un problema.
Pero si por ejemplo es un proceso de compilación o procesamiento de datos puntual o si es temporal y tiene sentido que consuma muchos recursos puede no ser un problema.

Para decidir, puedes identificar el proceso con top o ver cuanto tiempo lleva ejecutandose con ps -p -o <argumentos de estadisticas> (pid, %cpu,start,time...)

Incluso si los servicios estan degradados, se podría bajar la prioridad de ese proceso con renice antes de hacerle kill, por ejemplo ejecutando 'sudo renice 19'
