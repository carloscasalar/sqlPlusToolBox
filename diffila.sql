-- 15/06/2010
-- Script que al ejecutarlo devuevle un esqueleto de consulta para ver
-- las diferencias entre dos filas de la misma tabla o entre dos
-- filas de tablas con columnas similares
ACCEPT TABLA_MODELO PROMPT "Tabla modelo: "
SET SERVEROUTPUT ON
SET TRIMSPOOL ON
DECLARE

  --------------
  -- Constantes
  -------------
  TABLA_MODELO CONSTANT ALL_TAB_COLS.COLUMN_NAME%TYPE := UPPER('&TABLA_MODELO');

  -------------
  -- Variables
  -------------
  vComa     VARCHAR2(1);
  vCabecera VARCHAR2(4000);
  nLonMax   NUMBER(5) := 0;

  ------------
  -- Cursores
  ------------
  -- Cursor que recorre las columnas de la tabla modelo
  CURSOR cColumnas IS
    SELECT COLUMN_NAME
    FROM   ALL_TAB_COLS
    WHERE  OWNER=USER
      AND  TABLE_NAME = TABLA_MODELO
    ORDER BY COLUMN_ID;
  ------------------------------
  -- Procedimientos y funciones
  ------------------------------
  -- di ------------------------------------------------------------------------
  PROCEDURE di( vcosa VARCHAR2 ) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(SUBSTR(vcosa, 1, 255) );
  END di;

  -- di ------------------------------------------------------------------------
  PROCEDURE di( nTab NUMBER, vCosa VARCHAR2 ) IS
    -- Manda por output la cadena indicada con las tabulaciones indicadas.
    -- Cada tabulación se materializa como dos espacios en blanco
    -------------
    -- Variables
    -------------
    vTabulacion VARCHAR2(200);
  BEGIN
    FOR i IN 1..LEAST( nTab, 100 ) LOOP
      vTabulacion := vTabulacion || '  ';
    END LOOP;

    di( vTabulacion || vCosa );
  END di;

  -- vComponerTitulo ---------------------------------------------------------
  FUNCTION vComponerTitulo( vNombreColumna VARCHAR2 ) RETURN VARCHAR2 IS
    -- Compone el nombre de la columna anteponiendo la partícula DIF_
    -- y cortando a 30 caracteres
  BEGIN
    RETURN SUBSTR( 'DIF_' || vNombreColumna, 1, 30 );
  END vComponerTitulo;

BEGIN
  DBMS_OUTPUT.DISABLE;
  DBMS_OUTPUT.ENABLE(10000000);

  -- Compongo la cabecera
  FOR rCol IN cColumnas LOOP
    IF vCabecera IS NOT NULL THEN
      vCabecera := vCabecera || ';';
    END IF;

    vCabecera := vCabecera || vComponerTitulo( rCol.COLUMN_NAME );

    -- Cada columna ocupa 9 caracteres más el espacio
    nLonMax := nLonMax + 10;
  END LOOP;

  di( 'SET LINESIZE ' || TO_CHAR( nLonMax ) );
  di( vCabecera );
  di( 'SELECT' );
  FOR rCol IN cColumnas LOOP
    di( 1, vComa ||
           'CAST( DECODE( A1.' || rCol.COLUMN_NAME || ', ' ||
                         'A2.' || rCol.COLUMN_NAME || ', ' ||
                         '''Iguales'', ''Distintos'') ' ||
           ' AS VARCHAR2(9) ) AS ' ||
           vComponerTitulo( rCol.COLUMN_NAME ) );

    -- Si hay más de una columna nos aseguramos que las siguiente interponga una
    -- coma entre ambas
    IF vComa IS NULL THEN
      vComa := ',';
    END IF;

  END LOOP;

  di( 'FROM ' );


END;
/
