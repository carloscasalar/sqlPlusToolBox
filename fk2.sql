-- Script para obtener la lista de claves foráneas que 
-- referencian a una tabla
-- http://www.tsoracle.com
---------------
-- Sets varios
--------------
SET VERIFY OFF
------------
-- Parámetros
------------
ACCEPT propi PROMPT "Propietario: "
ACCEPT tabla PROMPT "Nombre de la tabla: "
BREAK ON TABLE_NAME
------------
-- Select
------------
PROMPT Tablas que referencian a &&tabla
SELECT R.TABLE_NAME, R.CONSTRAINT_NAME,
       T.CONSTRAINT_NAME AS CLAVE_REFERENCIADA
FROM   ALL_CONSTRAINTS T, ALL_CONSTRAINTS R
WHERE  T.OWNER      = NVL( UPPER( '&&propi' ), USER )
  AND  T.TABLE_NAME = UPPER( '&&tabla' )
  AND  T.CONSTRAINT_TYPE IN ( 'P', 'U' ) -- Que sean pk o uk
  AND  R.R_OWNER           = T.OWNER
  AND  R.R_CONSTRAINT_NAME = T.CONSTRAINT_NAME
  AND  R.CONSTRAINT_TYPE   = 'R'         -- Que sea una fk
ORDER BY R.TABLE_NAME, R.CONSTRAINT_NAME
/
---------------------
-- Restauro el verify
---------------------
SET VERIFY ON

