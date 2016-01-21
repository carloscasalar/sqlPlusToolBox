-- Busca tablas con una columna de más longitud de la indicada

SET VERIFY OFF

ACCEPT Precision PROMPT "Buscar columnas de precisión mayor o igual que: "
ACCEPT Tipo PROMPT "Buscar columnas de tipo (cualquiera): "

COLUMN TABLE_NAME FORMAT A30
COLUMN DATA_TYPE FORMAT A15
COLUMN COLUMN_NAME A30

SELECT M.TABLE_NAME, M.COLUMN_NAME,
       M.DATA_TYPE,
       M.DATA_PRECISION,
       M.DATA_SCALE,
       M.DATA_LENGTH
FROM   ALL_TAB_COLUMNS M
WHERE  M.OWNER = USER
  AND  ('&&Tipo' IS NULL OR M.DATA_TYPE LIKE '&&Tipo')
  AND  M.DATA_LENGTH >= &&Precision
  AND  NOT EXISTS(
        SELECT 'X'
        FROM   USER_VIEWS
        WHERE  VIEW_NAME = M.TABLE_NAME
       )
/

SET VERIFY ON
