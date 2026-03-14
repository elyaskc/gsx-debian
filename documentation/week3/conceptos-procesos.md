##Explicación de algunos conceptos de los procesos en Linux

###1. Que es un proceso

Un proceso es un programa en ejecución. Cuando se ejecuta un comando en la terminal, el S.O crea un proceso compuesto por:
- PID: identificador único de ese proceso
- PPID: PID del proceso que lo creó (su padre)
- UID: el usuario propietario de ese proceso
- Estado: la fase de ejecución en la que se encuentra el proceso

###2. Los diferentes estados de un proceso

Hay 4 tipos de estados:

- Running: indicado con 'R' y significa que está usando la CPU de manera activa
- Sleeping: indicado con 'S' y significa que está en espera de algún evento
- Zombie: indicado con 'Z' y significa que está terminado pero su proceso padre no lo ha limpiado
- Stopped: indicado con 'T' y significa que está pausado

###3. Árbol de procesos

En Linux, todos los procesos tienen un padre. El proceso raíz es systemd (PID 1) y todos los demás cuelgan de él.
Se puede ver el árbol ejecutando 'pstree -p' en la terminal

###4. Comandos de procesos

- ps aux: ver todos los procesos
- ps aux --sort=-%cpu: ordenar los procesos por CPU
- ps -p -o pid,user,%cpu,%mem,cmd: ver un proceso específico
- top: monitoreo básico de procesos
- htop: monitoreo más visual

También está el directorio /proc, el cual contiene información de todos los procesos en tiempo real:
- /proc//status
- /proc//fd
...

###5. Las señales

Las señales son notificaciones que el S.O envía a los procesos:

- SIGTERM: Solicitud de terminación
- SIGKILL: Terminación forzada
- SIGUSR1: señal definida por la aplicación
- SIGUSR2: señal definida por la aplicación
- SIGINT: Interrupción
- SIGHUP: Recargar configuración

Para enviar las señales, se usa el comando kill:

- kill -SIGTERM
- kil -SIGKILL
...

###6. Las prioridades de los procesos

El valor nice controla la prioridad de un proceso. Va de -20 (máxima prioridad) a 19 (mínima prioridad). Por defecto nice vale 0.
Ejecutando 'nice -n 19 <proceso>' le das baja prioridad y con 'sudo renice 19' le cambias la prioridad en ejecución
Con ps aux -o pid,ni,cmd podemos ver la prioridad de todos los procesos. 
