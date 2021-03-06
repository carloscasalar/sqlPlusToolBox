spool off
SET PAGES 10000
SET LINES 110
SET HEADING OFF
ACCEPT rol prompt "Rol al que quieres darle todos los permisos: "
prompt GENERANDO SPOOL DE PERMISOS DE OBJETOS DEL ESQUEMA ACTUAL A LOS USUARIOS
spool per_objetos.sql
PROMPT GENERANDO SPOOL DE PERMISOS SOBRE PAQUETES, FUNCIONES Y PROCEDIMIENTOS
SELECT 'GRANT ' ||
       DECODE( OBJECT_TYPE, 
               'FUNCTION', 'EXECUTE',
               'PROCEDURE','EXECUTE',
               'PACKAGE',  'EXECUTE',
               'SEQUENCE', 'SELECT',
               'TABLE',    'SELECT, INSERT, UPDATE, DELETE',
               'VIEW',     'SELECT',
               'PERMISO NO PREVISTO')  ||
       ' ON ' || OBJECT_NAME || ' TO ' || UPPER( '&&rol' ) || CHR(10) || '/'
FROM USER_OBJECTS
WHERE OBJECT_TYPE IN ('TABLE','VIEW','FUNCTION','PACKAGE','PROCEDURE','SEQUENCE')
ORDER BY OBJECT_TYPE, OBJECT_NAME
/
SPOOL OFF
SET heading on
PROMPT EJECUTANDO PERMISOS
@per_objetos.sql 
