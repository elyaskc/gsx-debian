# GSX Debian Configuration

## Resumen
Este repositorio contiene toda la estructura de archivos y scripts de configuración para configurar un sistema operativo Linux (Ubunto en este caso) como administrador de este.
Se divide en 3 carpetas principales, cada una cumple un rol diferente:
- /config: Contiene archivos de configuración que han sido creados para, posteriormente, copiarlos a otra carpeta del sistema administrada por el kernel.
- /documentation: Contiene la documentación de las tareas llevadas a cabo, junto a la respuesta a ciertas preguntas. Están separados por semanas.
- /scripts: Contiene los scripts, que son la base sobre la que están las otras dos carpetas. Se ha intentado en todos ellos que sean idempotentes y que utilicen el principio de privilegio mínimo. También están separados por semanas.

## Configuración global
En general, se han hecho las siguientes configuraciones:
- Crear directorios de trabajo.
- Instalar y configurar SSH y las actualizaciones de seguridad automáticas.
- Un timer para hacer un backup cada dia.
- Un script para poder ver los logs de cualquier servicio.
- Scripts para monitorizar procesos.
- Demostrar manejo de signals.
- Crear directorios de trabajo del grupo Greendevcorp.
- Crear usuarios y asignarlos a su grupo correspondiente.
- Crear alias y modificar el path.
- Asignar límites a los miembros del grupo Greendevcorp.
- Crear nuevo disco particionado.
- Script de backup programado.
- Comprobar que todos los scripts sean funcionales mediante un test.
