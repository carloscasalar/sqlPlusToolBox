-- Crea_usu_rec
-- http://www.tsoracle.com
-- Crea un usuario con permiso para crear paquetesl, triggers y tabas
-- Primero muestro los tablespaces
SET VERIFY OFF
COLUMN "MB libres" FORMAT 999,999,990.00
SELECT T.TABLESPACE_NAME, T.STATUS, E.LIBRE "MB libres", T.CONTENTS
FROM   ( SELECT TABLESPACE_NAME, ROUND( SUM( BYTES )/1024/1024, 2 ) LIBRE
         FROM   DBA_FREE_SPACE
         GROUP BY TABLESPACE_NAME ) E,
       DBA_TABLESPACES T
WHERE  T.TABLESPACE_NAME = E.TABLESPACE_NAME (+) -- outer para los temporales
ORDER  BY T.CONTENTS, T.TABLESPACE_NAME
/
-- Pedimos el nombre del usuario, el tablespace de datos, su cuota y el
-- tablespace temporal
ACCEPT usuario       PROMPT "Nuevo usuario: "
ACCEPT contrasena    PROMPT "Contraseña: "
ACCEPT tab_dat       PROMPT "Tablespace de datos: "
ACCEPT tab_cuo       PROMPT "Cuota en el tablespace de datos (UNLIMITED o cantidad): "
ACCEPT tab_tmp       PROMPT "Tablespace temporal: "
CREATE USER &&usuario 
IDENTIFIED BY &&contrasena 
DEFAULT TABLESPACE &&tab_dat
TEMPORARY TABLESPACE &&tab_tmp
QUOTA &&tab_cuo ON &&tab_dat
/
-- Ahora mostramos los roles del sistema.
SELECT * 
FROM   DBA_ROLES
/
ACCEPT permisos PROMPT "Roles y permisos separados por comas: "
GRANT &&permisos TO &&usuario
/
