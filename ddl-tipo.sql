SET LONG 5000
SELECT DBMS_METADATA.get_DDL( OBJECT_TYPE, OBJECT_NAME, USER )
FROM USER_OBJECTS
WHERE OBJECT_TYPE = UPPER('&MASCARA')
/
