# Decisiones de diseño de nuestra Infraestructura

## 1. ¿Por qué hemos escogido SSH para el acceso remoto?

SSH (Secure Shell) es el estándar para administración remota de servidores Linux.

Hemos elegido SSH sobre otras alternativas por las siguientes razones:

- **Cifrado extremo a extremo** — toda la comunicación entre el cliente y el servidor está cifrada, incluyendo contraseñas y comandos
- **Ampliamente soportado** — disponible en todos los sistemas operativos modernos
- **Autenticación por clave** — más segura que contraseñas, eliminando el riesgo de ataques de fuerza bruta
- **Alternativas descartadas:**
  - Telnet — no cifra la comunicación, obsoleto e inseguro
  - VNC/RDP — diseñados para acceso gráfico, innecesario para administración de servidor

 ## 2. ¿Por qué es mejor la autenticación por clave SSH en vez de usar contraseñas?

Hemos configurado la autenticación por clave SSH (usando el algoritmo de cifrado ed25519) en lugar de contraseñas por las 
siguientes razones:

- **Resistencia a fuerza bruta** — una clave ed25519 es matemáticamente imposible de adivinar por fuerza bruta
- **Sin riesgo de contraseñas débiles** — las contraseñas pueden ser adivinadas, reutilizadas o filtradas
- **Comodidad** — una vez configurada la clave, no es necesario introducir contraseña en cada conexión

También hemos elegido usar el algoritmo ed25519 en vez de RSA por las siguientes razones:

- **Es más seguro** — ed25519 usa criptografía de curva elíptica, más robusta que RSA
- **Las claves son más cortas** — una clave ed25519 ofrece mayor seguridad con menor tamaño
- **Es más rápido** — las operaciones criptográficas son más eficientes que RSA

## 3. ¿Por qué hay que automatizar los scripts?

Toda la configuración del sistema la hemos automatizado mediante scripts bash por las siguientes razones:

- **Idempotencia** — los scripts pueden ejecutarse múltiples veces produciendo siempre el mismo resultado
- **Reproducibilidad** — si el sistema falla, toda la configuración puede restaurarse ejecutando los scripts en orden
- **Colaboración** — los miembros del equipo pueden replicar exactamente la misma configuración en sus VMs

El orden de ejecución de los scripts es:
```
1. install-packages.sh   # Primero instalar dependencias
2. configure-ssh.sh      # Configurar acceso remoto
3. setup-dirs.sh         # Crear estructura de directorios
4. verify.sh             # Verificar que todo está correcto
```

## 4. Estructura de Directorios

La estructura de directorios que hemos elegido se divide en:
- `/opt` como directorio para scripts
- `/etc` para configuraciones
- `/var` para el backup
- `/documentation` para la documentación semanal de la práctica

Esta estructura se debe a:
- **Convención Linux** — `/opt` está reservado para software adicional no gestionado por el gestor de paquetes
- **Separación clara** — mantiene los scripts y configuraciones de administración separados del sistema base
- **Permisos** — solo el usuario `gsx` tiene acceso (`chmod 750`), siguiendo el principio de mínimo privilegio

## 5. ¿Qué información debe estar en Git y qué solo en el servidor?

En Git:

| Qué | Por qué |
|-----|---------|
| Scripts de setup | Permiten reproducir la configuración |
| Archivos de configuración (sshd_config, etc.) | Documentan el estado del sistema |
| Documentación | Debe ser accesible para todo el equipo |
| Systemd unit files | Forman parte de la infraestructura |

Solo en el servidor:

| Qué | Por qué |
|-----|---------|
| Claves SSH privadas (`id_ed25519`) | Si se filtran, comprometen la seguridad del servidor |
| Contraseñas | Nunca deben estar en un repositorio |
| Archivos de backup | Son grandes y contienen datos sensibles |
| Logs | Cambian constantemente y no aportan valor en Git |
| `/etc/shadow` | Contiene hashes de contraseñas |

Regla general:
- Si el archivo contiene **secretos** o **datos sensibles**, no va en Git.
- Si el archivo permite **reproducir o entender** la infraestructura, va en Git.

