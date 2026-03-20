# Storage Layout

## Disposicion almacenamiento

### Disco principal (sda - 20GB)
Particion   Tamaño   Uso
/dev/sda1    20GB    S.O, aplicaciones...

### Disco añadido para backup (sdb - 10GB)
Particion   Punto de montaje   Tamaño   Uso
/dev/sdb1    /mnt/backup        10GB    Backups diarios


## Elección del Sistema de ficheros
Hemos elegido usar el sistema de ficheros ext4 por lo siguiente:
- Es el estandar para Linux, por tanto es ampliamente soportado en Debian
- Por el journaling, ya que protege de la corrupción de datos en caso de fallo
- Hemos descartado XFS por ejemplo, ya que el uso que se le da no exige archivos grandes
- Tiene buen rendimiento y es fiable

## El montaje persistente
El disco lo hemos montado por UUID en vez de por nombres de dispositivo (mala praxis), ya que el nombre de los dispositivos puede cambiar por diversas razones, en cambio el UUID no cambia y es único
