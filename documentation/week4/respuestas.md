- Si un archivo en el directorio compartido tiene a dev1 como dueño pero necesita ser legible por todos los miembros del equipo, que permisos le darias? Por qué?
	Suponiendo que solo de dev1 puede leerlo, modificarlo y ejecutarlo, los miembros del equipo solo leerlo y el resto nada.
	Tendriamos que usar los siguientes permisos:
	**740**
	7 = rwx = read-write-execute = 4 + 2 + 1

- Cual es la diferencia entre el setgid en un directorio y en un archivo? Cuando se usa cada uno?
	En un directorio, cualquier archivo nuevo creado en este formará parte de su grupo.
	Podria ser util si aginamos permisos a un grupo en un directorio y queremos que todos los nuevos ficheros tengan esos permisos.
	
	En un archivo, al ejecutarlo se ejecutará con los permisos del dueño y no del que lo ejecuta.
	Seria util si el script hace algo que esta prohibido para el usuario, pero que deberia poder hacer, como modificar un archivo privado.

- Si se pierde la configuración de permisos y un usuario no puede acceder al archivo que necesita? Como harias troubleshooting?
	Comprobar los permisos, dueño y grupos del archivo
	Comprobar si el usuario pertenece al grupo que deberia
	Comprobar que tiene permiso de acceso a las carpetas padre

- Como comprobarias que tu modelo de permisos realmente cumple la politica de seguridad?
	Lo ideal seria probar sobrepasar esos permisos y asegurarse de no poder hacerlo. La mejor manera es suplantar la identidad del usuario y probar.
