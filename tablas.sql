COLUMN COMMENTS FORMAT A70
column table_name format a20
SELECT T.TABLE_NAME, C.COMMENTS
FROM USER_TABLES T, USER_TAB_COMMENTS C
WHERE T.TABLE_NAME=C.TABLE_NAME
ORDER BY TABLE_NAME
/
