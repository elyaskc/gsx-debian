# Backup Strategy

## De que datos hacer backup
- el directorio /etc que contiene configuraciones del sistema y tambien nuestras configuraciones para la pràctica (/etc/configs). Este directorio es crucial para restaurar el sistema
- el directorio /opt/scripts que contiene scripts y configuraciones de la práctica


## Backup Full | Incremental | Diferencial
Hemos elegido una combinación de Full Backup y Backup Incremental.
- Full Backup que se hará cada domingo, que sirve de base para los backups incrementales de la semana
- Backup Incremental que se hará cada dia de lunes a sábado, que es más rápido y ocupa menos espacio y requiere el full backup para restaurar


## Politica de retencion
Tanto para el full backup como para el incremental, 30 dias es una buena idea. Después de 30 dias los backups se eliminan automaticamente para liberar espacio


# 3-2-1
- 3 copias: Original + backup local + backup remoto
- 2 medios diferentes: Disco principal (/dev/sda) + disco secundario añadido en la VM (/dev/sdb)
- 1 copia off-site: Una segunda VM via NFS (no implementado en esta práctica, solo indicado como documentación)

## RTO Y RPO
- RTO: Un RTO de 24 horas, es decir, la máxima pérdida de datos aceptable es de 24 horas, esto debido a que se realiza un backup diario
- RPO: Un RPO de 2 horas, es decir, el tiempo máximo para restaurar el sistema en caso de fallo es de 2 horas
