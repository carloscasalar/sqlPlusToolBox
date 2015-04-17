-- Secciones comunes de código

  DBMS_OUTPUT.DISABLE;
  DBMS_OUTPUT.ENABLE(10000000);

--SERVEROUT[PUT] {OFF|ON} [SIZE n] [FOR[MAT] {WRA[PPED]|WOR[D_WRAPPED]|TRU[NCATED]}]

  ------------------------------
  -- Procedimientos y funciones
  ------------------------------
  -- di ------------------------------------------------------------------------
  PROCEDURE di( vcosa VARCHAR2 ) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(SUBSTR(vcosa, 1, 255) );
  END di;

  -- di ------------------------------------------------------------------------
  PROCEDURE di( nTabulaciones NUMBER, vcosa VARCHAR2 ) IS
    --------------
    -- Constantes
    --------------
    CADENA_TAB   CONSTANT VARCHAR2(2) := '..';

    -------------
    -- Variables
    -------------
    vCadenaTAB VARCHAR2(100);
  BEGIN
    FOR i IN 1..LEAST( nTabulaciones, 50 ) LOOP
      vCadenaTAB := vCadenaTAB || CADENA_TAB;
    END LOOP;
    di( vCadenaTAB || vcosa );
  END di;

  -- diSeparador ---------------------------------------------------------------
  PROCEDURE diSeparador IS
  BEGIN
    di( '===================================================================');
  END diSeparador;

  -- di ------------------------------------------------------------------------
  PROCEDURE di( cBuffer CLOB, vCosa VARCHAR2 ) IS
  BEGIN
    DBMS_LOB.WRITEAPPEND( cBuffer,
                          LENGTH( vCosa || CHR(10) ),
                          vCosa || CHR(10) );
  END di;

  -- vEnmascarar ---------------------------------------------------------------
  FUNCTION vEnmascarar( vCosa VARCHAR2 ) RETURN VARCHAR2 IS
    -- Función para enmascarar palabras
  BEGIN
    RETURN REPLACE( vCosa, SUBSTR( vCosa, 1, 4), '****' );
  END vEnmascarar;

  -- diTiempo ------------------------------------------------------------------
  PROCEDURE diTiempo ( nIni   IN NUMBER,
                       nFin   IN NUMBER,
                       vTexto IN VARCHAR2 := NULL )
  IS
    -- Para usar en conjunción con Dbms_Utility.Get_Time
  BEGIN
    di(  vTexto ||
         LPAD ( TO_CHAR ( ((nFin-nIni)/100), 9999.9 ), 15 ) ||
         ' Segundos' );
  END diTiempo;


-- Para crear el clob con ámbito sólo de la llamada
  DBMS_LOB.CREATETEMPORARY( lob_loc => cSalida,
                            cache   => TRUE,
                            dur     => DBMS_LOB.CALL );

-- Para hacer el di usando un clob
VAR SPOL CLOB
SET LONG 100000000
SET PAGES 50000
SET LINESIZE 255
COLUMN SALIDA FORMAT A255
SELECT :SPOL AS SALIDA FROM DUAL;



-- Hacer un clob y meterle datos
DECLARE
  cXML CLOB := EMPTY_CLOB;

BEGIN
  Dbms_Lob.CreateTemporary( cXML, TRUE, Dbms_Lob.SESSION );
  Dbms_Lob.Append( cXML, '<?xml');
END;
/


  -- Lob_Replace
  -- @link http://www.astral-consultancy.co.uk/cgi-bin/hunbug/doco.cgi?11080
  FUNCTION dfn_clobReplace(
              p_clob          IN CLOB,
              p_what          IN VARCHAR2,
              p_with          IN VARCHAR2 )
  RETURN CLOB IS

    c_whatLen       CONSTANT PLS_INTEGER := LENGTH(p_what);
    c_withLen       CONSTANT PLS_INTEGER := LENGTH(p_with);

    l_return        CLOB;
    l_segment       CLOB;
    l_pos           PLS_INTEGER := 1-c_withLen;
    l_offset        PLS_INTEGER := 1;

  BEGIN

    IF p_what IS NOT NULL THEN
      WHILE l_offset < DBMS_LOB.GETLENGTH(p_clob) LOOP
        l_segment := DBMS_LOB.SUBSTR(p_clob,32767,l_offset);
        LOOP
          l_pos := DBMS_LOB.INSTR(l_segment,p_what,l_pos+c_withLen);
          EXIT WHEN (NVL(l_pos,0) = 0) OR (l_pos = 32767-c_withLen);
          l_segment := TO_CLOB( DBMS_LOB.SUBSTR(l_segment,l_pos-1)
                              ||p_with
                              ||DBMS_LOB.SUBSTR(l_segment,32767-c_whatLen-l_pos-c_whatLen+1,l_pos+c_whatLen));
        END LOOP;
        l_return := l_return||l_segment;
        l_offset := l_offset + 32767 - c_whatLen;
      END LOOP;
    END IF;

    RETURN(l_return);

  END dfn_clobReplace;

-------------------------------------------------------------------------------
  TYPE tListaCodigos IS TABLE OF VARCHAR2(50) INDEX BY BINARY_INTEGER;
  -- Procedimiento addCodigo --------------------------------------------------
  PROCEDURE addCodigo( rLista IN OUT tListaCodigos, vCodigo VARCHAR2 ) IS
    -- Procedimiento que añade un código nuevo a una lista de códigos
    -------------
    -- Variables
    -------------
    nSiguiente BINARY_INTEGER;
  BEGIN
    nSiguiente := NVL( rLista.LAST, 0 ) + 1;
    rLista( nSiguiente ) := vCodigo;
  END addCodigo;
