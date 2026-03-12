# Preguntas y respuestas

### Que pasaria si Nginx se rompe a las 3 AM? Quién lo encuentra, como?
Si Nginx se rompe a las 3AM, el service, ya que está configurado con 'Restart=on-failure' se reiniciará para que vuelva a estar activo.
Se enteraria el administrador una vez abra los logs manualmente y los revise.
Para abrir los logs y revisarlo puede utilizar journal -u nginx para ver solamente los de Nginx o simplemente journalctl para ver todos los logs.

### Como testear que un servicio realmente se va a reiniciar automaticamente?
La mejor forma de testearlo es provocando el fallo del servicio y revisar los logs, en caso de Nginx podemos buscar su PDI y matar su proceso, en ese momento revisarmos los logs para ver que está pasando internamente y podremos ejecutar systemctl status nginx para saber si se ha reiniciado.

### Si los backups están fallando silenciosamente, como lo sabrias? Que métricas importan?
Para saber si un backup ha fallado silenciosamente hay que implementar códigos de salida, de manera que si algun comando falla el script deberia devolver un error para que systemd pueda detectar.
Otra foma de detectar si está fallando seria comprobar el tamaño de la copia de seguridad, si suele pesar 100MB y de repente pesa 1KB lo más seguro es que haya fallado.
En este caso importa el tamaño de la copia de seguridad.

### Como explicarias que un servicio ha fallado al equipo de la startup utilizando solamente los logs?
Buscaria el log que indique claramente que ha fallado y se lo mostraria.
