# Preguntas y respuestas

### Cuales son las implicaciones de seguridad al usar contraseñas vs claves en SSH?
Las contraseñas son vulnerables a los ataques de fuerza bruta, las claves son imposibles de descifrar mediante fuerza bruta ya que usan un algoritmo de criptografia de clave pública.

### Si debes reinstalar el sistema, pueden tus scripts restaurar la configuración? Si no pueden, que falta?
Los script pueden restaurar la mayoria de la configuración perdida, pero hay ciertas cosas que no se pueden recuperar, como la clave SSH o las copias de seguridad.

### Como prevendrias que ambos miembros del equipo ejecuten el mismo script de setup al mismo tiempo?
La forma ideal de hacerlo seria utilizando semáforos, un semáforo es un sistema que solo permite a un usuario ejecutar un script en un momento determinado, y hasta que el script no acaba, no deja a otro ejecutarlo.

### Que información debe estar en Git, y cual deberia estar solamente en el servidor? Por qué?
En Git van los scripts, archivos de configuración y documentación, ya que son cosas que no suponen ninguna brecha de seguridad y ambos miembros del equipo los podemos tener disponibles para consultarlos o modificarlos cuando sea conveniente.
En el servidor deben estar las claves privadas, como la clave SSH ya que si alguien consigue acceso a Git no podrá acceder al sistema porque no tendrá los remedios suficientes.
