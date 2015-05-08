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
- *dif-col.sql*. Script para comparar columnas de dos vistas o tablas.
- *diffila.sql*. Script que al ejecutarlo devuevle un esqueleto de consulta para ver las diferencias entre dos filas de la misma tabla o entre dos.
- *error.sql*. Muestra la fila de código de un objeto de base de datos, algunas filas precedentes y algunas posteriores. Útil para ver errores en un paquete o similar.
- *fk.sql*. Por Sunil Kumar. This script gives the following: 1. The list of all foreign keys of the given table; 2. The list of all foreign keys that references the given table; 3. Self referential integrity constraints.
- *fk2.sql*. Script para obtener la lista de claves foráneas que referencian a una tabla.
- *indices.sql*. Script que lista los índices de una tabla y sus columnas.
- *indices_chungos.sql*. Lista los índices inválidos.
- *informe_con.sql*. Lista las constraints de un esquema de manera ordenada. Útil para detectar diferencias entre esquemas de diferentes entornos.
- *informe_tab.sql*. Lista las tablas de un esquema de manera ordenada. Útil para detectar diferencias entre esquemas de diferentes entornos.
- *login.sql*. Tareas a ejecutar nada más conectarse a la base de datos desde el directorio.
- *permisos.sql*. Otorga permisos sobre todos los objetos del esquema a un usuario o rol.
- *secciones-comunes.sql*. Colección de snippets de código que suelo usar mucho al programar en pl/sql.
- *secuencias.sql*. Lista las secuencias del esquema.
- *sql_ultimos.sql*. Distintos scripts para listar las últimas sentencias ejecutadas en la base de datos. Requiere persisos sobre vistas del sistema.
- *tablas.sql y tablas2.sql*. Listan las tablas del esquema. La 2 admite una máscara para el nombre de las tablas buscadas.
- *trabajos.sql*. Lista los trabajos.
- *trigger.sql*. Lista los triggers definidos sobre una tabla.
- *ultimo_ddl.sql*. Lista la última vez que se modificaron los objetos del esquema.
- *vererror.sql*. Lista los errores de compilación de un objeto.
- *vistas.sql*. Lista las vistas del esquema.

