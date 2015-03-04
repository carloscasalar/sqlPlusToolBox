SQL*Plus Toolbox
=================
Scripts de utilidad para usar con [SQL*Plus](http://es.wikipedia.org/wiki/SQL*Plus).

# Lista de scripts
Esta es la lista de scripts:

- *ahora.sql*. Te da la fecha del sistema.
- *bloqueos.sql*. Te da la lista de bloqueos.
- *bloqueos2.sql*. Como *bloqueos.sql* pero además te da el tiempo transcurrido desde que comenzó el bloqueo.
- *borrar_tablas.sql*. Genera una salida que es un script para borrar todas las tablas del esquema ordenado por nombre de tabla.
- *campos.sql*. Dada una tabla del esquema genera una salida que podría utilizarse para definir una función que recibiese todos los campos de una fila de la tabla. También los "@param" para el javadoc.
- *cupa_paquete.sql*. Obtiene el código fuente de un paquete de base de datos. La salida de la especificación del paquete la envía a un fichero llamado `<nombre paquete>.s.sql` y el cuerpo a un fichero llamado `<nombre paquete>.b.sql`.
- *chupa_procedimiento.sql*. Obtiene el código fuente de un procedimiento o función de base de datos y envía la salida a un fichero que se llama `<nombre funcion>.sql`.
- *comen-colum.sql*. Dada una tabla, devuelve una salida que puede ser uitlizada para generar los comenterios de una tabla o vista y de sus columnas.
- *compila.sql*. Ejecuta una consulta que pude ser utilizada para compilar los objetos inválidos del esquema.
- *compila3.sql*. Intenta compilar todos los objetos inválidos del esquema.
- *conectados.sql*. Ejecuta una consulta que muestra los usuarios conectados a la base de datos por usuario de base de datos.
- *conectados2.sql*. Ejecuta una consulta que muestra los usuarios conectados a la base de datos por usuario del sistema operativo.
- *conectados3.sql*. Ejecuta una consulta que muestra las sesiones en la base de datos de un usuario de base de datos concreto.
- *conectados4.sql*. Ejecuta una consulta que muestra las sesiones de base de datos agrupadas por usuario de base de datos y usuario del sistema indicando en cada caso el número de sesiones abiertas, la fecha de la conexión más antigua y la de la más nueva.
- *crea_usu.sql*. Script para crear un usuario de base de datos. De la entrada en el blog [Creando un usuario rápido](https://tsoracle.wordpress.com/2004/06/19/creando-un-usuario-rpido/).
- *cursores.sql*. Ejecuta una consulta que muestra los cursores abiertos agrupando por usuario y máquina.
- *cursores2.sql*. Ejecuta una consulta que muestra los cursores abiertos agrupando por usuario y máquina para un usuario en concreto.
- *datafiles.sql*. Lista los datafiles mostrando el espacio ocupado y el libre.
- *ddl-con.sql*. Dada una constraint ejecuta una consulta que muestra el [ddl](http://es.wikipedia.org/wiki/Lenguaje_de_definici%C3%B3n_de_datos) necesario para crearla.
- *ddl-indice.sql*. Dado el nombre de un índice ejecuta una consulta que muestra el [ddl](http://es.wikipedia.org/wiki/Lenguaje_de_definici%C3%B3n_de_datos) necesario para crearlo.
- *ddl-objeto.sql*. Dado un nombre de paquete o procedimiento de base de datos ejecuta una consulta que muestra el [ddl](http://es.wikipedia.org/wiki/Lenguaje_de_definici%C3%B3n_de_datos) necesario para crearlo.
- *ddl-seq.sql*. Dado el nombre de una secuencia ejecuta una consulta que muestra el [ddl](http://es.wikipedia.org/wiki/Lenguaje_de_definici%C3%B3n_de_datos) necesario para crearla.
- *desc.sql*. Describe la tabla cuyo nombre se indique señalando la clave primaria con un asterisco y mostrando una lista de las [FK](http://es.wikipedia.org/wiki/Clave_for%C3%A1nea)s definidas sobre ella. De la entrada [Script de descripción de tablas mejorado](https://tsoracle.wordpress.com/2007/07/21/script-de-descripcion-de-tablas-mejorado/).
