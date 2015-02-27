-- Script para obtener la lista de create comments
-- http://www.tsoracle.com
--------------
-- Sets varios
--------------
SET LINES 180
SET PAGES 1000
SET HEADING OFF
SET VERIFY OFF

---------------------
-- Valores de entrada
---------------------
ACCEPT PROPIETARIO PROMPT "Propietario del esquema: "
ACCEPT TABLAOVISTA PROMPT "Nombre de la tabla o vista: "

--------------------------------------
-- Selects para la obtención de datos
-------------------------------------
-- Comentario para la tabla o vista
SELECT 'COMMENT ON TABLE ' || NVL( UPPER( '&&PROPIETARIO'), USER  ) || '.&&TABLAOVISTA ' ||
       ' IS ''''' || CHR(10) ||
       '/'
FROM DUAL
/
-- Comentario para las columnas de la tabla o vista
SELECT 'COMMENT ON COLUMN ' || 
       OWNER       || '.' ||
       TABLE_NAME  || '.' ||
       COLUMN_NAME || 
       ' IS '''    ||
       DECODE( COLUMN_NAME, 
               'VAUDUSUAC', 'Codigo del usuario que creó el registro del registro',
               'VAUDUSUA', 'Codigo del usuario que modifica el registro',
               'VAUDFUNCIONC', 'Función que crea el registro',
               'VAUDFUNCION', 'Función que modifica el registro',
               'DAUDFECHAC', 'Fecha de creación del registro',
               'DAUDFECHA', 'Fecha de la última modificación del registro',
               'VAUDOPER', 'Última operación realizada sobre el registro. I - inserción, U- actualización, D - borrado',
               'VAUDSETRAN', 'Identificador único de la transacción de la última operación sobre el registro',
               NULL ) ||
       ''''    || CHR(10) ||
       '/'
FROM   ALL_TAB_COLS
WHERE  OWNER      = NVL( UPPER( '&&PROPIETARIO' ), USER )
  AND  TABLE_NAME = UPPER( '&&TABLAOVISTA' )
ORDER BY COLUMN_ID
/
----------------------------
-- Restauro heading y verify
----------------------------
SET VERIFY ON 
SET HEADING ON 
set lines 120

