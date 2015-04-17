COLUMN COMMENTS FORMAT A99
COLUMN TABLE_NAME FORMAT A20
SET VERIFY OFF
SELECT T.TABLE_NAME, C.COMMENTS
FROM USER_TABLES T, USER_TAB_COMMENTS C
WHERE T.TABLE_NAME=C.TABLE_NAME AND C.TABLE_NAME LIKE UPPER('%&nombretabla%')
ORDER BY TABLE_NAME
/
SET VERIFY ON
