# Decisiones de diseño de nuestra Infraestructura

## 1. Por qué hemos escogido SSH para el acceso remoto?

SSH (Secure Shell) es el estándar para administración remota de servidores Linux.

Hemos elegido SSH sobre otras alternativas por las siguientes razones:

- Toda la comunicación entre el cliente y el servidor está cifrada, incluyendo contraseñas y comandos
- Admite autenticación por clave, que es más segura que contraseñas, eliminando el riesgo de ataques de fuerza bruta
- Hay otras alternativas como Telnet que no cifra la comunicación y es menos segura

## 2. Por qué es mejor la autenticación por clave SSH en vez de usar contraseñas?

Hemos configurado la autenticación por clave SSH usando claves ed25519 en lugar de contraseñas por las 
siguientes razones:

- Una clave ed25519 es matemáticamente imposible de adivinar por fuerza bruta
- Las contraseñas pueden ser adivinadas, reutilizadas o filtradas, la clave ed25519 no
- Una vez configurada la clave, no es necesario introducir contraseña en cada conexión

También hemos elegido usar el algoritmo ed25519 en vez de RSA por las siguientes razones:

- La clave ed25519 usa criptografía de curva elíptica, más robusta que RSA
- Una clave ed25519 ofrece mayor seguridad con menor tamaño

## 3. Por qué hay que automatizar los scripts?

Toda la configuración del sistema la hemos automatizado mediante scripts bash por las siguientes razones:

- Los scripts idempotentes pueden ejecutarse múltiples veces produciendo siempre el mismo resultado
- Si el sistema falla, toda la configuración puede restaurarse ejecutando los scripts en orden
- Los miembros del equipo pueden replicar exactamente la misma configuración en sus VMs

El orden de ejecución de los scripts es:
```
1. setup-dirs.sh				# Crear estructura de directorios
2. install_SSH.sh				# Instala y configura SSH para permitir el acceso remoto
3. install_automatic_security_updates.sh	# Instala y configura unattended-upgrades
4. verify.sh 					# Verifica que todo esté instalado y configurado correctamente
						# en caso contrario, lo instala y configura
```

## 4. Estructura de Directorios

La estructura de directorios que hemos elegido se divide en:
- `/opt/scripts` como directorio para scripts
- `/etc/configs` para configuraciones
- `/var/backup` para copias de seguridad futuras
- `/documentation` para la documentación semanal de la práctica

Esta estructura se debe a:
- Es la estructura requerida al enunciado de la práctica
- El directorio `/opt` se utiliza en los sistemas para guardar software extra u opcional, perfecto para scripts
- El directorio `/etc` se utiliza para los archivos que definen el comportamiento del sistema, archivos de configuración
- El directorio `/var` se utiliza para guardar datos variables, por ejemplo, copias de seguridad
- Mantener los scripts y configuraciones de administración separados del sistema base
- Solo el usuario `gsx` tiene acceso, siguiendo el principio de mínimo privilegio

## 5. ¿Qué información debe estar en Git y qué solo en el servidor?

En Git:

- Scripts de setup ya que permiten reproducir la configuración
- Documentación para que pueda ser accesible para todo el equipo
- Archivos de configuración ya que permiten recuperar estados anteriores gracias al control de versiones

Solo en el servidor:

- Las claves SSH privadas (`id_ed25519`) si se filtran comprometen la seguridad del servidor
- Las contraseñas nunca deben estar en un repositorio
- Archivos de backup ya que son grandes y contienen datos sensibles
- Logs porque cambian constantemente y no aportan valor en Git
