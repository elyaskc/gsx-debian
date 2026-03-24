# Manual de recuperación de desastres

## Cuando usar este manual?
- Si el servidor no arranca
- Pérdida de datos accidental
- Corrupción del Sistema de Ficheros
- Fallo en el disco principal

# Pasos a seguir

## Paso 1 - Evaluar el daño
- Verificar el estado del sistema: `systemctl status`
- Verificar los discos: 
    - `lsblk` 
    - `df -h`
- Verificar logs de errores: `journalctl -p err -n 50`

## Paso 2 - Localizar el ultimo backup
- Ver backups disponibles: `ls -lht /mnt/backup/`
- Ver logs de backups: `cat /var/log/admin/backup.log`

2 tipos de backup:
- Full Backup mas reciente -> "full_TIMESTAMP.tar.gz"
- Backups incrementales (de lunes a sábado) -> "incremental_TIMESTAMP.tar.gz"

## Paso 3 - Restaurar los datos
- Restaurar full backup: `sudo tar -xzpf /mnt/backup/full_TIMESTAMP.tar.gz -C /"
- Restaurar backups incrementales: `sudo tar -xzpf /mnt/backup/incremental_TIMESTAMP.tar.gz -C /"

Restaurar a ubicación alternativa para verificar:
- `sudo mkdir -p /tmp/restore-test` 
- `sudo tar -xzpf /mnt/backup/full_TIMESTAMP.tar.gz -C /tmp/restore-test`

## Paso 4 - Verificar que se han restaurado los datos
- Verificar que los archivos estan presentes:
   - `ls /etc` 
   - `ls /home/gsx/Prac1/gsx-debian`
- Verificar servicios críticos: 
   - `systemctl status ssh`
   - `systemctl nginx`
   - `systemctl status backup.timer`
   - Ejecutar el script de verificacion de backup: `./verify-backup.sh` en la ruta /home/gsx/Prac1/gsx-debian/scripts/week5/verify-backup.sh

## Paso 5 - Restaurar servicios
- Recargar systemd: `sudo systemctl daemon-reload`
- Reiniciar servicios críticos: 
   - `sudo systemctl restart ssh`
   - `sudo systemctl restart nginx`
   - `sudo systemctl start backup.timer`
