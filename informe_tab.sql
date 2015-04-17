SET LINES  100
SET PAGES  20000
SET HEADING ON
SET VERIFY OFF
-------------------------
-- Definición de columnas
-------------------------
COLUMN TABLE_NAME     FORMAT A20
COLUMN CLAVE_PRIMARIA FORMAT A1
COLUMN COLUMN_NAME    FORMAT A20
COLUMN TIPO           FORMAT A15
COLUMN DEFECTO        FORMAT A15

----------
-- Selects
----------
BREAK ON TABLE_NAME
SELECT M.TABLE_NAME,
       P.PK CLAVE_PRIMARIA,
       M.COLUMN_NAME, 
       M.DATA_TYPE || DECODE( M.DATA_TYPE, 
                              /*************************************/
                              'DATE', NULL, -- Poner aquí los tipos
                              'LONG', NULL, -- de varible para los 
                              'BLOB', NULL, -- que no queramos ver
                              'CLOB', NULL, -- la precisión
                              'XMLTYPE', NULL, 
                              /*************************************/
                              '(' || TO_CHAR( NVL( M.DATA_PRECISION, 
                                                   M.DATA_LENGTH))||
                              DECODE( M.DATA_SCALE, NULL, NULL, 
                                      ',' ||
                                      TO_CHAR( M.DATA_SCALE ) ) ||
                              ')' ) TIPO,
       M.NULLABLE,
       M.DATA_DEFAULT DEFECTO
FROM   ( SELECT N.TABLE_NAME, L.COLUMN_NAME, '*' PK
         FROM   USER_CONS_COLUMNS L, USER_CONSTRAINTS N
         WHERE  L.CONSTRAINT_NAME = N.CONSTRAINT_NAME
           AND  N.CONSTRAINT_TYPE = 'P' ) P, -- Clave primaria
       USER_TAB_COLUMNS M
WHERE  M.TABLE_NAME  = P.TABLE_NAME  (+)
  AND  M.COLUMN_NAME = P.COLUMN_NAME (+)
ORDER BY M.TABLE_NAME, decode( P.PK, '*', 1, 2), M.COLUMN_NAME 
/

SELECT * 
FROM USER_SEQUENCES
ORDER BY SEQUENCE_NAME
/