SET VERIFY OFF 
column fuente format a87
ACCEPT nombre_objeto prompt "Nombre del objeto: "
ACCEPT tipo_objeto   prompt "Tipo objeto (1 pack b., 2 pack s., 3 pbd, 4 fbd): "
ACCEPT num_linea     prompt "Número de línea: "
SELECT DECODE( LINE, &&num_linea, '*', NULL) "LOC.", TEXT fuente
FROM   USER_SOURCE
WHERE  NAME = UPPER( '&nombre_objeto' )
  AND  TYPE = DECODE( NVL( '&tipo_objeto', '1'), 
                      '1', 'PACKAGE BODY',
                      '2', 'PACKAGE',
                      '3', 'PROCEDURE',
                      '4', 'FUNCTION',
                      'PACKAGE BODY' )
  AND  LINE BETWEEN (&&num_linea - 5) AND (&&num_linea + 5)
ORDER BY LINE ASC
/ 
