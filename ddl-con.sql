SET LONG 5000
SELECT DBMS_METADATA.get_DDL( 'CONSTRAINT', CONSTRAINT_NAME, USER )
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_TYPE = UPPER('&tipo_cons')
ORDER BY TABLE_NAME, CONSTRAINT_NAME
/