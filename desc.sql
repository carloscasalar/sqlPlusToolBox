--------------
-- Sección Set
--------------
SET LINES  150
SET HEADING ON
SET VERIFY OFF
-------------------------
-- Definición de columnas
-------------------------
COLUMN CLAVE_PRIMARIA FORMAT A1
COLUMN COLUMN_NAME    FORMAT A20
COLUMN TIPO           FORMAT A15
COLUMN DEFECTO        FORMAT A15
COLUMN COMENTARIO     FORMAT A53
COLUMN COMMENTS       FORMAT A69
COLUMN TABLA_FORANEA  FORMAT A40
COLUMN TABLE_NAME     FORMAT A30
COLUMN COMMENTS       FORMAT A70
-------------
-- Parámetros
-------------
ACCEPT tabla PROMPT "Escribe el nombre de la tabla: "
PROMPT .
----------------------------------
-- Ver si es un sinónimo de tabla
---------------------------------
var owner varchar2(30)
var tabla varchar2(30)
DECLARE

BEGIN
  -- Veo si es un sinónimo lo que me están pidiendo
  SELECT TABLE_OWNER, TABLE_NAME
  INTO   :owner,      :tabla
  FROM   USER_SYNONYMS
  WHERE  SYNONYM_NAME = UPPER( '&&tabla' );
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- No es un sinónimo
    :owner := USER;
    :tabla := UPPER( '&&tabla' );
END;
/
----------
-- Selects
----------
SELECT DECODE( OWNER, USER, NULL, OWNER || '.' ) || TABLE_NAME AS TABLE_NAME, COMMENTS
FROM   ALL_TAB_COMMENTS
WHERE  OWNER      = :owner
  AND  TABLE_NAME = :tabla
/
SELECT P.PK CLAVE_PRIMARIA,
       M.COLUMN_NAME,
       M.DATA_TYPE || DECODE( M.DATA_TYPE,
                              /*************************************/
                              'DATE', NULL, -- Poner aquí los tipos
                              'LONG', NULL, -- de varible para los
                              'BLOB', NULL, -- que no queramos ver
                              'CLOB', NULL, -- la precisión
                              /*************************************/
                              '(' || TO_CHAR( NVL( M.DATA_PRECISION,
                                                   M.DATA_LENGTH))||
                              DECODE( M.DATA_SCALE, NULL, NULL,
                                      ',' ||
                                      TO_CHAR( M.DATA_SCALE ) ) ||
                              ')' ) TIPO,
       M.NULLABLE,
       M.DATA_DEFAULT DEFECTO,
       C.COMMENTS COMENTARIO
FROM   ( SELECT N.TABLE_NAME, L.COLUMN_NAME, '*' PK
         FROM   ALL_CONS_COLUMNS L, ALL_CONSTRAINTS N
         WHERE  L.CONSTRAINT_NAME = N.CONSTRAINT_NAME
           AND  L.OWNER      = :owner
           AND  N.OWNER      = :owner
           AND  N.TABLE_NAME = :tabla
           AND  N.CONSTRAINT_TYPE = 'P' ) P, -- Clave primaria
       ALL_TAB_COLUMNS M, ALL_COL_COMMENTS C
WHERE  M.TABLE_NAME  = C.TABLE_NAME
  AND  M.COLUMN_NAME = C.COLUMN_NAME
  AND  M.OWNER       = C.OWNER
  AND  M.TABLE_NAME  = P.TABLE_NAME  (+)
  AND  M.COLUMN_NAME = P.COLUMN_NAME (+)
  AND  M.TABLE_NAME  = :tabla
  AND  M.OWNER       = :owner
ORDER BY M.COLUMN_ID
/
PROMPT CLAVES FORÁNEAS:
BREAK ON TABLA_FORANEA
SELECT DECODE( B.OWNER, :owner, NULL, B.OWNER || '.' ) ||
       B.TABLE_NAME TABLA_FORANEA,
       C.COLUMN_NAME, C.CONSTRAINT_NAME
FROM   ALL_CONS_COLUMNS C, ALL_CONSTRAINTS A, ALL_CONSTRAINTS B
WHERE  A.R_CONSTRAINT_NAME = B.CONSTRAINT_NAME
  AND  A.R_OWNER           = B.OWNER
  AND  A.CONSTRAINT_NAME   = C.CONSTRAINT_NAME
  AND  A.OWNER             = C.OWNER
  AND  A.TABLE_NAME        = :tabla
  AND  A.OWNER             = :owner
  AND  A.CONSTRAINT_TYPE   = 'R'
ORDER BY B.TABLE_NAME, C.POSITION
/
SET VERIFY ON

