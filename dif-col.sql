-- Script para comparar columnas de dos vistas o tablas.
--------------
-- Sets varios
--------------
SET SERVEROUTPUT ON 
SET VERIFY OFF
---------------------
-- Valores de entrada
---------------------
ACCEPT PROPIETARIO1 PROMPT "Propietario del esquema 1: "
ACCEPT TABLAOVISTA1 PROMPT "Nombre de la tabla o vista 1: "
ACCEPT PROPIETARIO2 PROMPT "Propietario del esquema 2: "
ACCEPT TABLAOVISTA2 PROMPT "Nombre de la tabla o vista 2: "
DECLARE
  
  --------------------
  -- Tipos de Variable
  --------------------
  -- Tipo para diferencias unitarias
  TYPE tDiferencia IS RECORD (
    vColumna ALL_TAB_COLS.COLUMN_NAME%TYPE,
    vValorA  VARCHAR2(200),
    vValorB  VARCHAR2(200) );

  -- Tipo para conjuntos de diferencias
  TYPE tDiferencias IS TABLE OF tDiferencia INDEX BY BINARY_INTEGER;
  
  -------------
  -- Constantes
  -------------
  VOWNER1 CONSTANT ALL_TAB_COLS.OWNER%TYPE      := UPPER( 
                                                     SUBSTR( '&&PROPIETARIO1',
                                                             1, 30 ) );
  VTABLA1 CONSTANT ALL_TAB_COLS.TABLE_NAME%TYPE := UPPER( 
                                                     SUBSTR( '&&TABLAOVISTA1',
                                                             1, 30 ) );

  VOWNER2 CONSTANT ALL_TAB_COLS.OWNER%TYPE      := UPPER( 
                                                     SUBSTR( '&&PROPIETARIO2',
                                                             1, 30 ) );
  VTABLA2 CONSTANT ALL_TAB_COLS.TABLE_NAME%TYPE := UPPER( 
                                                     SUBSTR( '&&TABLAOVISTA2',
                                                             1, 30 ) );
  VNULL  CONSTANT VARCHAR2(30) := 'SIN VALOR';
  ------------
  -- Variables
  ------------
  -- Variables para llenar las diferencias entre columnas
  plDistintoTipo     tDiferencias;
  plDistintaLongitud tDiferencias;
  plDistintoNulable  tDiferencias;

  -- Variable boleana que me indica si existen las dos tablas/vistas
  bExistenAmbas BOOLEAN;
  
  -----------
  -- Cursores
  -----------
  CURSOR cColumnasDistintoTipo IS
    SELECT A.COLUMN_NAME VCOLUMNA, -- Columna de la discordia

           -- Datos de la columna de la tabla 1
           NVL( A.DATA_TYPE, VNULL ) DATA_TYPE1, 
           TO_CHAR( A.DATA_LENGTH )  DATA_LENGTH1,
           NVL( A.NULLABLE,  VNULL ) NULLABLE1,

           -- Datos de la columna de la tabla 2
           NVL( B.DATA_TYPE, VNULL ) DATA_TYPE2, 
           TO_CHAR( B.DATA_LENGTH )  DATA_LENGTH2,
           NVL( B.NULLABLE,  VNULL ) NULLABLE2

    FROM   ALL_TAB_COLS A, ALL_TAB_COLS B
    WHERE  A.COLUMN_NAME = B.COLUMN_NAME
      AND  A.OWNER       = VOWNER1
      AND  A.TABLE_NAME  = VTABLA1
      AND  B.OWNER       = VOWNER2
      AND  B.TABLE_NAME  = VTABLA2
      AND  ( NVL( A.DATA_TYPE, VNULL )  != NVL( B.DATA_TYPE, VNULL ) OR
             A.DATA_LENGTH              != B.DATA_LENGTH             OR
             NVL( A.NULLABLE,  VNULL )  != NVL( B.NULLABLE,  VNULL ) 
            )
    ORDER BY A.COLUMN_ID;

  -----------------------------
  -- Funciones y procedimientos
  -----------------------------
  -- Di -------------------------------------------------------------
  PROCEDURE Di( cadena VARCHAR2 ) IS
    -- Procedimiento que hace un dbms_output.put_line cortando
    -- la cadena de entrada a 255 para evitar que de un error
    -- de línea demasiado larga.
  BEGIN
    DBMS_OUTPUT.PUT_LINE( SUBSTR( cadena, 1, 255 ) );
  END Di;

  -- diSeparador ----------------------------------------------------
  PROCEDURE diSeparador IS
    -- Procedimiento que escribe unas líneas que hacen las veces
    -- de separador de sección.
  BEGIN
    Di('.');
    Di('====================================================' );
  END;

  -- diDiferencia ---------------------------------------------------
  PROCEDURE diDiferencia( rDif tDiferencia ) IS 
    -- Procedimiento que escribe por pantalla una diferencia
  BEGIN
    Di( rDif.vColumna || '. En ' || VOWNER1 || '.' || VTABLA1 || ': ' || rDif.vValorA || ', ' 
                                 || VOWNER2 || '.' || VTABLA2 || ': ' || rDif.vValorB );
  END diDiferencia;
  
  -- diDiferencias -----------------------------------------------------------
  PROCEDURE diDiferencias( vDescri VARCHAR2, plDif tDiferencias ) IS 
    -- Procedimiento que escribe en pantalla la lista de diferencias
  BEGIN
    diSeparador();
    di( vDescri );

    IF plDif.LAST IS NOT NULL THEN 
      FOR nInd IN plDif.FIRST..plDif.LAST LOOP 
        diDiferencia( plDif( nInd ) );
      END LOOP;
    
    ELSE 
      Di( 'No ha diferencias' );
    END IF;
  END diDiferencias;

  -- agregaDiferencia -----------------------------------------------
  PROCEDURE agregaDiferencia( rDif tDiferencia, plDif IN OUT tDiferencias ) IS 
    -- Procedimiento que agrega una diferencia a una lista de diferencias.
    ------------
    -- Variables
    ------------
    -- Para el siguiente índice de la tabla
    nIndSiguiente BINARY_INTEGER;
  BEGIN
    IF plDif.LAST IS NULL THEN 
      -- La lista está vacía, me están pidiendo que agrege el primer elemento
      nIndSiguiente := 1;
    ELSE 
      nIndSiguiente := plDif.LAST + 1;
    END IF;

    plDif( nIndSiguiente ) := rDif;
  END agregaDiferencia;

  -- agregaDifSiExiste ----------------------------------------------
  PROCEDURE agregaDifSiExiste( vColumna        ALL_TAB_COLS.COLUMN_NAME%TYPE,
                               vValorA         VARCHAR2,
                               vValorB         VARCHAR2,
                               plDif    IN OUT tDiferencias
                             )
  IS 
    -- Procedimiento que agrega una diferencia si los valores son distintos
    ------------
    -- Variables
    ------------
    -- Variable de diferencia auxiliar
    rDifAux tDiferencia;
  BEGIN
    IF vValorA != vValorB THEN 
      rDifAux.vColumna := vColumna;
      rDifAux.vValorA  := vValorA;
      rDifAux.vValorB  := vValorB;

      agregaDiferencia( rDifAux, plDif );
    END IF;    
      
  END agregaDifSiExiste;

  -- diColumnasQueNoEstan -------------------------------------------
  PROCEDURE diColumnasQueNoEstan(
              vOwnerA ALL_TAB_COLS.OWNER%TYPE,
              vTablaA ALL_TAB_COLS.TABLE_NAME%TYPE,
              vOwnerB ALL_TAB_COLS.OWNER%TYPE,
              vTablaB ALL_TAB_COLS.TABLE_NAME%TYPE )
  IS
    -- Procedimiento que saca por pantalla la relación de columnas
    -- de la tabla o vista A que no están en la tabla o vista b

    -----------
    -- Cursores
    -----------
    -- Cursor que saca las columnas de la tabla o vista A
    -- que no están en la tabla o vista B
    CURSOR cNoColumnas  IS
      SELECT A.COLUMN_NAME
      FROM   ALL_TAB_COLS A
      WHERE  A.OWNER      = vOwnerA
        AND  A.TABLE_NAME = vTablaA
        AND  NOT EXISTS(
              SELECT 'X'
              FROM   ALL_TAB_COLS B
              WHERE  B.OWNER       = vOwnerB
                AND  B.TABLE_NAME  = vTablaB
                AND  B.COLUMN_NAME = A.COLUMN_NAME )
      ORDER BY A.COLUMN_ID;
  BEGIN
    diSeparador();

    Di( 'Columnas de '      || vOwnerA || '.' || vTablaA ||
        ' que no están en ' || vOwnerB || '.' || vTablaB ||
        ':');

    FOR rCol IN cNoColumnas LOOP
      Di( rCol.COLUMN_NAME );
    END LOOP;
  END diColumnasQueNoEstan;

  -- existeTablaOVista ---------------------------------------------------------
  FUNCTION existeTablaOVista( vPropietario VARCHAR2,
                              vTabla       VARCHAR2 ) 
  RETURN BOOLEAN IS 
    -- Función que comprueba se existe una tabla o vista con el propietario
    -- y nombre que le pasan como parámetro.
    ------------
    -- Variables
    ------------
    vAux VARCHAR2(1);
  BEGIN
    SELECT 'X'
    INTO   vAux
    FROM   ALL_OBJECTS 
    WHERE  OWNER       = vPropietario
      AND  OBJECT_NAME = vTabla 
      AND  OBJECT_TYPE IN ( 'TABLE', 'VIEW' );
    
    -- Si llego hasta aquí es que existe.
    RETURN TRUE;
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
      RETURN FALSE;
  END existeTablaOVista;

BEGIN
  -- Amplío el buffer del dbms_output para que no se quede pequeño
  DBMS_OUTPUT.DISABLE;
  DBMS_OUTPUT.ENABLE(10000000);
  
  IF existeTablaOVista( VOWNER1, VTABLA1 ) THEN  
    IF existeTablaOVista( VOWNER2, VTABLA2 ) THEN 
      bExistenAmbas := TRUE;
    ELSE 
      diSeparador();
      di( 'No existe la tabla o vista ' || VOWNER2 || '.' || VTABLA2 );
      bExistenAmbas := FALSE;
    END IF;
  ELSE 
    diSeparador();
    di( 'No existe la tabla o vista ' || VOWNER1 || '.' || VTABLA1 );
    bExistenAmbas := FALSE;
  END IF;

  -- Sólo continúo si existen ambas tablas:
  IF bExistenAmbas THEN
    
    -- Columnas de la tabla 1 que no están en la tabla 2
    diColumnasQueNoEstan( VOWNER1, VTABLA1, VOWNER2, VTABLA2 );

    -- Columnas de la tabla 2 que no están en la tabla 1
    diColumnasQueNoEstan( VOWNER2, VTABLA2, VOWNER1, VTABLA1 );

    -- Ahora recopilo las diferencias en las columnas que sí están en las dos
    -- tablas o vistas.
    FOR rDife IN cColumnasDistintoTipo LOOP 
      agregaDifSiExiste( rDife.VCOLUMNA, rDife.DATA_TYPE1, rDife.DATA_TYPE2, 
                         plDistintoTipo );
      
      agregaDifSiExiste( rDife.VCOLUMNA, rDife.DATA_LENGTH1, rDife.DATA_LENGTH2, 
                         plDistintaLongitud );

      agregaDifSiExiste( rDife.VCOLUMNA, rDife.NULLABLE1, rDife.NULLABLE2, 
                         plDistintoNulable );
    END LOOP;

    -- Pinto la lista de diferencias por cada tipo
    diDiferencias( 'Diferencias de tipo:',     plDistintoTipo );
    diDiferencias( 'Diferencias de longitud:', plDistintaLongitud );
    diDiferencias( 'Diferencias de nulable:',  plDistintoNulable );
  END IF;
END;
/
SET VERIFY ON 

