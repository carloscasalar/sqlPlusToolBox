SET LONG 5000
SET VERIFY OFF
ACCEPT objeto PROMPT "Nombre del objeto(índice): "
ACCEPT owner  PROMPT "Propietario (enter para usuario conectado):"
SELECT DBMS_METADATA.get_DDL( 'INDEX', UPPER('&&objeto'), 
       NVL( UPPER( '&&owner' ), USER ) )
FROM dual 
/
SET VERIFY ON
